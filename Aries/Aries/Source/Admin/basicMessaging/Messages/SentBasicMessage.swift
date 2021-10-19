//
//  SentBasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation

public struct SentBasicMessage: BaseAdminConfirmationMessage {
    public let type: MessageType
    public let id: String
    public let thread: ThreadDecorator?
    public let connectionId: String
    public let message: AdminBasicMessage
    
    public init(connectionId: String, message: AdminBasicMessage) {
        self.type = MessageType.deletedBasicMessage
        self.id = UUID().uuidString
        self.connectionId = connectionId
        self.message = message
        self.thread = ThreadDecorator.init(thid: id)
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectionId = "connection_id"
        case thread = "~thread"
        case message
    }
}


//public class SentBasicMessage extends BaseAdminConfirmationMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/sent";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public AdminBasicMessage message;
//
//    public String getType() {
//        return type;
//    }
//}
