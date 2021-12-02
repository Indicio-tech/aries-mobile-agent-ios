//
//  AdminConnectedRecord.swift
//  Aries
//
//  Created by David Clawson on 12/1/21.
//

import Foundation

public class AdminConnectedRecord: BaseRecord {
    public var type: RecordType
    public var id: String
    public var tags: [String : String]
    
    public var adminConnection: ConnectionRecord
    public var messageObject: ConnectedMessage
    public var connectionId: String?
    public var theirDid: String?
    public var myDid: String?
    public var state: String?
    public var label: String?
    
    public init(
        message: ConnectedMessage,
        adminConnection: ConnectionRecord
    ){
        self.adminConnection = adminConnection
        self.messageObject = message
        self.type = RecordType.adminConnectedRecord
        self.id = message.id
        self.connectionId = message.connectionId
        self.theirDid = message.theirDid
        self.myDid = message.myDid
        self.state = message.state
        self.label = message.label

        self.tags = [:]
        self.tags["adminConnection"] = adminConnection.id
    }

}

