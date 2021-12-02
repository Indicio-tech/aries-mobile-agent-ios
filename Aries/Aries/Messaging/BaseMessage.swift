//
//  BaseMessage.swift
//  Aries
//
//  Created by Dan Oaks on 9/27/21.
//

import Foundation
import Indy


public protocol BaseMessage: Codable {
    var type: MessageType { get }
    var id: String { get }
}

public struct TypeContainerMessage: BaseMessage {
    public var type: MessageType
    public var id: String

    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
    }
}
