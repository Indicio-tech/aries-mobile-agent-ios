//
//  DeletedBasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation


public struct DeletedBasicMessage: BaseAdminConfirmationMessage {
    
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let deleted: AdminBasicMessage
    public let thread: ThreadDecorator
    
    public init(connectionId: String, deleted: AdminBasicMessage) {
        self.type = MessageType.deletedBasicMessage
        self.id = UUID().uuidString
        self.connectionId = connectionId
        self.deleted = deleted
        self.thread = ThreadDecorator.init(thid: id)
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectionId = "connection_id"
        case deleted
        case thread
    }
}



//public class DeletedBasicMessage extends BaseAdminConfirmationMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/deleted";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public AdminBasicMessage[] deleted;
//
//    public String getType() {
//        return type;
//    }
//}
