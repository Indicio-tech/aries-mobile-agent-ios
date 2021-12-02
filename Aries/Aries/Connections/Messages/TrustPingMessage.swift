//
//  TrustPingMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public struct TrustPingMessage: BaseMessage {
    
    public let type: MessageType
    public let id: String
    public let responseRequested: Bool?
    public let comment: String?
    public let timing: TimingDecorator?
    public let transport: TransportDecorator
    
    public init(responseRequested: Bool, comment: String, returnRoute: String) {
        self.id = UUID().uuidString
        self.type = MessageType.trustPingMessage
        self.responseRequested = responseRequested
        self.comment = comment
        self.transport = TransportDecorator(returnRoute: returnRoute)
        self.timing = nil
    }
    public init(returnRoute: String) {
        self.id = UUID().uuidString
        self.type = MessageType.trustPingMessage
        self.transport = TransportDecorator(returnRoute: returnRoute)
        self.timing = nil
        self.comment = nil
        self.responseRequested = nil
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case responseRequested = "response_requested"
        case timing = "~timing"
        case transport = "~transport"
        case comment
    }
    
}
