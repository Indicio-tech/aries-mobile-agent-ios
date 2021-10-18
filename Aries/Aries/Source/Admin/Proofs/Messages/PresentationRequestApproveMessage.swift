//
//  PresentationRequestApproveMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/14/21.
//

import Foundation

public struct PresentationRequestApproveMessage: BaseOutboundAdminMessage {
    
    public let type: MessageType
    public let id: String
    public let transport: TransportDecorator
    public let presentationExchangeId: String
    public let selfAttestedAttributes: [String : String]
    public var requestedAttributes: [String : RequestedJson]
    public var requestedPredicates: [String : RequestedJson]
    public let comment: String
    
    public init(record: AdminMatchingCredentialsRecord, presentationRequest: PresentationRequest, selfAttestedAttributes: [String : String], comment: String) {
        self.type = MessageType.presentationRequestApproveMessage
        self.id = UUID().uuidString
        self.transport = TransportDecorator(returnRoute: "all")
        self.presentationExchangeId = record.presentationExchangeId
        self.selfAttestedAttributes = selfAttestedAttributes
        self.comment = comment
        
        for match in record.matchingCredentials {
           let referent = match.credInfo.referent
            for (specifier,_) in match.credInfo.attrs {
                if (requestedAttributes[specifier] == nil) {
                    if (presentationRequest.requestedAttributes[specifier] != nil) {
                        let credDetails = RequestedJson(credId: referent, revealed: true)
                        self.requestedAttributes[specifier] = credDetails
                    } else if (presentationRequest.requestedPredicates[specifier] == nil) {
                        let credDetails = RequestedJson(credId: referent, revealed: nil)
                        self.requestedPredicates[specifier] = credDetails
                    }
                }
            }
        }
    }
    
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport = "~transport"
        case presentationExchangeId = "presentation_exchange_id"
        case selfAttestedAttributes = "self_attested_attributes"
        case requestedAttributes = "requested_attributes"
        case requestedPredicates = "requested_predicates"
        case comment
    }
    
}


//public class PresentationRequestApproveMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/presentation-request-approve";
//
//    @SerializedName("presentation_exchange_id")
//    public String presentationExchangeId;
//
//    @SerializedName("self_attested_attributes")
//    public JsonObject selfAttestedAttributes;
//
//    @SerializedName("requested_attributes")
//    public JsonObject requestedAttributes;
//
//    @SerializedName("requested_predicates")
//    public JsonObject requestedPredicates;
//
//    public String comment;
//
//    //TODO - Remove client side caching for soon to be added presentation request in MatchingCredentialsMessage
//    public PresentationRequestApproveMessage(AdminMatchingCredentialsRecord record, PresentationRequest presentationRequest) {
//        this.id = UUID.randomUUID().toString();
//        this.presentationExchangeId = record.presentationExchangeId;
//        this.requestedAttributes = new JsonObject();
//        this.requestedPredicates = new JsonObject();
//        this.selfAttestedAttributes = new JsonObject();
//        for (MatchingCredentials match : record.matchingCredentials) {
//            String referent = match.credInfo.referent;
//            for (String specifier : match.credInfo.attrs.keySet()) {
//                if (!requestedAttributes.has(specifier)) {
//                    if (presentationRequest.requestedAttributes.has(specifier)) {
//                        JsonObject credDetails = new JsonObject();
//                        credDetails.addProperty("cred_id", referent);
//                        credDetails.addProperty("revealed", true);
//                        requestedAttributes.add(specifier, credDetails);
//                    } else if (presentationRequest.requestedPredicates.has(specifier)) {
//                        JsonObject credDetails = new JsonObject();
//                        credDetails.addProperty("cred_id", referent);
//                        requestedPredicates.add(specifier, credDetails);
//                    }
//                }
//            }
//        }
//    }
//}
