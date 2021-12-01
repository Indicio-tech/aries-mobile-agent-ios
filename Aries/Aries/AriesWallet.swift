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
    private var indyHandle: IndyHandle? = nil

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
            _ = self.complete(indyError: err!, result: (), completion: completion)
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

        tempWallet.open(withConfig: configString, credentials: credentialsString) { err, handle in
            self.indyHandle = handle
            self.indyWallet = tempWallet
            _ = self.complete(indyError: err!, result: (), completion: completion)
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
                    self.createWallet(id: id, key: key){result1 in
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
            _ = self.complete(indyError: error! as Error, result: data! as Data, completion: completion)
        }
        
    }

    public func generateDID(completion: @escaping (_ result: Result<[String: String], Error>) -> Void){
        IndyDid.createAndStoreMyDid("{}", walletHandle: indyHandle!){ error, s, s2 in
            _ = self.complete(indyError: error! as Error, result: ["did": s!, "verkey": s2!] as [String: String], completion: completion)
        }
    }

    public func storeRecord(type: String, id: String, value: String, tags: [String: String], completion:  @escaping (_ result: Result<Void, Error>) -> Void){
        //Stringify tags
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(tags)
        let tagsJson = String(data:data, encoding: .utf8)

        print("Storing record...")

        IndyNonSecrets.addRecord(inWallet: indyHandle!, type: type, id: id, value: value, tagsJson: tagsJson){ error in
            print("Record stored.")
            _ = self.complete(indyError: error!, result: (), completion: completion)
        }
    }

    public func updateRecord(type: String, id: String, value: String, tags: [String: String], completion:  @escaping (_ result: Result<Void, Error>) -> Void){

        //Stringify tags
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(tags)
        let tagsJson = String(data:data, encoding: .utf8)

        print("Updating record...")

        IndyNonSecrets.updateRecordValue(inWallet: indyHandle!, type: type, id: id, value: value){ error in
            print("Updating tags...")
            IndyNonSecrets.addRecordTags(inWallet: self.indyHandle!, type: type, id: id, tagsJson: tagsJson){ error in
                print("Tags updated.")
                _ = self.complete(indyError: error! as Error, result: (), completion: completion)
            }
        }
    }
    
    public func unpackMessage(message: Data, completion: @escaping (_ result: Result<Data, Error>)-> Void){
        if let indyHandle = self.indyHandle {
           IndyCrypto.unpackMessage(message, walletHandle: indyHandle) { error, data in
                _ = self.complete(indyError: error! as Error, result: data, completion: completion)
            }
        } else {
            print("No Indy handle initialized")
        }
    }

    public func retrieveRecord(type: String, id: String, completion: @escaping (_ result: Result<IndyRetrievedRecord, Error>) -> Void) -> Void{
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
                let decoder = JSONDecoder()
                let retreivedRecord = try! decoder.decode(IndyRetrievedRecord.self, from: data!.data(using: .utf8)!)
                _ = self.complete(indyError: error! as Error, result: retreivedRecord, completion: completion)
            }
        }catch{
            completion(.failure(error))
        }
    }
        
    public func verify (signature: Data, message: Data, key: String, completion: @escaping (_ result: Result<Bool, Error>) -> Void)->Void{
        
        IndyCrypto.verifySignature(signature, forMessage: message, key: key) { error, result in
            print(">>>>>>>>>> Verficiation Complete, \(result)")
            if result {
                _ = self.complete(indyError: error! as Error, result: result, completion: completion)
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    
    public func searchByQuery(type: String, query: [String:String], limit: Int, completion: @escaping (_ result: Result<[String], Error>) -> Void){
        do{
            let queryJson = try JSONEncoder().encode(query)
            let options = try JSONEncoder().encode(["limit": limit])
            IndyNonSecrets.openSearch(inWallet: self.indyHandle!, type: type, queryJson: String(data: queryJson, encoding: .utf8), optionsJson: String(data: options, encoding: .utf8)){error, searchHandle in
                let code = (error! as NSError).code
                if(code != 0){
                    completion(.failure(error!))
                }else{
                    self.recursiveFetching(searchHandle: searchHandle, limit: limit){result in
                        switch(result){
                        case(.failure(let fetchError)):
                            completion(.failure(fetchError))
                            break
                        case(.success(let returnArray)):
                            completion(.success(returnArray))
                        }
                    }
                }
            }
        }catch{
            completion(.failure(error))
        }
    }
    
    private func recursiveFetching(searchHandle: IndyHandle, limit: Int, returnArray: [String] = [], completion: @escaping (_ result: Result<[String], Error>) -> Void){
        if(returnArray.count == limit){
            completion(.success(returnArray))
        }else{
            IndyNonSecrets.fetchNextRecords(fromSearch: searchHandle, walletHandle: self.indyHandle!, count: limit as NSNumber){ error, results in
                do{
                    let code = (error! as NSError).code
                    if(code != 0){
                        completion(.failure(error!))
                    }else{
                        guard let json = (try JSONSerialization.jsonObject(with: results!.data(using: .utf8)!) as! [String: Any])["records"] as? [[String: String?]] else {
                            throw AriesWalletError.noResults("No matching records found.")
                        }
                        
                        var newArray = returnArray
                        for (record) in json{
                            let recordString = record["value"]!!
                            newArray.append(recordString)
                            self.recursiveFetching(searchHandle: searchHandle, limit: limit, returnArray: newArray, completion: completion)
                        }
                    }
                }catch{
                    print(error)
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func complete<returnType: Any>(indyError: Error, result: returnType?, completion: @escaping (_ result: Result<returnType, Error>) -> Void)->Bool{
        let code = (indyError as NSError).code
        if code != 0 {
            completion(.failure(indyError))
            return false
        } else {
            completion(.success(result!))
            return true
        }
    }
    
    enum AriesWalletError: Error {
        case noResults(String)
    }
}
