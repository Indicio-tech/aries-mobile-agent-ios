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
                    do {
                        print("Unpacked Message: \(String(data: data, encoding: .utf8)!)")
                        let decoder = JSONDecoder()
                        let parsedString = self.parseDecorators(message: String(data: data, encoding: .utf8)!)
                        print("Parsed String:   >>>> \(parsedString)")
                        let unpackedMessage = try decoder.decode(IndyUnpackedMessage.self, from: parsedString.data(using: .utf8)!)
                        let typeContainer = try decoder.decode(TypeContainerMessage.self, from: unpackedMessage.message.data(using: .utf8)!)
                        let type = typeContainer.type
                        print(unpackedMessage.message)
                        self.triggerEvent(type: type, payload: unpackedMessage.message.data(using: .utf8)!, senderVerkey: unpackedMessage.senderVerkey)
                    } catch {
                        print("Failed to decode...\(error)")
                    }
            }
        }
    }
    
    private func parseDecorators(message: String) -> String {
        
        let decoder = JSONDecoder()
        var unpackedMessage: IndyUnpackedMessage
        
        guard let jsonData = message.data(using: .utf8) else {
            print("Unable to decode...")
            return message //Need to extend this to actually handle the error.
        }
        
        do {
            unpackedMessage = try decoder.decode(IndyUnpackedMessage.self, from: jsonData)
        } catch {
            print("Unable to decode...")
            return message //Need to extend this to actually handle the error.
        }
                
        if unpackedMessage.message.contains("~sig"){
            print("Signed message detected...")
            do {
                let signatureDecoratorData = unpackedMessage.message.data(using: .utf8)!
                if let objects = try JSONSerialization.jsonObject(with: signatureDecoratorData, options: []) as? [String:Any] {
                    var mutatedObject = objects
                    for object in objects { //Loop through, check if elements have the ~sig suffix
                        if object.key.hasSuffix("~sig"){
                            let signatureElements = try JSONSerialization.data(withJSONObject: object.value, options: .prettyPrinted)
                            let signatureDecorator = try decoder.decode(SignatureDecorator.self, from: signatureElements)
                            
//                            let newSigData = String(data: Data(base64Encoded: signatureDecorator.sigData)!, encoding: .utf8)
//                            print("Set new sigData \(newSigData)")
                            print("Signature ---> \(signatureDecorator.signature)")
                            
                            var newSignature = signatureDecorator.signature.replacingOccurrences(of: "-", with: "+")
                            newSignature = newSignature.replacingOccurrences(of: "_", with: "/")
                            while newSignature.count % 4 != 0 {
                                       newSignature = newSignature.appending("=")
                            }
                            let signature = Data(base64Encoded: newSignature)!
                            let signer = signatureDecorator.signer
                            let sigData = Data(base64Encoded: signatureDecorator.sigData)!
                            
                            let isValid = self.wallet.verify(signature: signature, message: sigData , key: signer)
                            if isValid {
                                print("Validated, preparing return string")
                                let newKey = object.key.replacingOccurrences(of: "~sig", with: "")
                                
                                mutatedObject[newKey] = String(data: Data(base64Encoded: signatureDecorator.sigData)!.dropFirst(8), encoding: .utf8)
                            } else {
                                print("Signature was not validated")
                            }
                        }
                    }
                    return String(data: try! JSONSerialization.data(withJSONObject: mutatedObject, options: .prettyPrinted), encoding: .utf8)!
                } else {
                    print("Unable to decode decorator data...")
                }
                print("No signature detected, returning with unmodified message.")
                return message
            } catch {
                print("No signature detected, returning with unmodified message.")
                return message
            }
        } else {
            return message
        }
    }
}
