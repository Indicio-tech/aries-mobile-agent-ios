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
    
    private var callbacks: [ (_ messageType: MessageType, _ payload: String)->Void] = []
    
    public func subscribeToEvents(callback: @escaping (_ messageType: MessageType, _ payload: String)->Void){
        callbacks.append(callback)
    }
    
    private func triggerEvent(type: MessageType, payload: String){
        for callback in self.callbacks{
            //Call each function asynchronously
            DispatchQueue.global().async {
                callback(type, payload)
            }
        }
    }
    
    public func receiveMessage(message: Data) {
        //Receive packed message: Data
        
        //Unpack message with IndyWallet
//        let messageData = IndyWallet.unpack(message)
//        //Get type of message
//        let decoder = JSONDecoder()
//        let typeContainer = try decoder.decode(BaseMessage.self, from: message)
//        let type = typeContainer.type
        
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
