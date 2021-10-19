//
// Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public class Storage{
    private let ariesWallet:AriesWallet

    public init(ariesWallet: AriesWallet){
        self.ariesWallet = ariesWallet
    }

    public func storeRecord<Record: BaseRecord>(record:Record, completion: @escaping (_ result: Result<Void, Error>)->Void){

        //Stringify record
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(record)
        let recordJson = String(data: data, encoding: .utf8)

        ariesWallet.storeRecord(type: record.type.rawValue, id: record.id, value: recordJson!, tags: record.tags, completion: completion)
    }

    public func updateRecord<Record: BaseRecord>(record: Record, completion: @escaping (_ result: Result<Void, Error>)->Void){
        //Stringify record
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(record)
        let recordJson = String(data: data, encoding: .utf8)
        
        ariesWallet.updateRecord(type: record.type.rawValue, id: record.id, value: recordJson!, tags: record.tags, completion: completion)
    }
    
    public func retrieveRecord<recordObject: BaseRecord>(type: RecordType, id: String, completion: @escaping (_ result: Result<recordObject, Error>)->Void)-> Void{
        ariesWallet.retrieveRecord(type: type.rawValue, id: id){ result in
            switch(result){
                case(.success(let recordString)):
                    let decoder = JSONDecoder()
                    do {
                        let record = try decoder.decode(recordObject.self, from: recordString.data(using: .utf8)!)
                        completion(.success(record))
                    } catch {
                        completion(.failure(error))
                    }
                case(.failure(let err)):
                    completion(.failure(err))
            }
        }
    }
}

//func asdf() {
//
//    let record: ConnectionRecord = try! Storage(ariesWallet: AriesWallet()).retrieveRecord(type: .connectionRecord, id: "abc")
//
//}
