//
//  GetCredentialsListMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct GetCredentialsListMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let transport: TransportDecorator
    
    
    public init(){
        self.type = MessageType.getCredentialsListMessage
        self.id = UUID().uuidString
        self.transport = TransportDecorator(returnRoute: "all")
        
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
    }
}

