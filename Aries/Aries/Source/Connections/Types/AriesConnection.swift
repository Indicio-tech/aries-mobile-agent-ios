//
//  AriesConnection.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public class AriesConnection: Codable {
  let did: String
  let didDoc: DIDDoc
  public init(did: String, didDoc: DIDDoc) {
    self.did = did
    self.didDoc = didDoc
  }
  enum CodingKeys : String, CodingKey {
    case did = "DID"
    case didDoc = "DIDDoc"
  }
}
