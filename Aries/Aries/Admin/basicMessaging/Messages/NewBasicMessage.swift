//
//  NewBasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation


public struct NewBasicMessage: BaseMessage {
    
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let message: AdminBasicMessage
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectionId = "connection_id"
        case message
    }
}



//public class NewBasicMessage extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/new";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public AdminBasicMessage message;
//}
