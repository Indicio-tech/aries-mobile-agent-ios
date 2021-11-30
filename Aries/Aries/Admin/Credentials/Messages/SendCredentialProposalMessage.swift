//
//  SendCredentialProposalMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/13/21.
//

import Foundation

public struct SendCredentialProposalMessage: BaseMessage {
    public let type: MessageType
    public let id: String
    public let trace: Bool
    public let connectionId: String
    public let credDefId: String
    public let schemaId: String
    public let schemaIssuerDid: String
    public let schemaName: String
    public let schemaVersion: String
    public let issuerDid: String
    public let autoRemove: Bool
    public let comment: String
    public let credentialProposal: CredentialProposalDict

    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case trace
        case connectionId = "connection_id"
        case credDefId = "cred_def_id"
        case schemaId = "schema_id"
        case schemaIssuerDid = "schema_issuer_did"
        case schemaName = "schema_name"
        case schemaVersion = "schema_version"
        case issuerDid = "issuer_did"
        case autoRemove = "auto_remove"
        case comment
        case credentialProposal = "credential_proposal"
    }
}



//public class SendCredentialProposalMessage extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/send-credential-proposal";
//
//    public boolean trace;
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    @SerializedName("cred_def_id")
//    public String credDefId;
//
//    @SerializedName("schema_id")
//    public String schemaId;
//
//    @SerializedName("schema_issuer_did")
//    public String schemaIssuerDid;
//
//    @SerializedName("schema_name")
//    public String schemaName;
//
//    @SerializedName("schema_version")
//    public String schemaVersion;
//
//    @SerializedName("issuer_did")
//    public String issuerDid;
//
//    @SerializedName("auto_remove")
//    public boolean autoRemove;
//
//    public String comment;
//
//    @SerializedName("credential_proposal")
//    public CredentialProposalDict credentialProposal;
//}
