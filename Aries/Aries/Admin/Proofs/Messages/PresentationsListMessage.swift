//
//  PresentationsListMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/14/21.
//

import Foundation

public struct PresentationsListMessage: BaseMessage {
    
    public let type: MessageType
    public let id: String
    public let results: [PresentationExchange]
    public let page: PageDecorator
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case results
        case page = "~page"
    }
}
