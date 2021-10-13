//
//  MessageSender.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class MessageSender{
    private let ariesWallet: AriesWallet
    private var transportService: TransportService? = nil
    
    init(ariesWallet: AriesWallet, messageReceiver: MessageReceiver){
        self.ariesWallet = ariesWallet
        self.transportService = TransportService(messageReceiver: messageReceiver, messageSender: self)
    }
    
    public func sendMessage<SomeMessageType: BaseMessage>(message: SomeMessageType, connectionRecord: ConnectionRecord){
        let endpoint:String
        let recipientKeys:[String]
        
        if(connectionRecord.theirDidDoc != nil){
            let service = selectService(services: connectionRecord.theirDidDoc!.service)
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
        
       print("Sending message of type: "+message.type.rawValue+" to endpoint: "+endpoint+"\n message: " + messageJson!)
        
        //Pack message
        try! _ = ariesWallet.packMessage(message: message, recipientKeys: recipientKeys, senderVerkey: senderVerkey!) { result in
            switch result {
            case .success(let data):
                //Send message
                self.transportService!.send(message: data, endpoint: endpoint, connection: connectionRecord)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func selectService(services: [IndyService], protocolPreference:[String] = ["wss", "ws", "https", "http"]) -> IndyService{
        //Loop through protocols and try to get the preferred one
//        for prot in protocolPreference {
//            for service in services {
//                if(service.serviceEndpoint.hasPrefix(prefix: prot)){
//                    return service
//                }
//            }
//        }
        //If preferred protocol isn't available return the first one
        return services[0]
    }
}
