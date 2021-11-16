//
//  MessageReceiver.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation
public class MessageReceiver{
    
    private let wallet:AriesWallet
    
    public init(wallet: AriesWallet){
        self.wallet = wallet
    }
    
    //Event emitter
    
    private var callbacks: [ (_ messageType: MessageType, _ payload: Data, _ senderVerkey: String)->Void] = []
    
    public func subscribeToEvents(callback: @escaping (_ messageType: MessageType, _ payload: Data, _ senderVerkey: String)->Void){
        callbacks.append(callback)
    }
    
    private func triggerEvent(type: MessageType, payload: Data, senderVerkey: String){
        for callback in self.callbacks{
            //Call each function asynchronously
            DispatchQueue.global().async {
                callback(type, payload, senderVerkey)
            }
        }
    }
    
    public func receiveMessage(message: Data) {
        
        print("**** Message Received: ***")
        
        //Receive packed message: Data
        
        //Unpack message with IndyWallet
        print("**** Unpacking message: ***")
        wallet.unpackMessage(message: message) { result in
            switch result {
            case .failure(let error):
                print("Failed to unpack... \(error)")
            case .success(let data):
                
                print("Unpacked Message: \(String(data: data, encoding: .utf8)!)")
                let decoder = JSONDecoder()
                
                self.parseDecorators(message: String(data: data, encoding: .utf8)!) { result in
                    switch result {
                    case .failure(let error):
                        print("\(error.localizedDescription)")
                    case .success(let parsedMessage):
                        print("Parsed String:   >>>> \(parsedMessage)")
                        let typeContainer = try! decoder.decode(TypeContainerMessage.self, from: parsedMessage.message.data(using: .utf8)!)
                        let type = typeContainer.type
                        print(parsedMessage.message)
                        self.triggerEvent(type: type, payload: parsedMessage.message.data(using: .utf8)!, senderVerkey: parsedMessage.senderVerkey)
                    }
                    return String()
                }
            }
        }
    }
    
    private func parseDecorators(message: String, completion: @escaping (_ string: Result<IndyUnpackedMessage, Error>)->String) {
        
        let decoder = JSONDecoder()
        var unpackedMessage: IndyUnpackedMessage
        
        do {
            if let jsonData = message.data(using: .utf8) {
                unpackedMessage = try decoder.decode(IndyUnpackedMessage.self, from: jsonData)
                if unpackedMessage.message.contains("~sig"){
                    print("Signed message detected...")
                    do {
                        guard let signatureDecoratorData = unpackedMessage.message.data(using: .utf8) else {
                            throw MessageReceiverError.failedToDecode
                        }
                        if let objects = try JSONSerialization.jsonObject(with: signatureDecoratorData, options: []) as? [String:Any] {
                            var mutatedObject = objects
                            for object in objects { //Loop through, check if elements have the ~sig suffix
                                if object.key.hasSuffix("~sig"){
                                    let signatureElements = try JSONSerialization.data(withJSONObject: object.value, options: .prettyPrinted)
                                    let signatureDecorator = try decoder.decode(SignatureDecorator.self, from: signatureElements)
                                    
                                    print("Signature ---> \(signatureDecorator.signature)")
                                    
                                    let newSignature = base64UrlTobase64(string: signatureDecorator.signature)
                                    guard let signature = Data(base64Encoded: newSignature) else {
                                        return
                                    }
                                    
                                    let sigData = Data(base64Encoded: signatureDecorator.sigData)!
                                    
                                    self.wallet.verify(signature: signature, message: sigData, key: signatureDecorator.signer) { result in
                                        switch result{
                                        case .failure(let error):
                                            print("Signature was not validated \(error.localizedDescription)")
                                        case .success(let result):
                                            if result {
                                                print("Validated, preparing return string")
                                                let newKey = object.key.replacingOccurrences(of: "~sig", with: "")
                                                mutatedObject[newKey] = String(data: Data(base64Encoded: signatureDecorator.sigData)!.dropFirst(8), encoding: .utf8)
                                            }
                                        }
                                    }
                                }
                            }
                            let serializedData = try JSONSerialization.data(withJSONObject: mutatedObject, options: .prettyPrinted)
                            
                            let encodedString = String(data: serializedData, encoding: .utf8)
                            if let returnString = encodedString {
                                var returnMessage = IndyUnpackedMessage(message: returnString, recipientVerkey: unpackedMessage.recipientVerkey, senderVerkey: unpackedMessage.senderVerkey)
                                completion(.success(returnMessage))
                            }
                            
                        } else {
                            // JSONSerialization failed
                            completion(.failure(MessageReceiverError.failedToDecode))
                            print("Unable to decode decorator data...")
                        }
                    } catch {
                        print("No signature detected, returning with unmodified message.")
                        completion(.failure(MessageReceiverError.failedToDecode))
                    }
                } else {
                    //no signed messages found
                    let jsonData = message.data(using: .utf8)!
                    let returnMessage = try decoder.decode(IndyUnpackedMessage.self, from: jsonData)
                    completion(.success(returnMessage))
                }
            } else {
                completion(.failure(MessageReceiverError.failedToDecode))
            }
        } catch {
            print("Unable to decode...")
            completion(.failure(MessageReceiverError.failedToDecode))
        }
        
        func base64UrlTobase64(string:String) -> String {
            var returnString = string.replacingOccurrences(of: "-", with: "+")
            returnString = returnString.replacingOccurrences(of: "_", with: "/")
            while returnString.count % 4 != 0 {
                returnString = returnString.appending("=")
            }
            return returnString
        }
        
    }
    
    enum MessageReceiverError: Error {
        case failedToDecode
    }
    
}
