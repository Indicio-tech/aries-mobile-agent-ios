//
//  TransportDecorator.swift
//  Aries
//
//  Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public class TransportDecorator: Codable {
    public let returnRoute: String

    public init(returnRoute: String) {
        self.returnRoute = returnRoute;
    }
    
    enum CodingKeys : String, CodingKey {
        case returnRoute = "return_route"
    }
}
