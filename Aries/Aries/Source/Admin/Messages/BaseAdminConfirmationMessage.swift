//
//  BaseAdminConfirmationMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/8/21.
//

import Foundation

protocol BaseAdminConfirmationMessage: BaseMessage {
    
    var type: MessageType { get }
    var id: String { get }
    var thread: ThreadDecorator { get }
}


//public abstract class BaseAdminConfirmationMessage extends BaseMessage {
//    @SerializedName("~thread")
//    public ThreadDecorator thread;
//
//    public String getType() {
//        return type;
//    }
//}
