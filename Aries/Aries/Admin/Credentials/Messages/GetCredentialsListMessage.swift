//
//  GetCredentialsListMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct GetCredentialsListMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let transport: TransportDecorator
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
    }
}


//public class GetCredentialsListMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credentials-get-list";
//
//    public GetCredentialsListMessage() {
//        this.id = UUID.randomUUID().toString();
//    }
//}
