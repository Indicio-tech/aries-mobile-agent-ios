//
//  Agent.swift
//  Aries
//
//  Created by David Clawson on 9/16/21.
//

import Foundation
import Indy

public class AriesAgent {
    private var ariesWallet: AriesWallet? = nil
    private var messageSender: MessageSender? = nil
    private var messageReceiver: MessageReceiver? = nil
    private var storage: Storage? = nil
    public var connections: AriesConnections? = nil
    
//  For this implementation, we're using a default wallet with the "default" identifier and "password" as the key.
//  We'll set up the ability to set/change passwords in later versions.
    
    public init(completion: @escaping (_ result: Result<Void, Error>)->Void){
        ariesWallet = AriesWallet(){ result in
            switch(result){
            case(.success()):
                print("Wallet opened")
                self.messageReceiver = MessageReceiver(wallet: self.ariesWallet!)
                self.messageSender = MessageSender(ariesWallet: self.ariesWallet!, messageReceiver: self.messageReceiver!)
                self.storage = Storage(ariesWallet: self.ariesWallet!)
                self.connections = AriesConnections(ariesWallet: self.ariesWallet!, messageSender: self.messageSender!, storage: self.storage!)
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
