//
//  CredentialProposalDict.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct CredentialProposalDict: Codable {
    public let type: MessageType
    public let id: String
    public let comment: String
    public let credentialProposal: CredentialProposal
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case comment
        case credentialProposal = "credential_proposal"
    }
}
