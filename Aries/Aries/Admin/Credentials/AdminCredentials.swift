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
    
    private func setAdminConnection(adminConenction: ConnectionRecord){
        self.adminConnection = adminConenction
    }
    
    public func sendGetAllCredentials(){
        
    }
    
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
