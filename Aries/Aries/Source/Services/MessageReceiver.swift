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
        print(message)
        
        //Receive packed message: Data
        
        //Unpack message with IndyWallet
        print("**** Unpacking message: ***")
        wallet.unpackMessage(message: message) { result in
            switch result {
            case .failure(let error):
                print("Failed to unpack... \(error)")
            case .success(let data):
                do {
                    print(String(data: data, encoding: .utf8)!)
                    let decoder = JSONDecoder()
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
        
        //Emmit an event
        //Event object? (type: MessageType, message: Data)
        
        
        
//        do {
//
//            let typeContainer = try decoder.decode(BaseMessage.self, from: message)
//
//            switch typeContainer.type {
//                case .baseMessage:
//                    fatalError("We don't get base messages here!")
//                case .invitationMessage:
//                    let invitationMessage = try decoder.decode(InvitationMessage.self, from: message)
//
//            }
//
//        } catch {
//            print(error)
//        }
    }
}
