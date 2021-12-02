//
//  IndyService.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/4/21.
//

import Foundation

public class IndyService: Codable{
    public let id:String
    public let type:String
    public let priority:Int
    public let recipientKeys:[String]
    public let routingKeys:[String]?
    public let serviceEndpoint:String
    
    public init(id: String, type: String, priority: Int, recipientKeys: [String], routingKeys: [String], serviceEndpoint: String){
        self.id = id
        self.type = type
        self.priority = priority
        self.recipientKeys = recipientKeys
        self.routingKeys = routingKeys
        self.serviceEndpoint = serviceEndpoint
    }
}
