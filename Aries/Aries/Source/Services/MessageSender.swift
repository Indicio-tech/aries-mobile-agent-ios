//
//  MessageSender.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class MessageSender{
    private let ariesWallet: AriesWallet
    private let transportService: TransportService
    
    init(ariesWallet: AriesWallet, messageReceiver: MessageReceiver){
        self.ariesWallet = ariesWallet
        self.transportService = TransportService(messageReceiver: messageReceiver, messageSender: self)
    }
    
    public func sendMessage(message: BaseMessage, connectionRecord: ConnectionRecord){
        let endpoint:String
        let recipientKeys:[String]
        
        if(connectionRecord.theirDidDoc != nil){
            let service = selectService(services: connectionRecord.theirDidDoc.service)
            endpoint = service.serviceEndpoint
            recipientKeys = service.recipientKeys
        }else{
            endpoint = connectionRecord.invitation.serviceEndpoint
            recipientKeys = connectionRecord.invitation.recipientKeys
        }
        
        let senderVerkey = connectionRecord.verkey
        
        //Log message data
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(message)
        let messageJson = String(data: data, encoding: .utf8)
        
        print("Sending message of type: "+message.type+" to endpoint: "+endpoint+"\n message: "+messageJson)
        
        //Pack message
        let packedMessage = ariesWallet.packMessage(message: message, recipientKeys: recipientKeys, senderVerkey: senderVerkey)
        
        self.transportService.send(message: packedMessage, endpoint: endpoint, connection: connectionRecord)
    }
    
    private func selectService(services: [IndyService], protocolPreference:[String] = ["wss", "ws", "https", "http"]) -> IndyService{
        //Loop through protocols and try to get the prefered one
        for prot in protocolPreference {
            for service in services {
                if(service.serviceEndpoint.hasPrefix(prefix: prot)){
                    return service
                }
            }
        }
        //If prefered protocol isn't available return the first one
        return services[0]
    }
}
