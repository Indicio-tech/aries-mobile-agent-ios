//
//  InvitationMessage.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class InvitationMessage: BaseMessage{
    public let label:String
    public let serviceEndpoint:String
    public let recipientKeys:[String]
    public let routingKeys:[String]
    public static let type = BaseMessage.MessageType.invitationMessage
    
    public init(id: String, label: String, serviceEndpoint: String, recipientKeys: [String], routingKeys: [String]){
        self.id = id
        self.label = label
        self.serviceEndpoint = serviceEndpoint
        self.recipientKeys = recipientKeys
        self.routingKeys = routingKeys
    }
}
