//
//  GetConnectionListMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/11/21.
//

import Foundation

public struct GetConnectionListMessage: BaseOutboundAdminMessage {
    
    public let type: MessageType
    public let id: String
    public let transport: TransportDecorator
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
    }
    
    public init(){
        self.id = UUID().uuidString
        self.transport = TransportDecorator(returnRoute: "all")
        self.type = .getConnectionsListMessage
    }
}


//public class GetConnectionListMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/get-list";
//
//    public GetConnectionListMessage() {
//        this.id = UUID.randomUUID().toString();
//    }
//
//}
