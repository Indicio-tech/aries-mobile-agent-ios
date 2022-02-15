//
//  AdminPresentationsListRecord.swift
//  Aries
//
//  Created by David Clawson on 12/2/21.
//

import Foundation

public class AdminPresentationsListRecord: BaseRecord {
    public var type: RecordType
    public var id: String
    public var tags: [String : String]
    
    public var adminConnection: ConnectionRecord
    public var messageObject: PresentationsListMessage
    public var presentations: [PresentationExchange]
    
    public init(message: PresentationsListMessage, adminConnection: ConnectionRecord){
        self.type = RecordType.adminPresentationsListRecord
        self.adminConnection = adminConnection
        self.messageObject = message
        self.presentations = message.results
        self.id = message.id
        self.tags = ["adminConnection": adminConnection.id]
    }
    
}
