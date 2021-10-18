//
//  CredentialOfferReceivedMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation
import Indy

public struct CredentialOfferReceivedMessage: BaseMessage {
    public let type: MessageType
    public let id: String
    public let state: String
    public let createdAt: String
    public let updatedAt: String
    public let trace: Bool
    public let credentialExchangeId: String
    public let connectionId: String
    public let threadId: String
    public let parentThreadId: String
    public let initiator: String
    public let role: String
    public let credentialDefinitionId: String
    public let schemaId: String
    public let credentialProposalDict: CredentialProposalDict
    public let credentialOfferDict: [String : String]
    public let credentialOffer: CredentialOffer
    public let credentialRequest: [String : String]
    public let credentialRequestMetadata: [String : String]
    public let credentialId: String
    public let rawCredential: [String : String]
    public let credential: AdminCredential
    public let autoOffer: Bool
    public let autoIssue: Bool
    public let autoRemove: Bool
    public let errorMsg: String
    public let revocRegId: String
    public let revocationId: String
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case state
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case trace
        case credentialExchangeId = "credential_exchange_id"
        case connectionId = "connection_id"
        case threadId = "thread_id"
        case parentThreadId = "parent_thread_id"
        case initiator
        case role
        case credentialDefinitionId = "credential_definition_id"
        case schemaId = "schema_id"
        case CredentialProposalDict = "credential_proposal_dict"
        case credentialOfferDict = "credential_offer_dict"
        case credentialOffer = "credential_offer"
        case credentialRequest = "credential_request"
        case credentialRequestMetadata = "credential_request_metadata"
        case credentialId = "credential_id"
        case rawCredential = "raw_credential"
        case credential
        case autoOffer = "auto_offer"
        case autoIssue = "auto_issue"
        case autoRemove = "auto_remove"
        case errorMsg = "error_msg"
        case revocRegId = "revoc_reg_id"
        case revocationId = "revocation_id"
    }

}



//public class CredentialOfferReceivedMessage extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credential-offer-received";
//
//    public String state;
//
//    @SerializedName("created_at")
//    public String createdAt;
//
//    @SerializedName("updated_at")
//    public String updatedAt;
//
//    public boolean trace;
//
//    @SerializedName("credential_exchange_id")
//    public String credentialExchangeId;
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    @SerializedName("thread_id")
//    public String threadId;
//
//    @SerializedName("parent_thread_id")
//    public String parentThreadId;
//
//    public String initiator;
//
//    public String role;
//
//    @SerializedName("credential_definition_id")
//    public String credentialDefinitionId;
//
//    @SerializedName("schema_id")
//    public String schemaId;
//
//    @SerializedName("credential_proposal_dict")
//    public CredentialProposalDict credentialProposalDict;
//
//    @SerializedName("credential_offer_dict")
//    public JsonObject credentialOfferDict;
//
//    @SerializedName("credential_offer")
//    public CredentialOffer credentialOffer;
//
//    @SerializedName("credential_request")
//    public JsonObject credentialRequest;
//
//    @SerializedName("credential_request_metadata")
//    public JsonObject credentialRequestMetadata;
//
//    @SerializedName("credential_id")
//    public String credentialId;
//
//    @SerializedName("raw_credential")
//    public JsonObject rawCredential;
//
//    public AdminCredential credential;
//
//    @SerializedName("auto_offer")
//    public boolean autoOffer;
//
//    @SerializedName("auto_issue")
//    public boolean autoIssue;
//
//    @SerializedName("auto_remove")
//    public boolean autoRemove;
//
//    @SerializedName("error_msg")
//    public String errorMsg;
//
//    @SerializedName("revoc_reg_id")
//    public String revocRegId;
//
//    @SerializedName("revocation_id")
//    public String revocationId;
//
//}
