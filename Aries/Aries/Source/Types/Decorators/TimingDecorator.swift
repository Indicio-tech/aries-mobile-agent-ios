//
//  TimingDecorator.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public class TimingDecorator: Codable {
    public let outTime: String
    public let expiresTime: String
    public let delayMilli: Int
    
    enum CodingKeys : String, CodingKey {
        case outTime = "out_time"
        case expiresTime = "expires_time"
        case delayMilli = "delay_milli"
    }
}



//public class TimingDecorator {
//    @SerializedName("out_time")
//    public String outTime;
//
//    @SerializedName("expires_time")
//    public String expiresTime;
//
//    @SerializedName("delay_milli")
//    public int delayMilli;
//}
