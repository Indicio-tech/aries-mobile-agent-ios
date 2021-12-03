//
//  AdminProofs.swift
//  Aries
//
//  Created by David Clawson on 12/2/21.
//

import Foundation

public class AdminProofs {
    
    private var messageSender: MessageSender
    private var adminConnection: ConnectionRecord
    
    public init(messageSender: MessageSender, adminConnection: ConnectionRecord){
        self.messageSender = messageSender
        self.adminConnection = adminConnection
    }
    
    private func setAdminConnection(adminConnection: ConnectionRecord){
        self.adminConnection = adminConnection
    }
    
    //TODO - PresentationsListMessage does not contain thread information
    private func sendGetPresentations(){
        
    }
    
    //TODO - PresentationsListMessage does not contain thread information
    private func sendGetPresentationsByConnection(connectionId: String){
        
    }
    
    public func sendGetMatchingCredentials(presentationExchangeId: String){
        
    }
    
    public func sendAcceptRequest(record: AdminMatchingCredentialsRecord, presentationRequest: PresentationRequest){
        
    }
    
    
}
