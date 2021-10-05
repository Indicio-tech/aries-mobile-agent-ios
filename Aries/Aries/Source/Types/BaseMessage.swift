//
//  BaseMessage.swift
//  Aries
//
//  Created by Dan Oaks on 9/27/21.
//

import Foundation
import Indy

public class BaseMessage: Codable {
    let type = ""
    let id = ""
    
    //Info on JSON encoding: https://benscheirman.com/2017/06/swift-json/
    
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
    }
}
