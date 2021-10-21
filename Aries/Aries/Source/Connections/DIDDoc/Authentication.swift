//
//  Authentication.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class Authentication: Codable{
    public let type:String
    public let publicKey:String
    
    init(type: String, publicKey: String){
        self.type = type
        self.publicKey = publicKey
    }
    
}
