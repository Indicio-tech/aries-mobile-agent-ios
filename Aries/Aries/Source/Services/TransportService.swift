//
//  TransportService.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class TransportService{
    private let httpTransport:HTTPService
    private let wsTransport:WSService
    
    public init(messageReceiver: MessageReceiver, messageSender: MessageSender){
        httpTransport = HTTPService(messageReceiver: messageReceiver)
        wsTransport = WSService(messageReceiver: messageReceiver, messageSender:messageSender)
    }
    
    public func send(message: Data, endpoint: String, connection: ConnectionRecord){
        if(endpoint.hasPrefix("ws")){
            print("Sending message through WS transport service")
            wsTransport.send(message: message, endpoint: endpoint, connection: connection)
        }else{
            print("Sending message through HTTP transport service")
            try! httpTransport.send(message: message,endpoint: endpoint)
        }
    }
}
