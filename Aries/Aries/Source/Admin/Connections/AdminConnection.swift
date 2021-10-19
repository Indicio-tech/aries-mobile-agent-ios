//
//  AdminConnection.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation
import Indy

//public protocol BaseMessage: Codable {
//    var type: MessageType { get }
//    var id: String { get }
//}
//
//public struct TypeContainerMessage: BaseMessage {
//    public var type: MessageType
//    public var id: String
//
//    enum CodingKeys : String, CodingKey {
//        case type = "@type"
//        case id = "@id"
//    }
//}


public struct AdminConnection: Codable {
    
    var theirDid: String?
    var connectionId: String?
    var label: String?
    var state: String?
    var myDid: String?
    var rawRepr: [String : String]?
    public init(message: ConnectedMessage) {
        self.theirDid = message.theirDid
        self.connectionId = message.connectionId
        self.label = message.label
        self.state = message.state
        self.rawRepr = message.rawRepr
        self.myDid = message.myDid
    }

    enum CodingKeys : String, CodingKey {
        case theirDid = "ther_did"
        case connectionId = "connection_id"
        case label
        case state
        case rawRepr = "raw_repr"
        case myDid = "my_did"
        
    }
}



//public class AdminConnection {
//    @SerializedName("their_did")
//    public String theirDid;
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public String label;
//
//    public String state;
//
//    @SerializedName("raw_repr")
//    public JsonObject rawRepr;
//
//    @SerializedName("my_did")
//    public String myDid;
//
//    public AdminConnection(ConnectedMessage message) {
//        this.theirDid = message.theirDid;
//        this.connectionId = message.connectionId;
//        this.label = message.label;
//        this.state = message.state;
//        this.rawRepr = message.rawRepr;
//        this.myDid = message.myDid;
//    }
//}
