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
       - GetCredentialsListMessage.
     */
    public func sendGetAllCredentials() -> GetCredentialsListMessage {
        let message = GetCredentialsListMessage()
        self.messageSender.sendMessage(message: message, connectionRecord: self.adminConnection)
        return message
    }
    
    /**
     Sends the acceptance of the credential offer.
     - Parameters:
       - credentialExchangeId: ID for the credential exchange
    - Returns:
       - CredentialOfferAcceptMessage.
     */
    public func sendAcceptCredentialOffer(credentialExchangeId: String)-> CredentialOfferAcceptMessage {
        let message = CredentialOfferAcceptMessage(credentiaExchangeId: credentialExchangeId)
        self.messageSender.sendMessage(message: message, connectionRecord: self.adminConnection)
        return message
    }
}
