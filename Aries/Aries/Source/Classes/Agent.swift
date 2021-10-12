//
//  Agent.swift
//  Aries
//
//  Created by David Clawson on 9/16/21.
//

import Foundation
import Indy

public class Agent {
    private var ariesWallet: AriesWallet
    
//  For this implementation, we're using a default wallet with the "default" identifier and "password" as the key.
//  We'll set up the ability to set/change passwords in later versions.
    
    public init(){
        ariesWallet = AriesWallet(){ result in
            switch(result){
            case(.success()):
                print("Wallet opened")
            case(.failure(let e)):
                print(e.localizedDescription)
            }
        }
    }

    func deleteWallet(){
//        wallet.deleteWallet(id: "default", key: "password")
    }
    
    
    
}
