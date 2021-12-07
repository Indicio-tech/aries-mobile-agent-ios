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
    public func sendGetAllCredentials(){
        
    }
    
    /**
     Sends the acceptance of the credential offer.
     - Parameters:
       - credentialExchangeId: ID for the credential exchange
    - Returns:
       - Void.
     */
    public func sendAcceptCredentialOffer(credentialExchangeId: String){
        
    }
}


//
//    public CompletableFuture<AdminCredentialsListReceivedRecord> sendGetAllCredentials() {
//        return CompletableFuture.supplyAsync(() -> {
//            try{
//                GetCredentialsListMessage message = new GetCredentialsListMessage();
//                CredentialsListMessage listMessage = (CredentialsListMessage) this.messageSender.sendMessage(message, this.adminConnection).get();
//                return new AdminCredentialsListReceivedRecord(listMessage, this.adminConnection);
//            }catch (Exception e){
//                throw new CompletionException(e);
//            }
//        });
//    }
//
//    public CompletableFuture<AdminCredentialReceivedRecord> sendAcceptCredentialOffer(String credentialExchangeId) {
//        return CompletableFuture.supplyAsync(() -> {
//            try{
//                CredentialOfferAcceptMessage message = new CredentialOfferAcceptMessage(credentialExchangeId);
//                CredentialReceivedMessage credentialReceivedMessage = (CredentialReceivedMessage) this.messageSender.sendMessage(message, this.adminConnection).get();
//                return new AdminCredentialReceivedRecord(credentialReceivedMessage, this.adminConnection);
//            }catch (Exception e){
//                throw new CompletionException(e);
//            }
//        });
