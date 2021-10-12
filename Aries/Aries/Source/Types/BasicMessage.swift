//
//  BasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public struct BasicMessage: BaseMessage {
    
    public let type: MessageType
    public let id: String
    public let l10n: LocalizationDecorator
    public let sentTime: String
    public let content: String
    
    public init (content: String) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss'Z'"
        self.type = MessageType.basicMessage
        self.l10n = LocalizationDecorator(locale: "en")
        self.content = content
        self.sentTime = df.string(from: Date())
        self.id = UUID().uuidString
    }
    
    enum CodingKeys : String, CodingKey {
        case type = "@type"
        case id = "@id"
        case l10n = "~l10n"
        case sentTime = "sent_time"
        case content
    }
    
}
