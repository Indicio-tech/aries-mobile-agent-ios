//
//  DeleteConnectionMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/11/21.
//

import Foundation

public struct DeleteConnectionMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let transport: TransportDecorator
    
    public init(connectionId: String) {
        self.type = MessageType.deleteConnectionMessage
        self.id = UUID().uuidString
        self.connectionId = connectionId
        self.transport = TransportDecorator.init(returnRoute: "all")
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectoinId = "connection_id"
        case transport = "~transport"
    }
}


//public class DeleteConnectionMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/delete";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public DeleteConnectionMessage(String connectionId) {
//        this();
//        this.connectionId = connectionId;
//    }
//
//    public DeleteConnectionMessage() {
//        this.id = UUID.randomUUID().toString();
//    }
//
//}
