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
//    let connectionSig, connectionNoSig, signature, sig_data: String?

    enum CodingKeys: String, CodingKey {
        case message
        case recipientVerkey = "recipient_verkey"
        case senderVerkey = "sender_verkey"
//        case isSigned
    }
    
    enum MessageKeys: String, CodingKey {
        case connectionSig = "connection~sig"
        case connectionNoSig = "connection"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try values.decode(String.self, forKey: .message)
        self.recipientVerkey = try values.decode(String.self, forKey: .recipientVerkey)
        self.senderVerkey = try values.decode(String.self, forKey: .senderVerkey)
//        
//        if let messageContents = try values.nestedContainer(keyedBy: MessageKeys.self, forKey: .connectionSig){
//
//        }
  
            
        
//        self.connectionSig = "connection~sig"
//        self.signature = try values.decode(String.self, forKey: .connectionSig)

    }
    
}
// Connections protocol - Some background here on the messages back and forth. 
// https://github.com/hyperledger/aries-rfcs/blob/main/features/0160-connection-protocol/README.md
