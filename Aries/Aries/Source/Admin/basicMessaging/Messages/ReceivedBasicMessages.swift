//
//  ReceivedBasicMessages.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public struct ReceivedBasicMessages: BaseMessage {
    
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let thread: ThreadDecorator
    public let count: Int
    public let offset: Int
    public let remaining: Int
    public let messages: AdminBasicMessage
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectionId = "connection_id"
        case thread = "~thread"
        case count
        case offset
        case remaining
        case messages
    }
}




//public class ReceivedBasicMessages extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/messages";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    @SerializedName("~thread")
//    public ThreadDecorator thread;
//
//    public int count;
//    public int offset;
//    public int remaining;
//    public AdminBasicMessage[] messages;
//}
