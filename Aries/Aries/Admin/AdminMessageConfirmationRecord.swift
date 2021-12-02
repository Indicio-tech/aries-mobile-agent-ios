//
//  AdminMessageConfirmationRecord.swift
//  Aries
//
//  Created by Patrick Kenyon on 12/2/21.
//

import Foundation

public class AdminMessageConfirmationRecord: BaseRecord {
    public let type: RecordType
    public let id: String
    public let tags: [String : String]
    
    public let adminConnection: ConnectionRecord
    public let messagePayload: Data
    public let messageType: MessageType
    public let thread: ThreadDecorator
    
    public init<messageClass: BaseAdminConfirmationMessage>(
        message: messageClass,
        adminConnection: ConnectionRecord
    )throws{
        self.adminConnection = adminConnection
        self.messageType = message.type
        self.type = .adminConfirmation
        self.messagePayload = try MessageUtils.toData(message)
        self.thread = message.thread!
        self.id = message.id
        self.tags = [:]
    }

}

