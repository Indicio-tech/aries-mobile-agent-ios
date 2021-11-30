//
//  CredentialOfferAcceptMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation
//import Indy

public struct CredentialOfferAcceptMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let credentialExchangeId: String
    public let transport: TransportDecorator
    
    public init(credentiaExchangeId: String) {
        self.type = MessageType.credentialOfferAcceptMessage
        self.id = UUID().uuidString
        self.credentialExchangeId = credentiaExchangeId
        self.transport = TransportDecorator(returnRoute: "all")
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case credentialExchangeId = "credential_exchange_id"
        case transport = "~transport"
    }
}


//public class CredentialOfferAcceptMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credential-offer-accept";
//
//    @SerializedName("credential_exchange_id")
//    public String credentialExchangeId;
//
//    public CredentialOfferAcceptMessage(String credentialExchangeId) {
//        this.id = UUID.randomUUID().toString();
//        this.credentialExchangeId = credentialExchangeId;
//    }
//}
