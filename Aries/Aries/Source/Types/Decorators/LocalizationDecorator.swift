//
//  LocalizationDecorator.swift
//  Aries
//
//  Created by Dan Oaks on 10/6/21.
//

import Foundation

public class LocalizationDecorator: Codable {
    public let locale: String
    
    public init(locale: String) {
        self.locale = locale
    }
}
