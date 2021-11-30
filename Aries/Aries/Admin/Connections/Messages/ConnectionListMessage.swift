//
//  ConnectionListMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation

public struct ConnectionListMessage: BaseMessage {
    
    public let type: MessageType
    public let id: String
    public let thread: ThreadDecorator
    public let connections: AdminConnection
    
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case thread = "~thread"
        case connections
    }
}



//public class ConnectionListMessage extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/list";
//
//    @SerializedName("~thread")
//    public ThreadDecorator thread;
//    public AdminConnection[] connections;
//
//    public String getType() {
//        return type;
//    }
//}
