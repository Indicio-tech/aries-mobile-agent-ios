//
//  PublicKey.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class PublicKey: Codable{
    public let id:String
    public let type:String
    public let controller:String
    public let publicKeyBase58:String
    
    public init(id: String, type: String, controller: String, publicKeyBase58: String){
        self.id = id
        self.type = type
        self.controller = controller
        self.publicKeyBase58 = publicKeyBase58
    }
}
