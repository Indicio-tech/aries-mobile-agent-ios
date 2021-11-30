//
//  Connections.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/12/21.
//

import Foundation

public class AriesConnections{
    private let ariesWallet: AriesWallet
    private let messageSender: MessageSender
    private let storage: Storage
    
    public init(ariesWallet: AriesWallet, messageSender: MessageSender, storage: Storage){
        self.ariesWallet = ariesWallet
        self.messageSender = messageSender
        self.storage = storage
    }

    public func receiveInvitationUrl(invitationUrl:String, autoAccept:Bool = true, completion: @escaping (_ result: Result<ConnectionRecord, Error>) -> Void) throws {
        print("Decoding invitation url: "+invitationUrl)
        let components = URLComponents(string: invitationUrl)
        let encodedInvitation = components!.queryItems!.first(where: {queryItem -> Bool in
            queryItem.name == "c_i"
        })!.value!

        let decodedData = Data(base64Encoded: encodedInvitation)!
        let decodedInvitation = String(data: decodedData, encoding: .utf8)!
        print("Decoded invitation: "+decodedInvitation)
        let decoder = JSONDecoder()
        let invitationMessage = try decoder.decode(InvitationMessage.self, from: decodedData)

        let recordTags = ["invitationKey": invitationMessage.recipientKeys != nil && invitationMessage.recipientKeys?.count ?? -1 > 0 ? "true" : "false"]
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss'Z'"
        let createdTime = df.string(from: Date())

        let connectionRecord = ConnectionRecord(
            id: UUID().uuidString,
            createdAt: createdTime,
            invitation: invitationMessage,
            state: .INVITED,
            autoAcceptConnection: autoAccept,
            role: "invitee",
            label: "AMAi Agent",
            tags: recordTags
        )

        storage.storeRecord(record: connectionRecord){result in
            switch result{
            case .success():
                print("Record stored.")
                self.sendRequest(connectionRecord: connectionRecord, completion: completion)
            case .failure(let e):
                completion(.failure(e))
            }
            
        }


    }

    private func sendRequest(connectionRecord: ConnectionRecord, completion: @escaping (_ result: Result<ConnectionRecord, Error>) -> Void){
        print("Creating connection request")
        createConnection(connectionRecord: connectionRecord){ result in
            switch(result){
            case(.success(let updatedRecord)):
                let connection = AriesConnection(did: updatedRecord.did!, didDoc: updatedRecord.didDoc!)
                let connectionRequest = ConnectionRequest(label: updatedRecord.label, connection: connection, id: updatedRecord.id)
                self.messageSender.sendMessage(message: connectionRequest, connectionRecord: updatedRecord)
                completion(.success(updatedRecord))
            case(.failure(let error)):
                completion(.failure(error))
            }
        }
    }

    private func createConnection(connectionRecord: ConnectionRecord, completion: @escaping (_ result: Result<ConnectionRecord, Error>) -> Void){
        print("Creating DIDDoc")
        self.ariesWallet.generateDID(){ result in
            switch(result){
            case(.success(let didDic)):
                let did = didDic["did"]!
                let verkey = didDic["verkey"]!

                let didDoc = DIDDoc(did: did, verkey: verkey)
                print("DIDDoc created")

                var updatedRecord = connectionRecord
                updatedRecord.state = .REQUESTED
                updatedRecord.did = did
                updatedRecord.didDoc = didDoc
                updatedRecord.verkey = verkey

                self.storage.updateRecord(record: updatedRecord){res in
                    switch res{
                    case .success():
                        completion(.success(updatedRecord))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case(.failure(let error)):
                completion(.failure(error))
            }
        }
    }
    
    public func retrieveConnectionRecord(_ id: String, completion: @escaping (_ result: Result<ConnectionRecord, Error>)->Void){
        self.storage.retrieveRecord(type: .connectionRecord, id: id, completion: completion)
    }
    
    public func processResponse(connectionResponse: ConnectionResponse) {
        do{
            retrieveConnectionRecord(connectionResponse.thread.thid){ result in
                do{
                    switch(result){
                    case .success(let r):
                        var record = r
                        let signerVerkey = connectionResponse.signedConnection.signer
                        let invitationVerkey = record.invitation.recipientKeys![0]
                        
                        if(signerVerkey != invitationVerkey){
                            throw ConnectionsError.connectionMismatch("Connection in connection response is not signed with same key as recipient key in invitation")
                        }
                        
                        record.theirDidDoc = connectionResponse.connection.didDoc
                        record.theirDid = connectionResponse.connection.did
                        record.threadId = connectionResponse.thread.thid
                        record.state = .RESPONDED
                        record.tags["verkey"] = connectionResponse.connection.didDoc.service[0].recipientKeys[0]
                        
                        self.storage.updateRecord(record: record){result1 in
                            switch(result1){
                            case .success():
                                print("Sending connection ack")
                                let trustPing = TrustPingMessage(responseRequested: true, comment: "Connection ack", returnRoute: "all")
                                self.messageSender.sendMessage(message: trustPing, connectionRecord: record)
                                record.state = .COMPLETE
                                self.storage.updateRecord(record: record){result2 in
                                    switch(result2){
                                    case .success():
                                        print("Connection complete")
                                    case.failure(let err):
                                        print(err)
                                    }
                                }
                            case .failure(let err):
                                print(err)
                            }
                        }
                    case .failure(let err):
                        print(err)
                    }
                }catch{
                    print(error)
                }
            }
        }
    }
    
    public func eventListener(_ messageType: MessageType, _ payload: Data, _ senderVerkey: String){
        do{
            switch messageType {
            case .connectionResponseMessage:
                print("Connection response received")
                let decoder = JSONDecoder()
                
                print("Here's the payload: >>>> \(String(data: payload, encoding: .utf8)!)")
                
                let message = try decoder.decode(ConnectionResponse.self, from: payload)
                processResponse(connectionResponse: message)
            default:
                break;
            }
        }catch{
            print(error)
        }
    }
    
    enum ConnectionsError: Error {
        case connectionMismatch(String)
    }
}
