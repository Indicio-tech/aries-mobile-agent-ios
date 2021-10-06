//
//  AdminBasicMessage.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation


public class AdminBasicMessage: BasicMessage {
    
}


public class AdminBasicMessage extends BasicMessage {
    @SerializedName("connection_id")
    public String connectionId;

    @SerializedName("message_id")
    public String messageId;

    public String state;

    public AdminBasicMessage(String content, String connectionId) {
        super(content);
        this.connectionId = connectionId;
        this.messageId = this.id = UUID.randomUUID().toString();
        this.state = "sent";
    }
}
