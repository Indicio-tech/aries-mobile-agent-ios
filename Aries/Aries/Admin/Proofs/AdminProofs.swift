//
//  AdminProofs.swift
//  Aries
//
//  Created by David Clawson on 12/14/21.
//

import Foundation


public class AdminProofs {
    
    private var messageSender: MessageSender
    private var adminConnection: ConnectionRecord

    public init (messageSender: MessageSender, adminConnection: ConnectionRecord){
        self.messageSender = messageSender
        self.adminConnection = adminConnection
    }
    
    
    /// Sets the admin connection
    /// - Parameter adminConnection: admin connection to be set.
    private func setAdminconnection(adminConnection: ConnectionRecord){
        self.adminConnection = adminConnection
    }
    
    
    /// <#Description#>
    public func sendGetAllCredentials(){
        
    }
    
    
    /// <#Description#>
    /// - Parameter credentialExchangeId: <#credentialExchangeId description#>
    public func sendAcceptCredentialOffer(credentialExchangeId: String){
        
    }
    
    
    
}
