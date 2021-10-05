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
    
    public func receiveMessage(message: Data){
        if let messageString = String(data: message, encoding: .utf8){
            print("Message received: " + messageString)
        }
    }
}
