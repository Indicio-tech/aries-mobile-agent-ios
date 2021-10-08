//
//  BaseRecord.swift
//  Aries
//
//  Created by Dan Oaks on 9/23/21.
//

import Foundation

public protocol BaseRecord: Codable{
    var type:RecordType { get }
    var id:String { get }
    var tags:[String:String] { get }
}

public struct TypeContainerRecord: BaseRecord {
    public var type: RecordType
    public var id: String
    public var tags: [String:String]
}
