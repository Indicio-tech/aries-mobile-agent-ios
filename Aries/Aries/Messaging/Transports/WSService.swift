//
//  WSService.swift
//  Aries
//
//  Created by David Clawson on 9/22/21.
//

import Foundation
import Starscream

public class WSService{
    private let messageReceiver: MessageReceiver
    private let messageSender: MessageSender
    private var socketDic: [String: WSDelegate]
    
    public init(messageReceiver: MessageReceiver, messageSender: MessageSender){
        self.messageReceiver = messageReceiver
        self.messageSender = messageSender
        self.socketDic = [String: WSDelegate]()
        
    }
    
    public func send(message: String, endpoint: String, connection: ConnectionRecord){
        let socket = getSocket(endpoint: endpoint, connection: connection)
        socket.sendMessage(message: message, connection: connection)
    }
    
    private func getSocket(endpoint: String, connection: ConnectionRecord) -> WSDelegate {
        if(socketDic[endpoint] != nil){
            return socketDic[endpoint]!
        }else{
            let delegate = WSDelegate(endPoint: endpoint, messageSender: messageSender, messageReceiver: messageReceiver)
            self.socketDic[endpoint]=delegate
            return delegate
        }
    }
}

private class WSDelegate: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        print("Websocket client received...")
    }
    
    
    private let socket: WebSocket
    private var isConnected: Bool = false
    private var connectionRecords: [ConnectionRecord] = []
    private var messageSender: MessageSender
    private var messageReceiver: MessageReceiver
    private var endPoint: String
    
    public init (endPoint: String, messageSender: MessageSender, messageReceiver: MessageReceiver ){
        self.messageSender = messageSender
        self.messageReceiver = messageReceiver
        self.endPoint = endPoint
        
        var request = URLRequest(url: URL(string: endPoint)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
    }

    func sendMessage(message: String, connection: ConnectionRecord){
        //Add connectionRecord to array if not already in it
        if(!inArray(connection, connectionRecordArray: connectionRecords)){
            connectionRecords.append(connection)
        }
        socket.write(string: message)
    }
    
    func handleError(_ error: Error?) {
        print(error?.localizedDescription ?? "")
    }
    
    func reconnect(){
        socket.connect()
    }
    
    func inArray(_ newRecord: ConnectionRecord, connectionRecordArray: [ConnectionRecord])->Bool {
        var result = false;
        for record in connectionRecordArray {
            if(record.id == newRecord.id){
                result = true
            }
        }
        return result
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            if (isConnected){
                //Send trust ping messages to all previous connections in this WS
                for connectionRecord in connectionRecords {
                    let trustPingMessasge = TrustPingMessage(returnRoute: "all")
                    self.messageSender.sendMessage(message: trustPingMessasge, connectionRecord: connectionRecord)
                }
            } else {
                isConnected = true
                print("Websocket is connected: \(headers)")
            }
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
            self.messageReceiver.receiveMessage(message: data)
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            if (isConnected){
                print("Socket \(self.endPoint) has been closed, retrying to connect")
                reconnect()
            }
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
}