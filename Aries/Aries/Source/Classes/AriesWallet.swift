//
//  Wallet.swift
//  Aries
//
//  Created by David Clawson on 9/17/21.
//

import Foundation
import Indy

public class AriesWallet {

    public  var indyWallet: IndyWallet? = nil
    private let indyHandle: IndyHandle? = nil

    private func createWallet(id: String, key: String, completion: @escaping (_ result: Result<Void, Error>)->Void) {
    
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

        tempWallet.createWallet(withConfig: configString, credentials: credentialsString) { err in
            if let err = err {
                completion(.failure(err))
            }else{
                self.indyWallet = tempWallet
                completion(.success(()))
            }
        }
    }
    
    private func openWallet(id: String, key: String, completion: @escaping (_ result: Result<Void, Error>)->Void) {
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

        tempWallet.open(withConfig: configString, credentials: credentialsString) { err, _Arg in
            if let err = err {
                completion(.failure(err))
            }else{
                self.indyWallet = tempWallet
                completion(.success(()))
            }
        }
    }
    
    public init(id:String = "default", key:String = "password", completion: @escaping (_ result: Result<Void, Error>)->Void) {
//      Check to see if wallet already exists
        openWallet(id: id, key: key){ result in
            switch(result){
                case .success():
                    print("Wallet opened.")
                    completion(.success(()))
                case .failure(_):
                    print("Failed to open wallet, trying to create a new one.")
                    self.createWallet(id: "default", key: "password"){result1 in
                        switch(result1){
                            case .success():
                                print("Wallet created, retrying to open it")
                                self.openWallet(id: id, key: key){result2 in
                                    switch(result2) {
                                    case .success():
                                        print("Wallet opened.")
                                        completion(.success(()))
                                    case .failure(let error):
                                        completion(.failure(error))
                                    }
                                }
                            case .failure(let error):
                                completion(.failure(error))
                            }
                    }
            }
        }
    }
    
    public func packMessage<SomeMessageType: BaseMessage>(message: SomeMessageType, recipientKeys: [String], senderVerkey: String, completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        //Encode message to JSON string
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(message)
        let recipientKeysData = try! encoder.encode(recipientKeys)
        let messageJson = String(data: data, encoding: .utf8)
        let recipientKeysJson = String(data: recipientKeysData, encoding: .utf8)

        print("Packing message of type: "+message.type.rawValue+"\n\t"+messageJson!)

        IndyCrypto.packMessage(data, receivers: recipientKeysJson, sender: senderVerkey, walletHandle: indyHandle!) { error, data in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
        }
        
    }

    public func storeRecord(type: String, id: String, value: String, tags: [String: String]){
        //Stringify tags
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(tags)
        let tagsJson = String(data:data, encoding: .utf8)

        print("Storing record...")

        IndyNonSecrets.addRecordTags(inWallet: indyHandle!, type: type, id: id, tagsJson: tagsJson){ _ in
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

        IndyNonSecrets.updateRecordValue(inWallet: indyHandle!, type: type, id: id, value: value){ _ in
            print("Record updated.")
        }

        print("Updating tags...")
        IndyNonSecrets.addRecordTags(inWallet: indyHandle!, type: type, id: id, tagsJson: tagsJson){ _ in
            print("Tags updated.")
        }
    }

    public func retrieveRecord(type: String, id: String, completion: @escaping (_ result: Result<String, Error>) -> Void) -> Void{
        let config = [
            "retrieveType": true,
            "retrieveValue": true,
            "retrieveTags": true
        ]
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let data = try encoder.encode(config)
            let configJson = String(data: data, encoding: .utf8)

            IndyNonSecrets.getRecordFromWallet(indyHandle!, type: type, id: id, optionsJson: configJson){ error, data in
                if let error = error {
                    completion(.failure(error))
                }

                if let data = data {
                    completion(.success(data))
                }
            }
        }catch{
            completion(.failure(error))
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
