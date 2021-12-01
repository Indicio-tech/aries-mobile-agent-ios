//
//  Agent.swift
//  Aries
//
//  Created by David Clawson on 9/16/21.
//

import Foundation
import Indy

public class AriesAgent {
    private var agentId: String
    private var walletKey: String
    private var adminInvitationUrl: String?
    private var ariesWallet: AriesWallet!
    private var messageSender: MessageSender!
    private var messageReceiver: MessageReceiver!
    private var storage: Storage!
    public var events: AriesEvents!
    public var connections: AriesConnections!
    public var initialized: Bool
    public var admin: Admin!
    
//  For this implementation, we're using a default wallet with the "default" identifier and "password" as the key.
//  We'll set up the ability to set/change passwords in later versions.
    
    public init(agentId: String = "default", walletKey: String = "password", adminInvitationUrl: String? = nil){
        self.initialized = false
        self.agentId = agentId
        self.walletKey = walletKey
        self.adminInvitationUrl = adminInvitationUrl
    }
    
    public func start(completion: @escaping (_ result: Result<Void, Error>)->Void){
        self.ariesWallet = AriesWallet(id: self.agentId, key: self.walletKey){ result in
            switch(result){
            case(.success()):
                
                //Connected to Indy, now create modules
                self.events = AriesEvents()
                self.messageReceiver = MessageReceiver(wallet: self.ariesWallet)
                self.messageSender = MessageSender(ariesWallet: self.ariesWallet, messageReceiver: self.messageReceiver)
                self.storage = Storage(ariesWallet: self.ariesWallet, events: self.events)
                self.connections = AriesConnections(ariesWallet: self.ariesWallet, messageSender: self.messageSender, storage: self.storage)
                
                //Register internal event listeners to message receiver
                self.messageReceiver.subscribeToEvents(callback: self.connections.eventListener)
                
                self.admin = Admin(messageSender: self.messageSender, storage: self.storage, connections: self.connections, events: self.events, adminInvitationUrl: self.adminInvitationUrl)
                self.initialized = true
                completion(.success(()))
            case(.failure(let e)):
                print(e.localizedDescription)
                completion(.failure(e))
            }
        }
    }

    func deleteWallet(){
//        wallet.deleteWallet(id: "default", key: "password")
    }
    
    
    
}
