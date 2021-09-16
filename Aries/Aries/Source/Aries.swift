//
//  Agent.swift
//  Aries
//
//  Created by David Clawson on 9/16/21.
//

import Foundation
import Indy

public class Agent{
    
    public init(){
        print("Agent initted!")
    }
    
    public func createWallet(id: String, key: String){
        let sharedInstance = IndyWallet.sharedInstance()
        print("Create wallet called!")
        
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
        
        if let sharedInstance = sharedInstance {
            print("Shared instance is up!")
            sharedInstance.createWallet(withConfig: configString, credentials: credentialsString) { err in
                print(err.debugDescription)
            }
        }
    }
}
