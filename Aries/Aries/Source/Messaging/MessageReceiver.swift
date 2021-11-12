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
                
                let parsedString = self.parseDecorators(message: String(data: data, encoding: .utf8)!) { result in
                    switch result {
                    case .failure(let error):
                        print("\(error.localizedDescription)")
                    case .success(let string):
                        print("Parsed String:   >>>> \(string)")
                        let unpackedMessage = try! decoder.decode(IndyUnpackedMessage.self, from: string.data(using: .utf8)!)
                        let typeContainer = try! decoder.decode(TypeContainerMessage.self, from: unpackedMessage.message.data(using: .utf8)!)
                        let type = typeContainer.type
                        print(unpackedMessage.message)
                        self.triggerEvent(type: type, payload: unpackedMessage.message.data(using: .utf8)!, senderVerkey: unpackedMessage.senderVerkey)
                    }
                }
            }
        }
    }
    
    private func parseDecorators(message: String, completion: @escaping (_ string: Result<String, Error>)->String) {
        
        let decoder = JSONDecoder()
        var unpackedMessage: IndyUnpackedMessage
        
        guard let jsonData = message.data(using: .utf8) else {
            print("Unable to decode...")
            completion(.failure(MessageReceiverError.failedToDecode))
        }
        
        do {
            unpackedMessage = try decoder.decode(IndyUnpackedMessage.self, from: jsonData)
        } catch {
            print("Unable to decode...")
            completion(.failure(MessageReceiverError.failedToDecode))
        }
        
        if unpackedMessage.message.contains("~sig"){
            print("Signed message detected...")
            do {
                guard let signatureDecoratorData = unpackedMessage.message.data(using: .utf8) else {
                    completion(.failure(MessageReceiverError.failedToDecode))
                }
                if let objects = try JSONSerialization.jsonObject(with: signatureDecoratorData, options: []) as? [String:Any] {
                    var mutatedObject = objects
                    for object in objects { //Loop through, check if elements have the ~sig suffix
                        if object.key.hasSuffix("~sig"){
                            let signatureElements = try JSONSerialization.data(withJSONObject: object.value, options: .prettyPrinted)
                            let signatureDecorator = try decoder.decode(SignatureDecorator.self, from: signatureElements)
                            
                            print("Signature ---> \(signatureDecorator.signature)")
                            
                            //                          This should probably be extracted as an extension. Converting base64url to base64.
                            var newSignature = signatureDecorator.signature.replacingOccurrences(of: "-", with: "+")
                            newSignature = newSignature.replacingOccurrences(of: "_", with: "/")
                            while newSignature.count % 4 != 0 {
                                newSignature = newSignature.appending("=")
                            }
                            guard let signature = Data(base64Encoded: newSignature) else {
                                return
                            }
                            let signer = signatureDecorator.signer
                            let sigData = Data(base64Encoded: signatureDecorator.sigData)!
                            
                            self.wallet.verify(signature: signature, message: sigData, key: signer) { result in
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
                    guard let encodedString = String(data: serializedData, encoding: .utf8) else {
                        completion(.failure(MessageReceiverError.failedToDecode))
                    }
                    completion(.success(encodedString))
                } else {
//                    JSONSerialization failed
                    completion(.failure(MessageReceiverError.failedToDecode))
                    print("Unable to decode decorator data...")
                }
            } catch {
                print("No signature detected, returning with unmodified message.")
                completion(.failure(MessageReceiverError.failedToDecode))
            }
        } else {
            //            no signed messages found
            //            _ = self.complete(message: message, completion: { Result<String, Error> in })
            completion(.success(message))
        }
    }
    
    enum MessageReceiverError: Error {
        case failedToDecode
    }
    
    
}
