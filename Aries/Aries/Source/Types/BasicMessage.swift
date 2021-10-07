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



//public class BasicMessage extends BaseMessage {
//    @SerializedName("@type")
//    public final static String type = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basicmessage/1.0/message";
//
//    @SerializedName("~l10n")
//    public LocalizationDecorator l10n;
//
//    //ISO 8601 Date format
//    @SerializedName("sent_time")
//    public String sentTime;
//
//    public String content;
//
//    public BasicMessage(String content) {
//        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss'Z'");
//        this.id = UUID.randomUUID().toString();
//        this.l10n = new LocalizationDecorator("en");
//        this.sentTime = df.format(new Date());
//        this.content = content;
//    }
//}
