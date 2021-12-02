//
//  SignatureDecorator.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public class SignatureDecorator: Codable {
    public var type: String
    public var sigData: String
    public var signature: String
    public var signer: String
    
    public init(type: String, signature: String, sigData: String, signer: String) {
        self.type = type
        self.signature = signature
        self.sigData = sigData
        self.signer = signer
    }
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case sigData = "sig_data"
        case signature
        case signer
    }
}
