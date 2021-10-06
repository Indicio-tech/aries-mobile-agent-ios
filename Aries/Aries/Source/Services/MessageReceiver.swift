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
    
    private var arrayOfMessages = [BaseMessage]()
    
    public func receiveMessage(message: Data) {
        let decoder = JSONDecoder()
        do {
            
            let typeContainer = try decoder.decode(BaseMessage.self, from: message)
            
            var messageToBeAdded: BaseMessage?
            
            switch typeContainer.type {
            case .baseMessage:
                fatalError("We don't get base messages here!")
            case .invitationMessage:
                messageToBeAdded = try decoder.decode(InvitationMessage.self, from: message)
                // 38
            }
            
            if let messageToBeAdded = messageToBeAdded {
                arrayOfMessages.append(messageToBeAdded)
            }
            
        } catch {
            print(error)
        }
//        if let messageString = String(data: message, encoding: .utf8){
//            print("Message received: " + messageString)
//        }
    }
}
