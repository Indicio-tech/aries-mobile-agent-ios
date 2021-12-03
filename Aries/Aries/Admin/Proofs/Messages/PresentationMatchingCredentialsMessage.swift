//
//  PresentationMatchingCredentialsMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct PresentationMatchingCredentialsMessage: BaseMessage {
    public let type: MessageType
    public let id: String
    public let thread: String
    public let presentationExchangeId: String
    public let matchingCredentials: [MatchingCredentials]
    public let page: PageDecorator
    
    public init(thread: String, presentationExchangeId: String, matchingCredentials: [MatchingCredentials], page: PageDecorator) {
        self.type = MessageType.presentationMatchingCredentialsMessage
        self.thread = thread
        self.presentationExchangeId = presentationExchangeId
        self.matchingCredentials = matchingCredentials
        self.page = page
        self.id = UUID().uuidString
    }

    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case thread = "~thread"
        case presentationExchangeId = "presentation_exchange_id"
        case matchingCredentials = "matching_credentials"
        case page = "~page"
    }
}
