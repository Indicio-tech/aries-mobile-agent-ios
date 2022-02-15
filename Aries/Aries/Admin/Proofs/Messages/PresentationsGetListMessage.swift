//
//  PresentationsGetListMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/14/21.
//

import Foundation

public struct PresentationsGetListMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let transport: TransportDecorator
    public var connectionId: String?
    
    public init(connectionId: String? = nil) {
        self.type = MessageType.presentationGetListMessage
        self.id = UUID().uuidString
        self.transport = TransportDecorator(returnRoute: "all")
        self.connectionId = connectionId
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
        case connectionId = "connection_id"
    }
}
