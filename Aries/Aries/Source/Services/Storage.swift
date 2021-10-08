//
// Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public class Storage{
    private let ariesWallet:AriesWallet

    public init(ariesWallet: AriesWallet){
        self.ariesWallet = ariesWallet
    }

    public func storeRecord(record:BaseRecord){

        //Stringify record
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(record)
        let recordJson = String(data: data, encoding: .utf8)

        ariesWallet.storeRecord(type: record.type.rawValue, id: record.id, value: recordJson!, tags: record.tags)
    }

    public func updateRecord(record: BaseRecord) throws -> TypeContainerRecord{
        //Stringify record
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(record)
        let recordJson = String(data: data, encoding: .utf8)
        
        ariesWallet.storeRecord(type: record.type.rawValue, id: record.id, value: recordJson!, tags: record.tags)
    }
    
    public func retrieveRecord(type: RecordType, id: String)throws-> BaseRecord{
        let recordData = try ariesWallet.retrieveRecord(type: type.rawValue, id: id)
        let decoder = JSONDecoder()
        let typeContainer = try decoder.decode(TypeContainerRecord.self, from: recordData)
        
        return typeContainer
    }


}
