//
//  AdminPresentationProposal.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct AdminPresentationProposal: Codable {
    public let type: MessageType
    public let attributes: [String : String]
    public let predicates: [String : String]
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case attributes
        case predicates
    }
}
