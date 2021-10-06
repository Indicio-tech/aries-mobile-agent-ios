//
//  ConnectionRequestMessage.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/5/21.
//

import Foundation

public class ConnectionRequest: BaseMessage{
    public let label: String
    public let connection: AriesConnection
    public let transport: TransportDecorator
    
    public init(label: String, connection: AriesConnection){
        super.init()
        self.label = label
        self.connection = connection
        self.transport =  TransportDecorator(returnRoute: "all")
    }
    
    public init(label: String, connection: AriesConnection, id: String){
        self.id = id
        self.label = label
        self.connection = connection
        self.transport =  TransportDecorator(returnRoute: "all")
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
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
