//
//  BaseOutBoundAdminMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/7/21.
//

import Foundation

protocol BaseOutboundAdminMessage: BaseMessage {
    
    var type: MessageType { get }
    var id: String { get }
    var transport: TransportDecorator { get }
}


//public class BaseOutboundAdminMessage extends BaseMessage {
//    @SerializedName("~transport")
//    public TransportDecorator transport = new TransportDecorator("all");
//}
