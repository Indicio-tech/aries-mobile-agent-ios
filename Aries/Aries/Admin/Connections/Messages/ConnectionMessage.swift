//
//  ConnectionMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/9/21.
//

import Foundation

public struct ConnectionMessage: BaseMessage {
    public let type: MessageType
    public let id: String
    public let thread: ThreadDecorator
    public let label: String
    public let state: String
    public let rawRepr: [String : String]
    public let connectionId: String
    public let myDid: String
    
    public init(connectionId: String, label: String, state: String, rawRepr: [String : String], myDid: String) {
        self.type = MessageType.connectionMessage
        self.id = UUID().uuidString
        self.thread = ThreadDecorator.init(thid: id)
        self.label = label
        self.state = state
        self.rawRepr = rawRepr
        self.connectionId = connectionId
        self.myDid = myDid
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case thread = "~thread"
        case connectionId = "connection_id"
        case rawRepr = "raw_repr"
        case myDid = "my_did"
        case label
        case state
    }
    
}


//public class ConnectionMessage extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/connection";
//
//    @SerializedName("~thread")
//    public ThreadDecorator thread;
//
//    public String label;
//    public String state;
//
//    @SerializedName("raw_repr")
//    public JsonObject rawRepr;
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    @SerializedName("my_did")
//    public String myDid;
//}
