//
//  ConnectionsRecord.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public struct ConnectionRecord: BaseRecord{
    
    public var type: RecordType
    public var id: String
    public var tags: [String : String]
    
    public var createdAt:String
    public var invitation:InvitationMessage
    public var state:ConnectionState
    public var autoAcceptConnection:Bool
    
    public var role:String
    public var did:String?
    public var didDoc: DIDDoc?
    public var verkey:String?
    public var label:String
    
    public var theirDid:String?
    public var theirDidDoc: DIDDoc?
    public var theirLabel:String?
    public var threadId:String?
    
    public init(
        id: String,
        createdAt: String,
        invitation: InvitationMessage,
        state: ConnectionState,
        autoAcceptConnection: Bool,
        role: String,
        label: String,
        tags: [String:String]
    ){
        self.type = RecordType.connectionRecord
        self.id = id
        self.createdAt = createdAt
        self.invitation = invitation
        self.state = state
        self.autoAcceptConnection = autoAcceptConnection
        self.role = role
        self.label = label
        self.tags = tags
    }
    
    public enum ConnectionState: Codable {
        case INVITED
        case REQUESTED
        case RESPONDED
        case COMPLETE
    }

}
