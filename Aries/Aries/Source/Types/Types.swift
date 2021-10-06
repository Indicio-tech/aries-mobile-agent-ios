//
//  Types.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public enum MessageType: String, Codable {
    case baseMessage = "base_message"
    case invitationMessage = "https://didcomm.org/connections/1.0/invitation"
    case connectionRequestMessage = "https://didcomm.org/connections/1.0/request"
    case connectionResponseMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/response"
    case trustPingMessage = "https://didcomm.org/trust_ping/1.0/ping"
}


//[{"@id": "asdf",
//    "@type": "https://didcomm.org/connections/1.0/invitation",
//   "recipientKeys": []
//}]
