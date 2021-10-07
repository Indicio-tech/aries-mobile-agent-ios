//
//  AdminBasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation


public struct AdminBasicMessage: BaseMessage {
    
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let messageId: String
    public let state: String
    
    public init(content: String, connectionId: String) {
        self.type = MessageType.basicMessage
        self.connectionId = connectionId
        self.messageId = UUID().uuidString
        self.state = "sent"
        self.id = UUID().uuidString
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case messageId = "message_id"
        case connectionId = "connection_id"
        case state
    }
}


//public class AdminBasicMessage extends BasicMessage {
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    @SerializedName("message_id")
//    public String messageId;
//
//    public String state;
//
//    public AdminBasicMessage(String content, String connectionId) {
//        super(content);
//        this.connectionId = connectionId;
//        this.messageId = this.id = UUID.randomUUID().toString();
//        this.state = "sent";
//    }
//}
