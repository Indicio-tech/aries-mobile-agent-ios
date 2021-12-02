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
    
//  Returns true if value has been removed, false if value has not been found.
    public func removeListener(_ listenerName: String)-> Bool{
        return callbacks.removeValue(forKey: listenerName) != nil
    }
    
    public func triggerEvent(_ recordType: RecordType, _ latestRecord: Data, _ prevRecord: Data? = nil){
        for (_, cb) in callbacks{
            DispatchQueue.global().async{
                cb(recordType, latestRecord, prevRecord)
            }
        }
    }
}
