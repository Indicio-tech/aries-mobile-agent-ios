//
//  PageDecorator.swift
//  Aries
//
//  Created by Dan Oaks on 10/14/21.
//

import Foundation

public protocol PageDecorator: Codable {
    var count: Int { get }
    var offset: Int { get }
    var remaining: Int { get }
}

//public class PageDecorator {
//    public int count;
//    public int offset;
//    public int remaining;
//}
