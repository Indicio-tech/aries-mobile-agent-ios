//
//  TransportDecorator.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public class TransportDecorator: Codable{
    public let returnRoute: String

    public init(returnRoute: String) {
        self.returnRoute = returnRoute;
    }
    
    enum CodingKeys : String, CodingKey {
        case returnRoute = "return_route"
    }
}

//public class TransportDecorator {
//    @SerializedName("return_route")
//    public String returnRoute;
//
//    public TransportDecorator(String returnRoute) {
//        this.returnRoute = returnRoute;
//    }
//}
