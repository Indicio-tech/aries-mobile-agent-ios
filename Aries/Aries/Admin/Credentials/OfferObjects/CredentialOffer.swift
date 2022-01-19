//
//  CredentialOffer.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct CredentialOffer: Codable {
    public let schemaId: String?
    public let credDefId: String?
    public let nonce: String?
    public let keyCorrectnessProof: [String: Test]?
    
    enum CodingKeys : String, CodingKey {
        case schemaId = "schema_id"
        case credDefId = "cred_def_id"
        case nonce
        case keyCorrectnessProof = "key_correctness_proof"
    }
    
    public struct Test: Codable {
        let wrapped: Codable
        
        public init(from decoder: Decoder) throws {
            self.wrapped = "Credential Offer Test Value"
        }
        
        public func encode(to encoder: Encoder) throws {
            try self.wrapped.encode(to: encoder)
        }
    }
    
//    public struct KeyCorrectnessProof: Codable {
//        let c, xzCap: String
//        let xrCap: [[String]]
//
//        enum CodingKeys: String, CodingKey {
//            case c
//            case xzCap = "xz_cap"
//            case xrCap = "xr_cap"
//        }
//    }
}
