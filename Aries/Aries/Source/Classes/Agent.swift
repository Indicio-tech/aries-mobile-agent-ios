//
//  Agent.swift
//  Aries
//
//  Created by David Clawson on 9/16/21.
//

import Foundation
import Indy

public class Agent {
    
    static let sharedAgent = Agent()
    
//  For this implementation, we're using a default wallet with the "default" identifier and "password" as the key.
//  We'll set up the ability to set/change passwords in later versions.
    
    func setupWallet(){
//        let wallet = AriesWallet.wallet
//        wallet.setupWallet()
    }

    func deleteWallet(){
//        let wallet = AriesWallet.wallet
//        wallet.deleteWallet(id: "default", key: "password")
    }
    
    
    
}
