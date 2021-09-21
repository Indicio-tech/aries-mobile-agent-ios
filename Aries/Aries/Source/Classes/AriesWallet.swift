//
//  Wallet.swift
//  Aries
//
//  Created by David Clawson on 9/17/21.
//

import Foundation
import Indy

public class AriesWallet {

    private static let ariesWalletSharedInstance = IndyWallet.sharedInstance()
    
    public func createWallet(id: String, key: String){
        
        let configDict = ["id":id]
        let credentialsDict = ["key":key]
        var configString = ""
        var credentialsString = ""
        
        if let JSONData = try? JSONSerialization.data(withJSONObject: configDict, options: []){
            configString = String(data: JSONData, encoding: .ascii)!
            print(configString)
        }
        if let JSONData = try? JSONSerialization.data(withJSONObject: credentialsDict, options: []){
            credentialsString = String(data: JSONData, encoding: .ascii)!
            print(credentialsString)
        }
        
        if let sharedInstance = AriesWallet.ariesWalletSharedInstance {
            sharedInstance.createWallet(withConfig: configString, credentials: credentialsString) { err in
                print(err.debugDescription)
            }
        }
    }
    
    
    
    
}

// AMA-Android
// Instantiated with a JSON string. I think we should be able to just use the wallet name and password
// It creates a new wallet, throws an error if it has one to be thrown
// 
