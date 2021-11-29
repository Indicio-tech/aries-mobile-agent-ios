//
//  SendBasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation

public struct SendBasicMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let content: String
    public let connectionId: String
    public let transport: TransportDecorator
    
    public init(content: String, connectionId: String) {
        self.type = MessageType.sendBasicMessage
        self.id = UUID().uuidString
        self.content = content
        self.connectionId = connectionId
        self.transport = TransportDecorator.init(returnRoute: "all")
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
        case connectionId = "connection_id"
        case content
    }
}

//public class SendBasicMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/send";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public String content;
//
//
//    public SendBasicMessage(String content, String connectionId) {
//        this.content = content;
//        this.connectionId = connectionId;
//        this.id = UUID.randomUUID().toString();
//    }
//}
