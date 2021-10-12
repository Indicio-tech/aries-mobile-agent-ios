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
    case basicMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basicmessage/1.0/message"
    case newBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/new"
    case deleteBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/delete"
    case deletedBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/deleted"
}

public enum RecordType: String, Codable {
    case baseRecord = "base_record"
    case connectionRecord = "connectionRecord"
}


//[{"@id": "asdf",
//    "@type": "https://didcomm.org/connections/1.0/invitation",
//   "recipientKeys": []
//}]
