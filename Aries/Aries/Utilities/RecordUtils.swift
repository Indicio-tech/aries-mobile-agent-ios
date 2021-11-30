//
//  RecordUtils.swift
//  Aries
//
//  Created by Patrick Kenyon on 11/29/21.
//

public class RecordUtils {
    public static func buildRecord<RecordClass: BaseRecord>(_ recordClassType: RecordClass.Type, _ payload: Data)throws->RecordClass{
        let decoder = JSONDecoder()
        let record = try decoder.decode(recordClassType, from: payload)
        return record
    }
    
    public static func toData<RecordClass: BaseRecord>(_ record: RecordClass)throws ->Data{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(record)
        return data
    }
}
