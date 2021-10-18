//
//  PresentationSentMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/14/21.
//

import Foundation

public struct PresentationSentMessage: BaseAdminConfirmationMessage {
    public let type: MessageType
    public let id: String
    public let thread: ThreadDecorator
    public let connectionId: String
    public let presentationExchangeId: String
    
    public init() {
        self.type = MessageType.presentationSentMessage
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case thread = "~thread"
        case connectionId = "connection_id"
        case presentationExchangeId = "presentation_exchange_id"
    }
}
