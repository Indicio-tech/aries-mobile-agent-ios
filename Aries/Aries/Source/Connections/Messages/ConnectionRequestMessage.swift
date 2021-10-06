//
//  ConnectionRequestMessage.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/5/21.
//

import Foundation

struct ConnectionRequest: BaseMessage {
    let type: MessageType
    let id: String
    let label: String
    let connection: AriesConnection
    let transport: TransportDecorator
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
        case label = "label"
        case connection = "connection"
    }
    
    public init(label: String, connection: AriesConnection) {
        self.label = label
        self.connection = connection
        self.transport =  TransportDecorator(returnRoute: "all")
        self.id = UUID().uuidString
        self.type = .connectionRequestMessage
    }

    public init(label: String, connection: AriesConnection, id: String){
        self.label = label
        self.connection = connection
        self.transport =  TransportDecorator(returnRoute: "all")
        self.id = id
        self.type = .connectionRequestMessage
    }
}



//public class ConnectionRequest extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = ;
//
//    public String label;
//    public Connection connection;
//
//    //TODO: Replace with a decorator
//    @SerializedName("~transport")
//    public TransportDecorator transport;
//
//    public ConnectionRequest(String label, Connection connection) {
//        this.label = label;
//        this.connection = connection;
//        this.transport = new TransportDecorator("all");
//        this.id = UUID.randomUUID().toString();
//    }
//
//    public ConnectionRequest(String label, Connection connection, String id) {
//        this.label = label;
//        this.connection = connection;
//        this.transport = new TransportDecorator("all");
//        this.id = id;
//    }
//}
