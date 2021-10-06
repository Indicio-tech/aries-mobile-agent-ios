//
//  ThreadDecorator.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public class ThreadDecorator: Codable {
    public let thid: String
    public init(thid: String) {
        self.thid = thid
    }
}


//public class ThreadDecorator {
//    public String thid;
//
//    public ThreadDecorator(String thid) {
//        this.thid = thid;
//    }
//}
