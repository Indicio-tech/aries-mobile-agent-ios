//
//  Wallet.swift
//  Aries
//
//  Created by David Clawson on 9/17/21.
//

import Foundation
import Indy

public class AriesWallet {

    public  var indyWallet: IndyWallet
    private let indyHandle: IndyHandle

    private func createWallet(id: String, key: String) throws {
    
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

        let tempWallet = IndyWallet()
        var walletErr:Error?

        tempWallet.createWallet(withConfig: configString, credentials: credentialsString) { err in
            if let err = err {
                walletErr = err
            }
        }

        if(walletErr != nil){
            throw walletErr!
        }else{
            indyWallet = tempWallet
        }
    }
    
    private func openWallet(id: String, key: String) throws {
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
        
        let tempWallet = IndyWallet()
        var walletErr:Error?

        tempWallet.open(withConfig: configString, credentials: credentialsString) { err, <#arg#> in
            if let err = err {
                walletErr = err
            }
        }

        if(walletErr != nil){
            throw walletErr!
        }else{
            indyWallet = tempWallet
        }
    }
    
    public init() throws {
//      Check to see if wallet already exists
        do {
            try openWallet(id: "default", key: "password")
        }catch {
//          If it doesn't exist, create it
            try createWallet(id: "default", key: "password")
        }
    }
    
    public func packMessage(message: BaseMessage, recipientKeys: [String], senderVerkey: String) throws -> Data {
        //Encode message to JSON string
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(message)
        let recipientKeysData = try! encoder.encode(recipientKeys)
        let messageJson = String(data: data, encoding: .utf8)
        let recipientKeysJson = String(data: recipientKeysData, encoding: .utf8)

        print("Packing message of type: "+message.type.rawValue+"\n\t"+messageJson!)
        
        var packedMessage:Data
        var packingError:Error?

        IndyCrypto.packMessage(data, receivers: recipientKeysJson, sender: senderVerkey, walletHandle: indyHandle) { error, data in
                if let error = error {
                     packingError = error
                }
                
                if let data = data {
                    packedMessage = data
                }
        }
        
        if(packingError != nil){
            throw packingError!
        }else{
            return packedMessage
        }
    }

    public func storeRecord(type: String, id: String, value: String, tags: [String: String]){
        //Stringify tags
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(tags)
        let tagsJson = String(data:data, encoding: .utf8)

        print("Storing record...")

        IndyNonSecrets.addRecordTags(inWallet: indyHandle, type: type, id: id, tagsJson: tagsJson){ _ in
            print("Record stored.")
        }
    }

    public func updateRecord(type: String, id: String, value: String, tags: [String: String]){

        //Stringify tags
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(tags)
        let tagsJson = String(data:data, encoding: .utf8)

        print("Updating record...")

        IndyNonSecrets.updateRecordValue(inWallet: indyHandle, type: type, id: id, value: value){ _ in
            print("Record updated.")
        }

        print("Updating tags...")
        IndyNonSecrets.addRecordTags(inWallet: indyHandle, type: type, id: id, tagsJson: tagsJson){ _ in
            print("Tags updated.")
        }
    }

    public func retrieveRecord(type: String, id: String) throws -> Data{
        let config = [
            "retrieveType": true,
            "retrieveValue": true,
            "retrieveTags": true
        ]
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(config)
        let configJson = String(data: data, encoding: .utf8)

        var getRecordError:Error?
        var recordData:Data

        IndyNonSecrets.getRecordFromWallet(indyHandle, type: type, id: id, optionsJson: configJson){ error, data in
            if let error = error {
                getRecordError = error
            }

            if let data = data {
                recordData = data.data(using: .utf8)!
                
            }
        }

        if(getRecordError != nil){
            throw getRecordError!
        }else{
            return recordData
        }
    }
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
