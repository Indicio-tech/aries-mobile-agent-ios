//
//  CredentialsListMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct CredentialsListMessage: BaseMessage {
    public let type: MessageType
    public let id: String
    public let thread: ThreadDecorator
    public let results: [CredentialExchangeItem]
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case thread = "~thread"
        case results
    }
}


//public class CredentialsListMessage extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credentials-list";
//
//    @SerializedName("~thread")
//    public ThreadDecorator thread;
//
//    public CredentialExchangeItem[] results;
//}
