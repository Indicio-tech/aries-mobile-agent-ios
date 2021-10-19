//
//  CredentialAttribute.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct CredentialAttribute: Codable {
    var name: String
    var value: String
    
    enum CodingKeys : String, CodingKey {
        case name
        case value
    }
}
