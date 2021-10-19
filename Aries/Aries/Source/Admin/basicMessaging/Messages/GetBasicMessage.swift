//
//  GetBasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation

public struct GetBasicMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let offset: Int
    public let limit: Int
    public let transport: TransportDecorator
    
    public init(connectionId: String, offset: Int, limit: Int) {
        self.type = MessageType.getBasicMessage
        self.id = UUID().uuidString
        self.connectionId = connectionId
        self.offset = offset
        self.limit = limit
        self.transport = TransportDecorator(returnRoute: "all")
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectionId = "connection_id"
        case offset
        case limit
        case transport
    }
}


//public class GetBasicMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/get";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public int limit;
//    public int offset;
//
//    public GetBasicMessage() {
//        this.id = UUID.randomUUID().toString();
//    }
//
//    public GetBasicMessage(String connectionId) {
//        this();
//        this.connectionId = connectionId;
//    }
//
//    public GetBasicMessage(int limit) {
//        this();
//        this.limit = limit;
//    }
//
//    public GetBasicMessage(int limit, int offset) {
//        this(limit);
//        this.offset = offset;
//    }
//
//    public GetBasicMessage(String connectionId, int limit) {
//        this(connectionId);
//        this.limit = limit;
//    }
//
//    public GetBasicMessage(String connectionId, int limit, int offset) {
//        this(limit, offset);
//        this.connectionId = connectionId;
//    }
//
//}
