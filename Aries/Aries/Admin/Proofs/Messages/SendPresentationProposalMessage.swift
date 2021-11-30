//
//  SendPresentationProposalMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/14/21.
//

import Foundation

public struct SendPresentationProposalMessage: BaseOutboundAdminMessage {
    public let type: MessageType
    public let id: String
    public let transport: TransportDecorator
    public let trace: Bool
    public let connectionId: String
    public let connection: String
    public let presentationProposal: AdminPresentationProposal
    public let autoPresent: Bool
    
    public init() {
        self.type = MessageType.sendPresentationProposalMessage
        self.id = UUID().uuidString
        self.transport = TransportDecorator(returnRoute: "all")
        self.trace = true
        self.connectionId = ""
        self.connection = ""
        self.presentationProposal = AdminPresentationProposal(type: .adminPresentationProposal, attributes: [:], predicates: [:])
        self.autoPresent = false
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case transport
        case trace
        case connectionId = "connection_id"
        case connection
        case presentationProposal = "presentation_proposal"
        case autoPresent
    }
    
}
