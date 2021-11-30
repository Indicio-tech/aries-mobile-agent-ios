//
//  CredentialProposal.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct CredentialProposal: Codable {
    public let type: MessageType
    public let attributes: CredentialAttribute
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case attributes
    }
}
