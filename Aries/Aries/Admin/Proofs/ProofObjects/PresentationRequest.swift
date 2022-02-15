//
//  PresentationRequest.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct PresentationRequest: Codable {
    public let nonce: String
    public let name: String
    public let version: String
    public let requestedAttributes: AriesJSON?
    public let requestedPredicates: AriesJSON?
    
    enum CodingKeys : String, CodingKey {
        case nonce
        case name
        case version
        case requestedAttributes = "requested_attributes"
        case requestedPredicates = "requested_predicates"
    }
}
