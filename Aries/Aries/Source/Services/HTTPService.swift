//
//  HTTPService.swift
//  Aries
//
//  Created by David Clawson on 9/22/21.
//

import Foundation

public class HTTPService{
    private let messageReceiver: MessageReceiver
    
    public init(messageReceiver: MessageReceiver){
        self.messageReceiver = messageReceiver
    }
    
    public func send(message: String, endpoint: String) throws {
        
        //Based off of https://www.advancedswift.com/http-requests-in-swift/
        guard
            let url = URL(string: endpoint)
        else{
            throw HTTPServiceError.invalidURL
            
        }
        var request = URLRequest(url:url)
        request.setValue("application/ssi-agent-wire", forHTTPHeaderField: "Content-Type")
        
//        let body = try? JSONSerialization.data(withJSONObject: message, options: [])
        
        let body = message.data(using: .utf8)
        
        request.httpMethod = "POST"
        request.httpBody = body
        
        //HTTP request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                self.messageReceiver.receiveMessage(message: data)
            }
        }
        task.resume()
    }
    
    enum HTTPServiceError: Error {
        case invalidURL
        case HTTPError
    }
}
