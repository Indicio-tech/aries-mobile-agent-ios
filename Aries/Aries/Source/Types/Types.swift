//
//  Types.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public enum MessageType: String, Codable {
    case baseMessage = "base_message"
    case invitationMessage = "https://didcomm.org/connections/1.0/invitation"
    case connectionRequestMessage = "https://didcomm.org/connections/1.0/request"
    case connectionResponseMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/response"
    case trustPingMessage = "https://didcomm.org/trust_ping/1.0/ping"
    case basicMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basicmessage/1.0/message"
    case newBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/new"
    case deleteBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/delete"
    case deletedBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/deleted"
    case getBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/get"
    case sendBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/send"
    case receivedBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/messages"
    case sentBasicMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-basicmessage/0.1/sent"
    case connectedMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/connected"
    case connectionListMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/list"
    case connectionMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/connection"
    case deleteConnectionMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/delete"
    case deletedConnectionMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/deleted"
    case getConnectionMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/get-list"
    case receiveInvitationMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/receive-invitation"
    case updateConnectionMessage = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/update"
    case credentialExchangeMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credential-exchange"
    case credentialOfferAcceptMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credential-offer-accept"
    case credentialOfferReceivedMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credential-offer-received"
    case credentialReceivedMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credential-received"
    case credentialRequestSentMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credential-request-sent"
    case credentialsListMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credentials-list"
    case getCredentialsListMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/credentials-get-list"
    case sendCredentialsListMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/send-credential-proposal"
    case credentialProposal = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/credential-preview"
    case credentialProposalDict = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/issue-credential/1.0/propose-credential"
    case adminPresentationProposal = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/present-proof/1.0/presentation-preview"
    case presentationExchangeMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/presentation-exchange"
    case presentationGetMatchingCredentialsMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/presentation-get-matching-credentials"
    case presentationRequestApproveMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/presentation-request-approve"
    case presentationSentMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/presentation-sent"
    case presentationGetListMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/presentations-get-list"
    case presentationsListMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/presentations-list"
    case sendPresentationProposalMessage = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/admin-holder/0.1/send-presentation-proposal"
}

public enum RecordType: String, Codable {
    case baseRecord = "base_record"
    case connectionRecord = "connectionRecord"
    case adminMatchingCredentialsRecord = "admin_presentation_matching_credentials"
}

public struct RequestedJson: Codable {
    public let credId: String
    public let revealed: Bool?
    
    public init(credId: String,revealed: Bool?) {
        self.credId = credId
        self.revealed = revealed
    }
    enum CodingKeys : String, CodingKey {
        case credId = "cred_id"
        case revealed
    }
}

//[{"@id": "asdf",
//    "@type": "https://didcomm.org/connections/1.0/invitation",
//   "recipientKeys": []
//}]
