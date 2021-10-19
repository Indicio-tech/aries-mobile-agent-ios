//
// Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public class Storage{
    private let ariesWallet:AriesWallet

    public init(ariesWallet: AriesWallet){
        self.ariesWallet = ariesWallet
    }

    public func storeRecord<Record: BaseRecord>(record: Record) {

        //Stringify record
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(record)
        let recordJson = String(data: data, encoding: .utf8)

        ariesWallet.storeRecord(type: record.type.rawValue, id: record.id, value: recordJson!, tags: record.tags)
    }

    public func updateRecord<Record: BaseRecord>(record: Record) {
        //Stringify record
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(record)
        let recordJson = String(data: data, encoding: .utf8)
        
        ariesWallet.storeRecord(type: record.type.rawValue, id: record.id, value: recordJson!, tags: record.tags)
    }
    
    public func retrieveRecord<Record: BaseRecord>(type: RecordType, id: String) throws -> Record {
        let recordData = try ariesWallet.retrieveRecord(type: type.rawValue, id: id)
        let decoder = JSONDecoder()
        let typeContainer = try decoder.decode(Record.self, from: recordData)
        
        return typeContainer
    }


}

//func asdf() {
//
//    let record: ConnectionRecord = try! Storage(ariesWallet: AriesWallet()).retrieveRecord(type: .connectionRecord, id: "abc")
//
//}
