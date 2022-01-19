//
//  AdminCredentialReceivedRecord.swift
//  Aries
//
//  Created by David Clawson on 12/2/21.
//

import Foundation

public class AdminCredentialReceivedRecord: BaseRecord {
    
    public var type: RecordType
    public var id: String
    public var tags: [String : String]
    public var adminConnection: ConnectionRecord
    public var messageObject: CredentialReceivedMessage
    public var attributes: [CredentialAttribute]
    public var credentialExchangeId: String
    public var connectionId: String
    
    public init(message: CredentialReceivedMessage, adminConnection: ConnectionRecord){
        self.type = RecordType.adminCredentialReceivedRecord
        self.adminConnection = adminConnection
        self.messageObject = message
        self.attributes = message.credentialProposalDict.credentialProposal.attributes
        self.connectionId = message.connectionId
        self.credentialExchangeId = message.credentialExchangeId
        self.id = message.id
        self.tags = ["adminConnection": adminConnection.id]
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case tags
        case adminConnection
        case messageObject
        case attributes
        case credentialExchangeId
        case connectionId
    }
}
