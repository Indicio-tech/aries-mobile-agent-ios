//
//  AdminConnectionPendingRecord.swift
//  Aries
//
//  Created by David Clawson on 12/1/21.
//

import Foundation

public class AdminConnectionPendingRecord: BaseRecord {
    
    public var type: RecordType
    public var id: String
    public var tags: [String : String]
    
    public var adminConnection: ConnectionRecord
    public var messageObject: ConnectionMessage
    public var threadId: String
    
    public init(
        message: ConnectionMessage,
        adminConnection: ConnectionRecord
    ){
        self.adminConnection = adminConnection
        self.messageObject = message
        self.type = RecordType.adminConnectionPendingRecord
        self.threadId = message.thread.thid
        self.id = message.connectionId

        self.tags = [:]
        self.tags["adminConnection"] = adminConnection.id
    }

}
