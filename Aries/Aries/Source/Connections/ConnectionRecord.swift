//
//  ConnectionsRecord.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class ConnectionRecord: BaseRecord{
    override let type = "connection"
    
    public let createdAt:String
    public let invitation:InvitationMessage
    public let state:ConnectionState
    public let autoAcceptConnection:Bool
    
    public let role:String
    public let did:String
    public let didDoc: DIDDoc
    public let verkey:String
    public let label:String
    
    public let theirDid:String
    public let theirDidDoc: DIDDoc
    public let theirLabel:String
    public let threadId:String
    
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
        self.id = id
        self.createdAt = createdAt
        self.invitation = invitation
        self.state = state
        self.autoAcceptConnection = autoAcceptConnection
        self.role = role
        self.label = label
        self.tags = tags
    }
    
    public enum ConnectionState {
        case INVITED
        case REQUESTED
        case RESPONDED
        case COMPLETE
    }

}
