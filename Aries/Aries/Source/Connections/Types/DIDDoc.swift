//
//  DIDDoc.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class DIDDoc: Codable{
    public let context:String
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
    
    public init(did: String, verkey: String){
        self.context = "https://w3id.org/did/v1"
        self.id = did
        self.publicKey = PublicKey(id:id, type: "Ed25519VerificationKey2018", controller: id, publicKeyBase58: id+"#1")
        self.service = IndyService(
            id: did+"#did-communication",
            type: "did-communication",
            priority: 0,
            recipientKeys: [verkey],
            routingKeys: [],
            serviceEndpoint: "didcomm:transport/queue"
        )
    }
    
}
