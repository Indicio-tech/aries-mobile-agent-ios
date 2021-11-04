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
                DispatchQueue.global(qos: .default).async {
                    do {
                        print("Unpacked Message: \(String(data: data, encoding: .utf8)!)")
                        let decoder = JSONDecoder()
                        let unpackedMessage = try decoder.decode(IndyUnpackedMessage.self, from: data)
                        let parsedString = self.parseDecorators(message: unpackedMessage.message)
                        let payload = parsedString.data(using: .utf8)!
                        let typeContainer = try decoder.decode(TypeContainerMessage.self, from: payload)
                        let type = typeContainer.type
                        print("Unpacked Message: \(unpackedMessage)")
                        self.triggerEvent(type: type, payload: payload, senderVerkey: unpackedMessage.senderVerkey)
                    } catch {
                        print("Failed to decode...\(error)")
                    }
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
                    for object in objects { //Loop through, check if elements have the ~sig suffix
                        if object.key.hasSuffix("~sig"){
                            let signatureElements = try JSONSerialization.data(withJSONObject: object.value, options: .prettyPrinted)
                            let signatureDecorator = try decoder.decode(SignatureDecorator.self, from: signatureElements)
                            
                            let isValid = self.wallet.verify(signature: signatureDecorator.signature, message: signatureDecorator.sigData, key: signatureDecorator.signer)
                            if isValid {
                                print("Validated, preparing return string")
                                var returnString = message.replacingOccurrences(of: "~sig", with: "") // Search message, strip out ~sig
                                returnString = returnString.replacingOccurrences(of: signatureDecorator.sigData, with: signatureDecorator.sigData.dropFirst(8)) // Search message, strip first 8 bytes
                                return returnString
                            } else {
                                print("Signature was not validated")
                            }
                        }
                    }
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
