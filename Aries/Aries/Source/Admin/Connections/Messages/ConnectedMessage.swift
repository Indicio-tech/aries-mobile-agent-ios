//
//  ConnectedMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation

public struct ConnectedMessage: BaseMessage {
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let label: String
    public let myDid: String
    public let state: String
    public let theirDid: String
    public let rawRepr: [String : String]
    
    public init() {
        self.id = UUID().uuidString
        self.type = MessageType.connectedMessage
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectionId = "connection_id"
        case label
        case myDid = "my_did"
        case state
        case theirDid = "their_did"
        case rawRepr = "raw_repr"
    }
}


//public class ConnectedMessage extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/connected";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public String label;
//
//    @SerializedName("my_did")
//    public String myDid;
//
//    public String state;
//
//    @SerializedName("their_did")
//    public String theirDid;
//
//    @SerializedName("raw_repr")
//    public JsonObject rawRepr;
//}
