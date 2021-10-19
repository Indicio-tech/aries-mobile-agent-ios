//
//  WSService.swift
//  Aries
//
//  Created by David Clawson on 9/22/21.
//

import Foundation
import Starscream

public class WSService: WebSocket{
//    private let messageReceiver: MessageReceiver
//    private let messageSender: MessageSender
//    private let socketDic: [String, WebSocket]()
    
//    public init(messageReceiver: MessageReceiver, messageSender: MessageSender){
////        self.messageReceiver = messageReceiver
////        self.messageSender = messageSender
//    }
    
    override func didReceive(event: WebSocketEvent) {
    case WebSocket.connected
    }
    
    public func send(message: Data, endpoint: String, connection: ConnectionRecord){
        
    }
    
    private func getSocket(endpoint: String, connection: ConnectionRecord){
//        if(socketDic[endpoint]){
//            return socketDic[endpoint]
//        }else{
//            let url = URL(string: endpoint)
//            let socket = WebSocket(url: url)
//        }
    }
}
