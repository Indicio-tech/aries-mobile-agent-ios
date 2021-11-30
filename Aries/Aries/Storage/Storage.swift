//
// Created by Patrick Kenyon on 10/6/21.
//

import Foundation

public class Storage{
    private let ariesWallet:AriesWallet
    private let events:AriesEvents

    public init(ariesWallet: AriesWallet, events: AriesEvents){
        self.ariesWallet = ariesWallet
        self.events = events
    }

    public func storeRecord<Record: BaseRecord>(record:Record, completion: @escaping (_ result: Result<Void, Error>)->Void){
        do{
            //Stringify record
            let data = try RecordUtils.toData(record)
            let recordJson = String(data: data, encoding: .utf8)
            self.events.triggerEvent(record.type, try RecordUtils.toData(record))
            ariesWallet.storeRecord(type: record.type.rawValue, id: record.id, value: recordJson!, tags: record.tags, completion: completion)
        }catch{
            completion(.failure(error))
        }
    }

    public func updateRecord<Record: BaseRecord>(record: Record, completion: @escaping (_ result: Result<Void, Error>)->Void){
        do {
            //Stringify record
            let data = try RecordUtils.toData(record)
            let recordJson = String(data: data, encoding: .utf8)
            
            //Fetch older version of record
            print("Fetching previous version of record for comparison...")
            retrieveRecord(type: record.type, id: record.id){(result:Result<Record, Error>) in
                switch(result){
                case(.success(let oldRecord)):
                    do{
                        print("Previous record version fetched.")
                        self.events.triggerEvent(record.type, try RecordUtils.toData(record), try RecordUtils.toData(oldRecord))
                        self.ariesWallet.updateRecord(type: record.type.rawValue, id: record.id, value: recordJson!, tags: record.tags, completion: completion)
                    }catch{
                        print("Failed to parse records to Data type")
                        completion(.failure(error))
                    }
                case (.failure(let e)):
                    print("Failed to fetch previous record")
                    print(recordJson)
                    
                    print(e)
                    completion(.failure(e))
                }
            }
        }catch{
            completion(.failure(error))
        }
    }
    
    public func retrieveRecord<recordObject: BaseRecord>(type: RecordType, id: String, completion: @escaping (_ result: Result<recordObject, Error>)->Void)-> Void{
        ariesWallet.retrieveRecord(type: type.rawValue, id: id){ result in
            switch(result){
                
                case(.success(let retrievedRecord)):
                    do {
                        print("Retreived record: \(retrievedRecord)")
                        let record = try RecordUtils.buildRecord(recordObject.self, retrievedRecord.value.data(using: .utf8)!)
                        completion(.success(record))
                    } catch {
                        completion(.failure(error))
                    }
                case(.failure(let err)):
                    completion(.failure(err))
            }
        }
    }
    
    public func retrieveRecordsByTags<recordObject: BaseRecord>(type: RecordType, tags: [String: String], limit: Int = 1, completion: @escaping (_ result: Result<[recordObject], Error>)->Void){
        ariesWallet.searchByQuery(type: type.rawValue, query: tags, limit: limit){ results in
            do{
                switch(results){
                case(.success(let recordsArray)):
                    let decoder = JSONDecoder()
                    var recordArray = [] as [recordObject]
                    for recordString in recordsArray {
                        let record = try decoder.decode(recordObject.self, from: recordString.data(using: .utf8)!)
                        recordArray.append(record)
                    }
                    completion(.success(recordArray))
                case(.failure(let err)):
                    completion(.failure(err))
                }
            }catch{
                completion(.failure(error))
            }
            
        }
    }
}
