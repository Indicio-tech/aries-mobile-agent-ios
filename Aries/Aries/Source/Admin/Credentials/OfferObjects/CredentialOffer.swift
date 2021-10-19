//
//  CredentialOffer.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct CredentialOffer: Codable {
    public let schemaId: String
    public let credDefId: String
    public let nonce: String
    public let keyCorrectnessProof: [String : String]
    
    enum CodingKeys : String, CodingKey {
        case schemaId = "schema_id"
        case credDefId = "cred_def_id"
        case nonce
        case keyCorrectnessProof = "key_correctness_proof"
    }
}
