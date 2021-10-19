//
//  PresentationSentMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/14/21.
//

import Foundation

public struct PresentationSentMessage: BaseAdminConfirmationMessage {
    public let type: MessageType
    public var id: String
    public var thread: ThreadDecorator?
    public var connectionId: String?
    public var presentationExchangeId: String?
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case thread = "~thread"
        case connectionId = "connection_id"
        case presentationExchangeId = "presentation_exchange_id"
    }
}
