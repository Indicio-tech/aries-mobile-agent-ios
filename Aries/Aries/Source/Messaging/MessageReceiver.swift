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
                    
                    
                    
                    let unpackedMessage = try decoder.decode(IndyUnpackedMessage.self, from: data)
                    let payload = unpackedMessage.message.data(using: .utf8)!
                    let typeContainer = try decoder.decode(TypeContainerMessage.self, from: payload)
                    let type = typeContainer.type
                    self.triggerEvent(type: type, payload: payload, senderVerkey: unpackedMessage.senderVerkey)
                } catch {
                    print("Failed to decode...\(error)")
                }
                
            }
        }
    }
    
    private func parseDecorators(message: String) -> String {
        let decoder = JSONDecoder()
        let jsonData = message.data(using: .utf8)!
        let unpackedMessage = try! decoder.decode(IndyUnpackedMessage.self, from: jsonData)
        
        if unpackedMessage.message.contains("~sig"){
            do {
                let signatureDecoratorData = unpackedMessage.message.data(using: .utf8)!
                if let objects = try JSONSerialization.jsonObject(with: signatureDecoratorData, options: []) as? [String:Any] {
                    for object in objects {
                        if object.key.hasSuffix("~sig"){
                            let signatureElements = try JSONSerialization.data(withJSONObject: object.value, options: .prettyPrinted)
                            let signatureDecorator = try decoder.decode(SignatureDecorator.self, from: signatureElements)
//                            Attempt Decode
                            self.wallet.verify(signature: signatureDecorator.signature, message: signatureDecorator.sigData, key: signatureDecorator.signer) { result in
                                switch result {
                                case .success(let validated):
                                    if validated{
                                        print("Validated")
                                    } else {
                                        print("Invalid")
                                    }
                                case .failure(let error):
                                    print("IndyError: \(error)")
                                }
                            }
//                        Stop looping if the ~sig element has been decoded.
                          break
                        }
                    }
                } else {
                    print("failed")
                }
                
                return message
            } catch {
                return message
            }
        } else {
            return message
        }
    }
}
