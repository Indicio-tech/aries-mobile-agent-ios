//
//  InvitationMessage.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public struct InvitationMessage: BaseMessage {
    public let id: String
    public let type: MessageType
    public let label:String
    public let serviceEndpoint:String
    public let recipientKeys:[String]
    public let routingKeys:[String]
    
    public init(id: String, label: String, serviceEndpoint: String, recipientKeys: [String], routingKeys: [String]){
        self.id = id
        self.type = MessageType.invitationMessage
        self.label = label
        self.serviceEndpoint = serviceEndpoint
        self.recipientKeys = recipientKeys
        self.routingKeys = routingKeys
    }
    
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case label
        case serviceEndpoint
        case recipientKeys
        case routingKeys
    }
    
}
