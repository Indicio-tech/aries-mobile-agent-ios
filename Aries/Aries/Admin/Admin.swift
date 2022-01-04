//
//  Admin.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/25/21.
//

import Foundation
import CloudKit

public class Admin {
    public var adminConnection: ConnectionRecord? = nil
    public var connectedToAdmin: Bool = false
    private var messageSender: MessageSender
    private var storage: Storage
    private var events: AriesEvents
    private var agentConnections: AriesConnections
    private var adminInvitationUrl: String?
    public var connections: AdminConnections? = nil
    
    //connectToAdmin data for reference in event handling... there might be a better way to do this?
    private var adminConnectionId: String? = nil
    private var adminCompletion: (_ result: Result<Void, Error>)->Void
    
    public init(messageSender: MessageSender, storage: Storage, connections: AriesConnections, events: AriesEvents, adminInvitationUrl: String? = nil){
        self.messageSender = messageSender
        self.storage = storage
        self.agentConnections = connections
        self.events = events
        func tempFunc(_ result: Result<Void, Error>){}
        self.adminCompletion = tempFunc
        self.adminInvitationUrl = adminInvitationUrl
        
        //Set event listener
        self.events.registerListener("AriesAdminListener", self.externalEventListener)
    }
    
    public func connectToAdmin(completion: @escaping (_ result: Result<Void, Error>)->Void){
        connectToAdmin(adminUrl: self.adminInvitationUrl!, completion: completion)
    }
    
    public func connectToAdmin(adminUrl: String? = "default_admin_connection", completion: @escaping (_ result: Result<Void, Error>)->Void){
        self.connectedToAdmin = false
        self.adminInvitationUrl = adminUrl
        
        //First check if already connected
        print("Checking if already connected to admin connection")
        retrieveAdminConnectionRecord(adminName: self.adminInvitationUrl!){result in
            do{
                switch(result){
                case .success(let connRecord):
                    //If found matching connection record then set it as admin connection
                    print("Found matching admin connection record")
                    self.connectedToAdmin = true
                    self.setAdminConnection(adminConnection: connRecord, connectionName: adminUrl!, completion: completion)
                    break
                case .failure(_):
                    //If no connection record found then make connection to invitation
                    print("Could not fetch admin connection record, trying to make connection...")
                    self.adminCompletion = completion
                    try self.agentConnections.receiveInvitationUrl(invitationUrl: self.adminInvitationUrl!) { result in
                        switch(result){
                        case .success(let connRecord):
                            self.adminConnectionId = connRecord.id
                        case .failure(let e):
                            completion(.failure(e))
                        }
                    }
                }
            }catch{
                completion(.failure(error))
            }
        }
    }
    
    public func setAdminConnection(adminConnection: ConnectionRecord, connectionName: String = "default_admin_connection", completion: @escaping (_ result: Result<Void, Error>)->Void){
        print("Setting admin connection")
        //Ensure admin ConnectionRecord is up to date with what's in wallet
        agentConnections.retrieveConnectionRecord(adminConnection.id){result in
            switch(result){
            case .failure(let err):
                print("Could not fetch connection record for ID: "+adminConnection.id)
                completion(.failure(err))
                break
            case .success(let connRecord):
                print("Connection record fetched...")
                //remove old tags
                self.removeDuplicateAdminTag(newConnectionID: adminConnection.id, connectionName: connectionName){ _ in
                    //Set adminConnection as the one passed
                    self.adminConnection = connRecord
                    
                    //Send trust ping to activate admin protocol
                    print("Sending admin trust ping")
                    let trustPing =  TrustPingMessage(responseRequested: false, comment: "adminConnection", returnRoute: "all")
                    self.messageSender.sendMessage(message: trustPing, connectionRecord: self.adminConnection!)
                    
                    //TODO: Set admin submodules here
                    //self.basicMessaging = AdminBasicMessaging(messageSender: self.messageSender, adminConnectionRecord: self.adminConnection)
                    self.connections = AdminConnections(messageSender: self.messageSender, adminConnection: self.adminConnection!)
                    
                    
                    //Check to see if connectionRecord tags need to be updated
                    if(self.adminConnection!.tags["admin_connection"] != connectionName){
                        //Update admin's connectionRecord tags
                        print("Updating admin record tags...")
                        self.adminConnection!.tags["admin_connection"] = connectionName
                        self.storage.updateRecord(record: self.adminConnection!){result1 in
                            switch(result1){
                            case .success():
                                print("Updated admin record tags successfully.")
                                break
                            case .failure(let err):
                                print("Failed to update admin record tags: \n"+err.localizedDescription)
                                break
                            }
                            //Complete callback even if tags fail to update?
                            completion(.success(()))
                        }
                    }else{
                        completion(.success(()))
                    }
                    
                }
            }
        }
    }
    
    public func sendTrustPing(){
        //Send trust ping to activate admin protocol
        print("Sending admin trust ping")
        let trustPing =  TrustPingMessage(responseRequested: false, comment: "adminConnection", returnRoute: "all")
        self.messageSender.sendMessage(message: trustPing, connectionRecord: self.adminConnection!)
    }
    
    private func removeDuplicateAdminTag(newConnectionID: String, connectionName: String, completion: @escaping(_ result : Result<Void, Error>)->Void){
        print("Searching for old connectionRecord....")
        retrieveAdminConnectionRecord(adminName: connectionName){ result in
            switch(result){
            case .failure(let err):
                print("Previous admin connection could not be found: \n"+err.localizedDescription)
                completion(.failure(err))
                break
            case .success(var oldConnection):
                print("Found previous admin connection.")
                if(oldConnection.id == newConnectionID){
                    print("Stored admin connection matches new one.")
                    completion(.success(()))
                }else{
                    oldConnection.tags.removeValue(forKey: "admin_connection")
                    self.storage.updateRecord(record: oldConnection){ result1 in
                        switch(result1){
                        case(.success()):
                            print("Duplicate admin connection tags successfully removed.")
                            completion(.success(()))
                        case(.failure(let err)):
                            print("Could not update admin tags: \n"+err.localizedDescription)
                            completion(.failure(err))
                        }
                    }
                }
            }
        }
        
    }
    
    private func retrieveAdminConnectionRecord(adminName: String, completion: @escaping (_ result: Result<ConnectionRecord,Error>)->Void){
        let query = ["admin_connection": adminName]
        print("Searching for adminConnection: "+adminName)
        self.storage.retrieveRecordsByTags(type: RecordType.connectionRecord, tags: query){(result: Result<[ConnectionRecord], Error>) in
            switch(result){
            case .success(let connArr):
                completion(.success(connArr[0]))
            case .failure(let e):
                completion(.failure(e))
            }
        }
    }
    
    
    public func _internalEventListener(_ messageType: MessageType, _ payload: Data, _ senderVerkey: String){
        if(adminConnection != nil){
            do{
                switch(messageType){
            //Admin connections
                case .connectionMessage:
                    print("Admin received connection message.")
                    let message = try MessageUtils.buildMessage(ConnectionMessage.self, payload)
                    let record = AdminConnectionPendingRecord(message: message, adminConnection: adminConnection!)
                    try events.triggerEvent(record)
                    break
                case .connectedMessage:
                    print("Admin received connected message.")
                    let message = try MessageUtils.buildMessage(ConnectedMessage.self, payload)
                    let record = AdminConnectedRecord(message: message, adminConnection: adminConnection!)
                    try events.triggerEvent(record)
                    break
                case .deletedConnectionMessage:
                    print("Admin received connection deleted message.")
                    let message = try MessageUtils.buildMessage(ConnectedMessage.self, payload)
                    let record = try AdminMessageConfirmationRecord(message: message, adminConnection: adminConnection!)
                    try events.triggerEvent(record)
                    break
                case .connectionListMessage:
                    print("Admin received connection list message.")
                    let message = try MessageUtils.buildMessage(ConnectionListMessage.self, payload)
                    let record = AdminConnectionListRecord(message: message, adminConnection: adminConnection!)
                    try events.triggerEvent(record)
                    break
            //Admin credentials
                case .credentialOfferReceivedMessage:
                    print("Admin received credential offer received message.")
                    let message = try MessageUtils.buildMessage(CredentialOfferReceivedMessage.self, payload)
                    let record = AdminCredentialReceivedRecord(message: message, adminConnection: adminConnection!)
                    try events.triggerEvent(record)
                    break
                case .credentialReceivedMessage:
                    print("Admin received credential received message.")
                    break
                case .credentialsListMessage:
                    break
            //Admin proofs
                case .presentationsListMessage:
                    break
                case .presentationMatchingCredentialsMessage:
                    break
                case .presentationSentMessage:
                    break
            // Admin basic messaging
                case .deletedBasicMessage:
                    break
                case .receivedBasicMessage:
                    break
                case .newBasicMessage:
                    break
                case .sentBasicMessage:
                    break
                    
                default: break
                }
            }catch{
                print(error)
            }
        }
    }
    
    //Listen for external connection events NOT our internal events
    private func externalEventListener(_ recordType: RecordType, _ latestRecord: Data, _ prevRecord: Data?){
        do{
            switch(recordType){
            case .connectionRecord:
                if(adminConnectionId != nil && prevRecord != nil){
                    let connRecord = try RecordUtils.buildRecord(ConnectionRecord.self, latestRecord)
                    if(connRecord.id == adminConnectionId && connRecord.state == .COMPLETE && !connectedToAdmin){
                        self.connectedToAdmin = true
                        print("Admin connection completed, setting admin connection.")
                        setAdminConnection(adminConnection: connRecord, connectionName: self.adminInvitationUrl!, completion: self.adminCompletion)
                    }
                }
            default:
                break
            }
        }catch{
            print("Error in Admin EventListener function")
            print(error)
        }
    }
    
}
