//
//  PresentationGetMatchingCredentialsMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct PresentationGetMatchingCredentialsMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let transport: TransportDecorator
    public let presentationExchangeId: String
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
        case presentationExchangeId = "presentation_exchange_id"
    }
}
