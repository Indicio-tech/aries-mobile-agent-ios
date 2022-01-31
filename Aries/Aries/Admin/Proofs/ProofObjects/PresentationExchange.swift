//
//  PresentationExchange.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct PresentationExchange: Codable {
    public let initiator: String
    public let updatedAt: String
    public let role: String
    public let createdAt: String
    public let presentationExchangeId: String
    public let connectionId: String
    public let threadId: String
    public let presentationRequestDict: AriesJSON
    public let presentationRequest: PresentationRequest
    public let state: String
    public let trace: Bool
    
    enum CodingKeys : String, CodingKey {
        case initiator
        case updatedAt = "updated_at"
        case role
        case createdAt = "created_at"
        case presentationExchangeId = "presentation_exchange_id"
        case connectionId = "connection_id"
        case threadId = "thread_id"
        case presentationRequestDict = "presentation_request_dict"
        case presentationRequest = "presentation_request"
        case state
        case trace
    }
}
