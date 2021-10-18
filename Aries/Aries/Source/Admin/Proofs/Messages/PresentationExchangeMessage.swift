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
    public let state: String
    public let createdAt: String
    public let updatedAt: String
    public let trace: Bool
    public let presentationExchangeId: String
    public let connectionId: String
    public let threadId: String
    public let initiator: String
    public let role: String
    public let presentationProposalDict: [String : String]
    public let presentationRequest: [String : String]
    public let presentationRequestDict: [String : String]
    public let presentation: [String : String]
    public let verified: String
    public let autoPresent: Bool
    public let errorMsg: String
    
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
