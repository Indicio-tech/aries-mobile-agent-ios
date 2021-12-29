//
//  AdminCredentials.swift
//  Aries
//
//  Created by David Clawson on 12/7/21.
//

import Foundation


public class AdminCredentials {
    
    private var messageSender: MessageSender
    private var adminConnection: ConnectionRecord
    
    public init(messageSender: MessageSender, adminConnection: ConnectionRecord){
        self.messageSender = messageSender
        self.adminConnection = adminConnection
    }
    
    /**
     Sets the instance's admin connection.
      - Parameters:
        - adminConenction: URL for the invitation.
     - Returns:
        - void
     */
    private func setAdminConnection(adminConenction: ConnectionRecord){
        self.adminConnection = adminConenction
    }
    
    /**
     Sends a ReceiveInvitation message to the admin connection to start a connection process.
     - Parameters:
       - None.
    - Returns:
       - Void.
     */
    public func sendGetAllCredentials() -> AdminCredentialsListReceivedRecord {
        let message = GetCredentialsListMessage()
        let listMessage = self.messageSender.sendMessage(message: message, connectionRecord: self.adminConnection)
        return AdminCredentialsListReceivedRecord(message: listMessage, adminConnection: self.adminConnection)
    }
    
    /**
     Sends the acceptance of the credential offer.
     - Parameters:
       - credentialExchangeId: ID for the credential exchange
    - Returns:
       - Void.
     */
    public func sendAcceptCredentialOffer(credentialExchangeId: String)-> AdminCredentialReceivedRecord {
        let message = CredentialOfferAcceptMessage(credentiaExchangeId: credentialExchangeId)
        let credentialReceiveMessage = self.messageSender.sendMessage(message: message, connectionRecord: self.adminConnection)
        return AdminCredentialReceivedRecord(message: credentialReceiveMessage, adminConnection: self.adminConnection)
    }
}
