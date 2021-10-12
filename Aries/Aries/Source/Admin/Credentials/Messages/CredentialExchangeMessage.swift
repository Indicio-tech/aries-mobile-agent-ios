//
//  CredentialExchangeMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/11/21.
//

import Foundation

public struct CredentialExchangeMessage {
    public let type: MessageType
    public let id: String
    public let state: String
    public let creadedAt: String
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
    public let credentialProposalDict: [String : String]
    public let credentialOfferDict: [String : String]
//    public let credentialOffer: CredentialOffer
    public let credentialRequest: [String : String]
    public let credentialRequestMetadata: [String : String]
    public let credentialId: String
    public let rawCredential: [String : String]
    public let credential: [String : String]
    public let autoOffer: Bool
    public let autoIssue: Bool
    public let autoRemove: Bool
    public let errorMsg: String
    public let revocRegId: String
    public let revocationId: String
    
}



//public class CredentialExchangeMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credential-exchange";
//
//    @SerializedName("@id")
//    public String id;
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
//    public JsonObject credentialProposalDict;
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
//    public JsonObject credential;
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
//}
