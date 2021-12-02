//
//  AdminConnections.swift
//  Aries
//
//  Created by Patrick Kenyon on 12/2/21.
//

import Foundation

public class AdminConnections {
    private let messageSender: MessageSender
    private let adminConnection: ConnectionRecord
    
    public init(messageSender:MessageSender, adminConnection: ConnectionRecord){
        self.messageSender = messageSender
        self.adminConnection = adminConnection
    }
    
    /**
     Sends a ReceiveInvitation message to the admin connection to start a connection process.
      - Parameters:
        - invitationUrl: URL for the invitation.
        - autoAccept: (Defaults to true) If you want the invitation to be accepted automatically.
        - mediationUrl: (Optional) The UUID of the mediator.
     - Returns: The sent ReceiveInvitation message for reference to events.
     */
    public func sendReceiveInvitation(invitationUrl: String, autoAccept: Bool = true, mediationId: String? = nil) -> ReceiveInvitationMessage{
        let message = ReceiveInvitationMessage(invitation: invitationUrl, autoAccept: autoAccept, mediationId: mediationId)
        messageSender.sendMessage(message: message, connectionRecord: adminConnection)
        return message
    }
    
    /**
     Sends a GetList message to the admin connection to receive a list of connections.
     - Returns: The send GetList message for reference to events
     */
    public func sendGetConnectionList() -> GetConnectionListMessage{
        let message = GetConnectionListMessage()
        messageSender.sendMessage(message: message, connectionRecord: adminConnection)
        return message
    }
    
    /**
     Sends a DeleteConnection message to the admin connection.
     - Parameters:
        - connectionId: The connection that you want to delete.
     - Returns: The DeleteConnection message for reference to events.
     */
    public func sendDeleteConnection(connectionId: String) -> DeleteConnectionMessage{
        let message = DeleteConnectionMessage(connectionId: connectionId)
        messageSender.sendMessage(message: message, connectionRecord: adminConnection)
        return message
    }
    
    /**
     Sends an UpdateConnection message to the admin to update a connection's label or role.
     - Parameters:
        - connectionId: The UUID of the connection to be updated.
        - newLabel: (Optional) The new label for the connection.
        - role: (Optional) The new role you want to assign the connection.
     - Returns: The UpdateConnection message for reference to events.
     */
    public func sendUpdateConnection(connectionId: String, newLabel: String? = nil, role: String? = nil) -> UpdateConnectionMessage{
        let message = UpdateConnectionMessage(connectionId: connectionId, label: newLabel, role: role)
        messageSender.sendMessage(message: message, connectionRecord: adminConnection)
        return message
    }
}
