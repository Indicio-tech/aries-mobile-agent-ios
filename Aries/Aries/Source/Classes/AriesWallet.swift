//
//  Wallet.swift
//  Aries
//
//  Created by David Clawson on 9/17/21.
//

import Foundation
import Indy

public class AriesWallet {

    public static let wallet: IndyWallet
    private let indyHandle: IndyHandle

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
        
        wallet = IndyWallet.createWallet(withConfig: configString, credentials: credentialsString) { err in
            throw err
        }
    }
    
    private func openWallet(id: String, key: String){
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
        
        self.wallet = IndyWallet()
        wallet.open(withConfig: configString, credentials: credentialsString) { err in
            throw err
        }
    }
    
    public init(){
//      Check to see if wallet already exists
        do {
            openWallet(id: "default", key: "password")
        }catch {
//          If it doesn't exist, create it
            createWallet(id: "default", key: "password")
        }
    }
    
//    public func packMessage(message: BaseMessage, recipientKeys: [String], senderVerkey: String){
//        //Encode message to JSON string
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        let data = try! encoder.encode(message)
//        let messageJson = String(data: data, encoding: .utf8)
//
//        print("Packing message of type: "+message.type+"\n\t"+messageJson)
//
//
//        let packedMessage = IndyCrypto.packMessage(message: Data(messageJson), receivers: recipientKeys.joined(), sender:sender, walletHandle: this.indyHandle)
//        print("Packed message: \n\t"+packedMessage)
//
//        return packedMessage;
//    }
//
//
//
//    public func deleteWallet(id: String, key: String){
//
//
//        let configDict = ["id":id]
//        let credentialsDict = ["key":key]
//        var configString = ""
//        var credentialsString = ""
//
//        if let JSONData = try? JSONSerialization.data(withJSONObject: configDict, options: []){
//            configString = String(data: JSONData, encoding: .ascii)!
//            print(configString)
//        }
//        if let JSONData = try? JSONSerialization.data(withJSONObject: credentialsDict, options: []){
//            credentialsString = String(data: JSONData, encoding: .ascii)!
//            print(credentialsString)
//        }
//
//
//        if let sharedInstance = AriesWallet.sharedInstance {
//            self.wallet.delete(withConfig: configString, credentials: credentialsString) { err in
//                print(err.debugDescription)
//            }
//        }
//    }
}
