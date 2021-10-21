//
//  ConnectionResponseMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public struct ConnectionResponse: BaseMessage {
    
    public let type: MessageType
    public let id: String
    public let thread: ThreadDecorator
    public let label: String?
    public let connection: AriesConnection
    public let signedConnection: SignatureDecorator
    
    public init(label: String, connection: AriesConnection, thread: ThreadDecorator, signedConnection: SignatureDecorator) {
        self.type = MessageType.connectionResponseMessage
        self.label = label
        self.thread = thread
        self.connection = connection
        self.signedConnection = signedConnection
        self.id = UUID().uuidString
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case thread = "~thread"
        case signedConnection = "connection~sig"
        case label
        case connection
    }
}



//public class ConnectionResponse extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/response";
//
//    @SerializedName("~thread")
//    public ThreadDecorator thread;
//
//    public String label;
//
//
//    public Connection connection;
//
//    @SerializedName("connection~sig")
//    public SignatureDecorator signedConnection;
//
//    public ConnectionResponse(String label, Connection connection) {
//        this.label = label;
//        this.connection = connection;
//    }
//}
