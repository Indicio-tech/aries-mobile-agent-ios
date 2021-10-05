//
//  BaseRecord.swift
//  Aries
//
//  Created by Dan Oaks on 9/23/21.
//

import Foundation

public class BaseRecord: Codable{
    public let type = "base_record"
    public let id:String
    public let tags:[String:String]
//    public JSONObject tags;
    
    public init(){
        self.id = UUID().uuidString;
        self.tags = [String:String]();
    }

}
