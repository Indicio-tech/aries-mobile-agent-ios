//
//  Events.swift
//  Aries
//
//  Created by Patrick Kenyon on 11/29/21.
//

public class AriesEvents {
    private var callbacks: [String : (_ recordType: RecordType, _ latestRecord: Data, _ prevRecord: Data?)->Void] = [:]
    
    public func registerListener(_ listenerName: String, _ cb: @escaping (_ recordType: RecordType, _ latestRecord: Data, _ prevRecord: Data?)->Void){
        callbacks[listenerName] = cb
    }
    
    public func removeListener(_ listenerName: String){
        callbacks.removeValue(forKey: listenerName)
    }
    
    public func triggerEvent(_ recordType: RecordType, _ latestRecord: Data, _ prevRecord: Data? = nil){
        for (_, cb) in callbacks{
            DispatchQueue.global().async{
                cb(recordType, latestRecord, prevRecord)
            }
        }
    }
}
