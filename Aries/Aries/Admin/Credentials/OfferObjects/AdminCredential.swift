//
//  AdminCredential.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct AdminCredential: Codable {
    var referent: String
    var attributes: [String : String]
    var schemaId: String
    var credDefId: String 
    
    enum CodingKeys : String, CodingKey {
        case referent
        case attributes = "attrs"
        case schemaId = "schema_id"
        case credDefId = "cred_def_id"
    }
}
