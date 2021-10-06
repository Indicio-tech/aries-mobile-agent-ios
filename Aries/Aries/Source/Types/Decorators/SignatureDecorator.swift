//
//  SignatureDecorator.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation


public class SignatureDecorator: Codable {
    public let type: String
    public let sigData: String
    public let signature: String
    public let signer: String
    
    public init(type: String, signature: String, sigData: String, signer: String) {
        self.type = type
        self.signature = signature
        self.sigData = sigData
        self.signer = signer
    }
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case sigData = "sig_data"
    }
}



//public class SignatureDecorator {
//
//    @SerializedName("@type")
//    public String type;
//
//    @SerializedName("sig_data")
//    public String sigData;
//
//    public String signature;
//    public String signer;
//
//    public SignatureDecorator(String type, String signature, String sigData, String signer) {
//        this.type = type;
//        this.signature = signature;
//        this.sigData = sigData;
//        this.signer = signer;
//    }
//}
