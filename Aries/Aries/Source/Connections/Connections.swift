//
//  Connections.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/12/21.
//

import Foundation

public class ConnectionsModule{
    private let ariesWallet: AriesWallet
    private let messageSender: MessageSender
    private let storage: Storage
    
    public init(ariesWallet: AriesWallet, messageSender: MessageSender, storage: Storage){
        self.ariesWallet = ariesWallet
        self.messageSender = messageSender
        self.storage = storage
    }
}
