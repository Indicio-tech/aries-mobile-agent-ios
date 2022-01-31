//
//  JSON.swift
//  Aries
//
//  Created by Patrick Kenyon on 1/19/22.
//

import Foundation

//https://gist.github.com/rnapier/d91175be2f737aca7ad476759948666e
@dynamicMemberLookup
public enum AriesJSON: Codable, CustomStringConvertible {
    public var description: String {
        switch self {
        case .string(let string): return "\"\(string)\""
        case .number(let double):
            if let int = Int(exactly: double) {
                return "\(int)"
            } else {
                return "\(double)"
            }
        case .object(let object):
            let keyValues = object
                .map { (key, value) in "\"\(key)\": \(value)" }
                .joined(separator: ",")
            return "{\(keyValues)}"
        case .array(let array):
            return "\(array)"
        case .bool(let bool):
            return "\(bool)"
        case .null:
            return "null"
        }
    }

    var isEmpty: Bool {
        switch self {
        case .string(let string): return string.isEmpty
        case .object(let object): return object.isEmpty
        case .array(let array): return array.isEmpty
        case .null: return true
        case .number, .bool: return false
        }
    }

    public struct Key: CodingKey, Hashable, CustomStringConvertible {
        public var description: String {
            return stringValue
        }

        public let stringValue: String
        init(_ string: String) { self.stringValue = string }
        public init?(stringValue: String) { self.init(stringValue) }
        public var intValue: Int? { return nil }
        public init?(intValue: Int) { return nil }
    }

    case string(String)
    case number(Double) // FIXME: Split Int and Double
    case object([Key: AriesJSON])
    case array([AriesJSON])
    case bool(Bool)
    case null

    public init(from decoder: Decoder) throws {
        if let string = try? decoder.singleValueContainer().decode(String.self) { self = .string(string) }
        else if let number = try? decoder.singleValueContainer().decode(Double.self) { self = .number(number) }
        else if let object = try? decoder.container(keyedBy: Key.self) {
            var result: [Key: AriesJSON] = [:]
            for key in object.allKeys {
                result[key] = (try? object.decode(AriesJSON.self, forKey: key)) ?? .null
            }
            self = .object(result)
        }
        else if var array = try? decoder.unkeyedContainer() {
            var result: [AriesJSON] = []
            for _ in 0..<(array.count ?? 0) {
                result.append(try array.decode(AriesJSON.self))
            }
            self = .array(result)
        }
        else if let bool = try? decoder.singleValueContainer().decode(Bool.self) { self = .bool(bool) }
        else if let isNull = try? decoder.singleValueContainer().decodeNil(), isNull { self = .null }
        else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [],
                                                                       debugDescription: "Unknown JSON type")) }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .string(let string):
            var container = encoder.singleValueContainer()
            try container.encode(string)
        case .number(let number):
            var container = encoder.singleValueContainer()
            try container.encode(number)
        case .bool(let bool):
            var container = encoder.singleValueContainer()
            try container.encode(bool)
        case .object(let object):
            var container = encoder.container(keyedBy: Key.self)
            for (key, value) in object {
                try container.encode(value, forKey: key)
            }
        case .array(let array):
            var container = encoder.unkeyedContainer()
            for value in array {
                try container.encode(value)
            }
        case .null:
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }

    public var objectValue: [String: AriesJSON]? {
        switch self {
        case .object(let object):
            let mapped: [String: AriesJSON] = Dictionary(uniqueKeysWithValues:
                object.map { (key, value) in (key.stringValue, value) })
            return mapped
        default: return nil
        }
    }

    public var arrayValue: [AriesJSON]? {
        switch self {
        case .array(let array): return array
        default: return nil
        }
    }

    subscript(key: String) -> AriesJSON? {
        guard let jsonKey = Key(stringValue: key),
            case .object(let object) = self,
            let value = object[jsonKey]
            else { return nil }
        return value
    }

    public var stringValue: String? {
        switch self {
        case .string(let string): return string
        default: return nil
        }
    }

    public var doubleValue: Double? {
        switch self {
        case .number(let number): return number
        default: return nil
        }
    }

    public var intValue: Int? {
        switch self {
        case .number(let number): return Int(number)
        default: return nil
        }
    }

    subscript(index: Int) -> AriesJSON? {
        switch self {
        case .array(let array): return array[index]
        default: return nil
        }
    }

    public var boolValue: Bool? {
        switch self {
        case .bool(let bool): return bool
        default: return nil
        }
    }

    public var anyValue: Any? {
        switch self {
        case .string(let string): return string
        case .number(let number):
            if let int = Int(exactly: number) { return int }
            else { return number }
        case .bool(let bool): return bool
        case .object(let object):
            return Dictionary(uniqueKeysWithValues:
                object.compactMap { (key, value) -> (String, Any)? in
                    if let nonNilValue = value.anyValue {
                        return (key.stringValue, nonNilValue)
                    } else { return nil }
                })
        case .array(let array):
            return array.compactMap{ $0.anyValue }
        case .null:
            return nil
        }
    }

    public var dictionaryValue: [String: Any]? {
        return anyValue as? [String: Any]
    }
    
    subscript(dynamicMember member: String) -> AriesJSON {
        return self[member] ?? .null
    }
}

extension AriesJSON {
    init(_ value: Any) throws {
        if let string = value as? String { self = .string(string) }
        else if let number = value as? NSNumber { self = .number(number.doubleValue) }
        else if let object = value as? [String: Any] {
            var result: [Key: AriesJSON] = [:]
            for (key, subvalue) in object {
                result[Key(key)] = try AriesJSON(subvalue)
            }
            self = .object(result)
        }
        else if let array = value as? [Any] {
            self = .array(try array.map(AriesJSON.init))
        }
        else if let bool = value as? Bool { self = .bool(bool) }
        else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [],
                                                                          debugDescription: "Cannot encode value"))
        }
    }
}

extension JSONEncoder {
    func stringEncode<T>(_ value: T) throws -> String where T : Encodable {
        // JSONEncoder promises to always return UTF-8
        return String(data: try self.encode(value), encoding: .utf8)!
    }
}
