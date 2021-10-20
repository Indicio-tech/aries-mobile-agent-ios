//
//  AriesEmitter.swift
//  Aries
//
//  Created by David Clawson on 10/20/21.
//

import Foundation


public class AriesEmitter {
    
    private var callbacks: [ String: (_ messageType: BaseRecord)->Void] = [:]
    
    public func handleEvent(record: BaseRecord) {
        for (_, callback) in callbacks {
            callback(record)
        }
    }
    
    public func subscribe (id: String, callback: @escaping (_ messageType: BaseRecord)->Void){
        self.callbacks[id] = callback
    }
    
    public func unsubscribe(id: String){
        if self.callbacks.removeValue(forKey: id) != nil{
            print("Unsubscribed callback id: \(id)")
        } else {
            print("No callback of that id found")
        }
    }
}
