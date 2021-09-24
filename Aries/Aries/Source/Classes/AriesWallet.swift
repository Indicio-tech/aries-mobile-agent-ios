//
//  Wallet.swift
//  Aries
//
//  Created by David Clawson on 9/17/21.
//

import Foundation
import Indy

public class AriesWallet {

    private static let sharedInstance = IndyWallet.sharedInstance()
    static let wallet = AriesWallet()

    private func createWallet(id: String, key: String){
    
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
        
        if let sharedInstance = AriesWallet.sharedInstance {
            sharedInstance.createWallet(withConfig: configString, credentials: credentialsString) { err in
                print(err.debugDescription)
            }
        }
    }
    
    public func setupWallet(){
//      Check to see if wallet already exists
        
//      If it doesn't exist, create it
        createWallet(id: "default", key: "password")
        
        
        
    }
    
    
    
    public func deleteWallet(id: String, key: String){
        
        
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
        
        
        if let sharedInstance = AriesWallet.sharedInstance {
            sharedInstance.delete(withConfig: configString, credentials: credentialsString) { err in
                print(err.debugDescription)
            }
        }
    }
}
