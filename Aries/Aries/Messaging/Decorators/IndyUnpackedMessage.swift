//
//  IndyUnpackedMessage.swift
//  Aries
//
//  Created by David Clawson on 10/20/21.
//
//
import Foundation
import Indy

struct IndyUnpackedMessage: Codable {
    let message, recipientVerkey, senderVerkey: String

    enum CodingKeys: String, CodingKey {
        case message
        case recipientVerkey = "recipient_verkey"
        case senderVerkey = "sender_verkey"
    }
}
