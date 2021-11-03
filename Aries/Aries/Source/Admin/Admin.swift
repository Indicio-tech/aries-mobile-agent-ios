//
//  Admin.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/25/21.
//

import Foundation

public class Admin {
    public var adminConnection: ConnectionRecord?
    public var connectedToAdmin: Bool = false
    private var messageSender: MessageSender
    private var storage: Storage
    private var agentConnections: AriesConnections
    
    
    public func setAdminConnection(adminConnection: ConnectionRecord, connectionName: String = "default_admin_connection"){
        
    }
}
