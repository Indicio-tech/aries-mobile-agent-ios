//
//  AdminCredentialInfo.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct AdminCredentialInfo: Codable {
    public let referent: String
    public let attrs: [String : String]
    public let schemaId: String
    public let credDefId: String
    
    enum CodingKeys : String, CodingKey {
        case referent
        case attrs
        case schemaId = "schema_id"
        case credDefId = "cred_def_id"
    }
}
