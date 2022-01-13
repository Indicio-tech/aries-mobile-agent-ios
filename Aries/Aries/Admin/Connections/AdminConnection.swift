//
//  AdminConnection.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation
import Indy

public struct AdminConnection: Codable, Identifiable {
    
    public let id = UUID()
    var theirDid: String?
    var connectionId: String?
    public var label: String?
    var state: String?
    var myDid: String?
    var rawRepr: [String : String]?
    
    public init(message: ConnectedMessage) {
        self.theirDid = message.theirDid
        self.connectionId = message.connectionId
        self.label = message.label
        self.state = message.state
        self.rawRepr = message.rawRepr
        self.myDid = message.myDid
    }

    enum CodingKeys : String, CodingKey {
        case theirDid = "ther_did"
        case connectionId = "connection_id"
        case label
        case state
        case rawRepr = "raw_repr"
        case myDid = "my_did"
        
    }
}
