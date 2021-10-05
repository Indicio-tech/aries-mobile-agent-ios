//
//  BaseMessage.swift
//  Aries
//
//  Created by Dan Oaks on 9/27/21.
//

import Foundation
import Indy

public class BaseMessage: Codable {
    static var type = MessageType.baseMessage
    var id: String
    
    //Info on JSON encoding: https://benscheirman.com/2017/06/swift-json/
    
    public init(){
        self.id = UUID().uuidString;
    }
    
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
    }
    
    public enum MessageType: String, Decodable {
        case baseMessage = "base_message"
        case invitationMessage = "https://didcomm.org/connections/1.0/invitation"

    }
}
