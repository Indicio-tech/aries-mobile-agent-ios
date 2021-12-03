//
//  AdminCredentialsListReceivedRecord.swift
//  Aries
//
//  Created by David Clawson on 12/2/21.
//

import Foundation

class AdminCredentialsListReceivedRecord: BaseRecord {
    
    public var type: RecordType
    public var id: String
    public var tags: [String : String]
    public var adminConnection: ConnectionRecord
    public var threadId: String
    public var results: [CredentialExchangeItem]
    public var messageObject: CredentialsListMessage

    
    public init(message: CredentialsListMessage, adminConnection: ConnectionRecord){
        self.type = RecordType.adminCredentialsListReceivedRecord
        self.adminConnection = adminConnection
        self.messageObject = message
        self.threadId = message.thread.thid
        self.results = message.results
        self.id = message.id
        self.tags = ["adminConnection": adminConnection.id]
    }
}
