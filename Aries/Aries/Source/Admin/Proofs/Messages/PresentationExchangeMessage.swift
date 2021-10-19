//
//  PresentationExchangeMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct PresentationExchangeMessage: BaseMessage {
    public let type: MessageType
    public let id: String
    public var state: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var trace: Bool?
    public var presentationExchangeId: String?
    public var connectionId: String?
    public var threadId: String?
    public var initiator: String?
    public var role: String?
    public var presentationProposalDict: [String : String]?
    public var presentationRequest: [String : String]?
    public var presentationRequestDict: [String : String]?
    public var presentation: [String : String]?
    public var verified: String?
    public var autoPresent: Bool?
    public var errorMsg: String?
    
    public init() {
        self.type = MessageType.presentationExchangeMessage
        self.id = UUID().uuidString
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case state
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case trace
        case presentationExchangeId = "presentation_exchange_id"
        case connectionId = "connection_id"
        case threadId = "thread_id"
        case initiator
        case role
        case presentationProposalDict = "presentation_proposal_dict"
        case presentationRequest = "presentation_request"
        case presentationRequestDict = "presentation_request_dict"
        case presentation
        case verified
        case autoPresent = "auto_present"
        case errorMsg = "error_msg"
    }
}
