//
//  DIDDoc.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class DIDDoc: Codable {
    public let context:String?
    public let id:String
    public let publicKey:[PublicKey]
    public let authentication:[Authentication]
    public let service:[IndyService]
    
    public init(context: String, id: String, publicKey:[PublicKey], authentication:[Authentication], service:[IndyService]){
        self.context = context
        self.id = id
        self.publicKey = publicKey
        self.authentication = authentication
        self.service = service
    }
    
    convenience init(did: String, verkey: String){
        let context = "https://w3id.org/did/v1"
        let id = did
        let publicKey = [PublicKey(id:id, type: "Ed25519VerificationKey2018", controller: id, publicKeyBase58: id+"#1")]
        let authentication = [Authentication(type: "Ed25519SignatureAuthentication2018", publicKey: id + "#1")]
        let service = [IndyService(
            id: did+"#did-communication",
            type: "did-communication",
            priority: 0,
            recipientKeys: [verkey],
            routingKeys: [],
            serviceEndpoint: "didcomm:transport/queue"
        )]
        self.init(context: context, id: id, publicKey: publicKey, authentication: authentication, service: service)
    }
}

enum CodingKeys: String, CodingKey {
    case context = "@context"
}

