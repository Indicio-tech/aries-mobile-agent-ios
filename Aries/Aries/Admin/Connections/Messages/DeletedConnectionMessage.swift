//
//  DeletedConnectionMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/11/21.
//

import Foundation

public struct DeletedConnectionMessage: BaseAdminConfirmationMessage {
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let thread: ThreadDecorator?
    
    public init(connectionId: String) {
        self.type = MessageType.deletedConnectionMessage
        self.id = UUID().uuidString
        self.connectionId = connectionId
        self.thread = ThreadDecorator(thid: id)
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectionId = "connection_id"
        case thread = "~thread"
    }
}



//public class DeletedConnectionMessage extends BaseAdminConfirmationMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/deleted";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public String getType() {
//        return type;
//    }
//}
