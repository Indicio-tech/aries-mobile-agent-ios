//
//  AdminMatchingCredentialsRecord.swift
//  Aries
//
//  Created by Dan Oaks on 10/14/21.
//

import Foundation

public struct AdminMatchingCredentialsRecord: BaseRecord {
    public let type: RecordType
    public let id: String
    public let adminConnection: ConnectionRecord
    public let threadId: String
    public let presentationExchangeId: String
    public let messageObject: PresentationMatchingCredentialsMessage
    public let matchingCredentials: [MatchingCredentials]
    public let tags: [String:String]
    
    public init(message: PresentationMatchingCredentialsMessage, adminConnection: ConnectionRecord) {
        self.type = RecordType.adminMatchingCredentialsRecord
        self.id = message.id
        self.adminConnection = adminConnection
        self.messageObject = message
        self.threadId = message.thread
        self.presentationExchangeId = message.presentationExchangeId
        self.matchingCredentials = message.matchingCredentials
        self.tags = ["adminConnection":adminConnection.id]
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case adminConnection
        case messageObject
        case threadId
        case presentationExchangeId
        case matchingCredentials
        case tags
    }
}



//public class AdminMatchingCredentialsRecord extends BaseRecord {
//    public static final String type = "admin_presentation_matching_credentials";
//    public ConnectionRecord adminConnection;
//    public String threadId;
//    public String presentationExchangeId;
//    public PresentationMatchingCredentialsMessage messageObject;
//    public MatchingCredentials[] matchingCredentials;
//
//    public AdminMatchingCredentialsRecord(PresentationMatchingCredentialsMessage message, ConnectionRecord adminConnection) {
//        this.adminConnection = adminConnection;
//        this.messageObject = message;
//        this.threadId = message.thread.thid;
//        this.presentationExchangeId = message.presentationExchangeId;
//        this.matchingCredentials = message.matchingCredentials;
//        this.id = message.id;
//        this.tags = new JsonObject();
//        tags.addProperty("adminConnection", adminConnection.id);
//    }
//
//    @Override
//    public String getType() {
//        return type;
//    }
//}
