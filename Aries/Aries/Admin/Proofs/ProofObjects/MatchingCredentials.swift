//
//  MatchingCredentials.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct MatchingCredentials: Codable {
    public let credInfo: AdminCredentialInfo
    public let schemaId: String
    public let credDefId: String
    public let revRegId: String
    public let credRev: String
    public let presentationReferents: [String : String]
    
    enum CodingKeys : String, CodingKey {
        case credInfo = "cred_info"
        case schemaId = "schema_id"
        case credDefId = "cred_def_id"
        case revRegId = "rev_reg_id"
        case credRev = "cred_rev"
        case presentationReferents = "presentation_referents"
    }
}
