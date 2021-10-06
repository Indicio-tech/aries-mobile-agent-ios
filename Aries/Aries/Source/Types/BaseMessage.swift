//
//  BaseMessage.swift
//  Aries
//
//  Created by Dan Oaks on 9/27/21.
//

import Foundation
import Indy


protocol BaseMessage: Codable, Identifiable {
    var type: MessageType { get }
    var id: String { get }
}

struct TypeContainerMessage: BaseMessage {
    var type: MessageType
    var id: String
}
