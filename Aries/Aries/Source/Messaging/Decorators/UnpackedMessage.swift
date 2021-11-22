//
//  IndyUnpackedMessage.swift
//  Aries
//
//  Created by David Clawson on 10/20/21.
//
//
import Foundation
import Indy

struct UnpackedMessage: Codable {
    let message, recipientVerkey, senderVerkey: String

    enum CodingKeys: String, CodingKey {
        case message
        case recipientVerkey = "recipient_verkey"
        case senderVerkey = "sender_verkey"
    }
}
// Connections protocol - Some background here on the messages back and forth. 
// https://github.com/hyperledger/aries-rfcs/blob/main/features/0160-connection-protocol/README.md
