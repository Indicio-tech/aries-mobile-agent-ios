//
//  CredentialsListMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct CredentialsListMessage: BaseMessage {
    public let type: MessageType
    public let id: String
    public let thread: ThreadDecorator
    public let results: [CredentialExchangeItem]
    
    public init(thread: ThreadDecorator, results: [CredentialExchangeItem]) {
        self.type = MessageType.credentialsListMessage
        self.id = UUID().uuidString
        self.thread = thread
        self.results = results
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case thread = "~thread"
        case results
    }
}
