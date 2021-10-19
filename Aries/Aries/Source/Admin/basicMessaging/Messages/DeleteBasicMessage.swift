//
//  DeleteBasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public struct DeleteBasicMessage: BaseOutboundAdminMessage {
    
    
    public let transport: TransportDecorator
    public let type: MessageType
    public let id: String
    public let connectionId: String?
    public let beforeData: String?
    public let messageId: String?
    
    public init(messageId: String?, connectionId: String?, beforeData: String?) {
        self.type = MessageType.deleteBasicMessage
        self.id = UUID().uuidString
            self.messageId = messageId
            self.connectionId = connectionId
            self.beforeData = beforeData
        self.transport = TransportDecorator(returnRoute: "all")
    }
    
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectionId = "connection_id"
        case messageId = "message_id"
        case beforeData = "before_data"
        case transport = "~transport"
    }
}
