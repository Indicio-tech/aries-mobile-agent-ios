//
//  MessageUtils.swift
//  Aries
//
//  Created by Patrick Kenyon on 12/2/21.
//

import Foundation

public class MessageUtils {
    public static func buildMessage<MessageClass: BaseMessage>(_ messageClassType: MessageClass.Type, _ payload: Data)throws->MessageClass{
        let decoder = JSONDecoder()
        let message = try decoder.decode(messageClassType, from: payload)
        return message
    }
    
    public static func toData<MessageClass: BaseMessage>(_ message: MessageClass)throws ->Data{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(message)
        return data
    }
}
