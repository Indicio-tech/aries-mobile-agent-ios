//
//  Agent.swift
//  Aries
//
//  Created by David Clawson on 9/16/21.
//

import Foundation
import Indy

public class AriesAgent {
    private var ariesWallet: AriesWallet
    private var messageSender: MessageSender
    private var messageReceiver: MessageReceiver
    private var storage: Storage
    public var connections: AriesConnections
    
//  For this implementation, we're using a default wallet with the "default" identifier and "password" as the key.
//  We'll set up the ability to set/change passwords in later versions.
    
    public init(completion: @escaping (_ result: Result<Void, Error>)->Void){
        ariesWallet = AriesWallet(){ result in
            switch(result){
            case(.success()):
                completion(.success(()))
            case(.failure(let e)):
                print(e.localizedDescription)
                completion(.failure(e))
            }
        }
        self.messageReceiver = MessageReceiver(wallet: self.ariesWallet)
        self.messageSender = MessageSender(ariesWallet: self.ariesWallet, messageReceiver: self.messageReceiver)
        self.storage = Storage(ariesWallet: self.ariesWallet)
        self.connections = AriesConnections(ariesWallet: self.ariesWallet, messageSender: self.messageSender, storage: self.storage)
        
        //Register event listeners
        self.messageReceiver.subscribeToEvents(callback: connections.eventListener)
    
    }

    func deleteWallet(){
//        wallet.deleteWallet(id: "default", key: "password")
    }
    
    
    
}
