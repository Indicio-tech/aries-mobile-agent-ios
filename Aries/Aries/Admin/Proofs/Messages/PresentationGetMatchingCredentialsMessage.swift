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
    
    public init (presentationExchangeId: String){
        self.type = MessageType.presentationGetMatchingCredentialsMessage
        self.id = UUID().uuidString
        self.transport = TransportDecorator(returnRoute: "all")
        self.presentationExchangeId = presentationExchangeId
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
        case presentationExchangeId = "presentation_exchange_id"
    }
}
