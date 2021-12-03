//
//  ReceiveInvitationMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/11/21.
//

import Foundation

public struct ReceiveInvitationMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let autoAccept: Bool
    public let mediationId: String?
    public let invitation: String
    public let transport: TransportDecorator
    

    public init(invitation: String, autoAccept: Bool = true, mediationId: String?) {
        self.type = MessageType.receiveInvitationMessage
        self.id = UUID().uuidString
        self.autoAccept = autoAccept
        self.mediationId = mediationId
        self.invitation = invitation
        self.transport = TransportDecorator(returnRoute: "all")
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case autoAccept = "auto_accept"
        case mediationId = "mediation_id"
        case invitation
        case transport = "~transport"
    }
}



//public class ReceiveInvitationMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/receive-invitation";
//
//    @SerializedName("auto_accept")
//    public boolean autoAccept;
//
//    @SerializedName("mediation_id")
//    public String mediationId;
//
//    public String invitation;
//
//    public ReceiveInvitationMessage(String invitationUrl) {
//        this.id = UUID.randomUUID().toString();
//        this.invitation = invitationUrl;
//        this.autoAccept = true; //default autoAccept to true
//    }
//
//    public ReceiveInvitationMessage(String invitation, boolean autoAccept) {
//        this(invitation);
//        this.autoAccept = autoAccept;
//    }
//
//    public ReceiveInvitationMessage(String invitation, String mediationId) {
//        this(invitation);
//        this.mediationId = mediationId;
//    }
//
//    public ReceiveInvitationMessage(String invitation, boolean autoAccept, String mediationId) {
//        this(invitation, autoAccept);
//        this.mediationId = mediationId;
//    }
//}
