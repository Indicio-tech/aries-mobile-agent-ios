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

        let recordTags = ["invitationKey": invitationMessage.recipientKeys != nil && invitationMessage.recipientKeys![0] != nil ? "true" : "false"]
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
    
    public func eventListener(_ messageType: MessageType, _ payload: Data){
        switch messageType {
        case .connectionResponseMessage:
            print("Connection response received")
        default:
            break;
        }
    }
}
