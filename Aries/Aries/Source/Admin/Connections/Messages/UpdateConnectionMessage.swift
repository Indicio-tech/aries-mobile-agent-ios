//
//  UpdateConnectionMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/11/21.
//

import Foundation

public struct UpdateConnectionMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let connectionId: String
    public let label: String?
    public let role: String?
    public let transport: TransportDecorator
    
    public init(connectionId: String, label: String?, role: String?) {
        self.type = MessageType.deleteConnectionMessage
        self.id = UUID().uuidString
        self.connectionId = connectionId
        self.label = label
        self.role = role
        self.transport = TransportDecorator.init(returnRoute: "all")
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case connectoinId = "connection_id"
        case transport = "~transport"
        case label
        case role
    }
}


//public class UpdateConnectionMessage extends BaseOutboundAdminMessage {
//    @SerializedName("@type")
//    public final static String type = "https://github.com/hyperledger/aries-toolbox/tree/master/docs/admin-connections/0.1/update";
//
//    @SerializedName("connection_id")
//    public String connectionId;
//
//    public String label;
//    public String role;
//
//    private UpdateConnectionMessage(String connectionId) {
//        this.connectionId = connectionId;
//        this.id = UUID.randomUUID().toString();
//    }
//
//
//    /**
//     * @param config {
//     *               String role (Optional): Modify role of connection
//     *               String label (Optional): Modify label of connection
//     *               }
//     */
//    public UpdateConnectionMessage(String connectionId, JsonObject config) {
//        this(connectionId);
//        if (config.has("role"))
//            this.role = config.get("role").toString();
//        if (config.has("label"))
//            this.label = config.get("label").toString();
//    }
//}
