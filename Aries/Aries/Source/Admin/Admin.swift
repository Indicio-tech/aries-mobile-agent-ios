//
//  Admin.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/25/21.
//

import Foundation
import CloudKit

public class Admin {
    public var adminConnection: ConnectionRecord?
    public var connectedToAdmin: Bool = false
    private var messageSender: MessageSender
    private var storage: Storage
    private var agentConnections: AriesConnections
    private var adminInvitationUrl: String?
    
    //connectToAdmin data for reference in event handling... there might be a better way to do this?
    private var adminConnectionId: String?
    private var adminCompletion: (_ result: Result<Void, Error>->Void)?
    
    public func connectToAdmin(adminInvitationUrl: String, completion: (_ result: Result<Void, Error>)->Void){
        self.connectedToAdmin = false
        self.adminInvitationUrl = adminInvitationUrl
        
        //First check if already connected
        print("Checking if already connected to admin connection")
        retrieveAdminConnectionRecord(adminName: adminInvitationUrl){result in
            switch(result){
            case .success(let connRecord):
                //If found matching connection record then set it as admin connection
                print("Found matching admin connection record")
                self.connectedToAdmin = true
                setAdminConnection(adminConnection: connRecord, completion: completion)
                break
            case .failure(let err):
                //If no connection record found then make connection to invitation
                print("Could not fetch admin connection record, trying to make connection...")
                agentConnections.receiveInvitationUrl(invitationUrl: adminInvitationUrl) { result in
                    switch(result){
                    case .success(let connRecord: ConnectionRecord):
                        self.adminConnectionId = connRecord.id
                        self.adminCompletion = completion
                    }
                }
            }
        }
    }
    
    public func setAdminConnection(adminConnection: ConnectionRecord, connectionName: String = "default_admin_connection", completion: (_ result: Result<Void, Error>)->Void){
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
                updateOldAdminTag(connectionName: connectionName){ _ in
                    //Set adminConnection as the one passed
                    self.adminConnection = connRecord
                    
                    //Send trust ping to activate admin protocol
                    print("Sending admin trust ping")
                    let trustPing =  TrustPingMessage(responseRequested: false, comment: "adminConnection", returnRoute: "all")
                    self.messageSender.sendMessage(message: trustPing, connectionRecord: self.adminConnection)
                    
                    //TODO: Set admin submodules here
                    //self.basicMessaging = AdminBasicMessaging(messageSender: self.messageSender, adminConnectionRecord: self.adminConnection)
                    
                    //Update admin's connectionRecord tags
                    print("Updating admin record tags...")
                    self.adminConnection.tags["admin_connection"] = connectionName
                    self.storage.updateRecord(record: self.adminConnection){result1 in
                        switch(result1){
                        case .success(let _):
                            print("Updated admin record tags successfully.")
                            break
                        case .failure(let err):
                            print("Failed to update admin record tags: \n"+err)
                            break
                        }
                        //Complete callback even if tags fail to update?
                        completion(.success(()))
                    }
                    
                }
            }
        }
    }
    
    private func updateOldAdminTag(connectionName: String, completion: (_ result : Result<Void, Error>)->Void){
        print("Searching for old connectionRecord....")
        retrieveAdminConnectionRecord(adminName: connectionName){ result in
            switch(result){
            case .failure(let err):
                print("Previous admin connection could not be found: \n"+err)
                completion(.failure(err))
                break
            case .success(var oldConnection: ConnectionRecord):
                print("Found previous admin connection, updating tags...")
                oldConnection.tags.removeValue(forKey: "admin_connection")
                storage.updateRecord(record: oldConnection){ result1 in
                    switch(result1){
                    case .success(let _):
                        print("Previous admin connection tags successfully updated.")
                        completion(.success(_))
                        break
                    case .failure(let err):
                        print("Could not update admin tags: \n"+err)
                        completion(.failure(err))
                    }
                }
            }
        }
        
    }
    
    private func retrieveAdminConnectionRecord(adminName: String, completion: (_ result: Result<ConnectionRecord,Error>)->Void){
        let query = ["admin_connection": adminName]
        print("Searching for adminConnection: "+adminName)
        self.storage.retrieveRecordsByTags(type: RecordType.connectionRecord, tags: query, completion: completion)
    }
    
    
    
    
    //Listen for external connection events NOT our internal events
    public func externalEvents(_ updatedRecord: (type: RecordType, payload: Data), _ oldRecord: (type: RecordType, payload: Data)?){
        switch(updatedRecord.type){
        case .connectionRecord:
            if(oldRecord != nil){
                
            }
        default:
            break
        }
    }
