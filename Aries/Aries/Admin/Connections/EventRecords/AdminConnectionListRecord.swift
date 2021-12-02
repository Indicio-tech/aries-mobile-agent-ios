//
//  AdminConnectionListRecord.swift
//  Aries
//
//  Created by David Clawson on 12/1/21.
//

import Foundation

public class AdminConnectionListRecord: BaseRecord {
    public var type: RecordType
    public var id: String
    public var tags: [String : String]
    
    public var adminConnection: ConnectionRecord
    public var messageObject: ConnectionListMessage
    public var connectionId: String?
    public var connections: [AdminConnection]
    public var threadId: String
    
    public init(
        message: ConnectionListMessage,
        adminConnection: ConnectionRecord
    ){
        self.adminConnection = adminConnection
        self.messageObject = message
        self.type = RecordType.adminConnectionListRecord
        self.threadId = message.thread.thid
        self.id = message.id
        self.connections = message.connections

        self.tags = [:]
        self.tags["adminConnection"] = adminConnection.id
    }

}
