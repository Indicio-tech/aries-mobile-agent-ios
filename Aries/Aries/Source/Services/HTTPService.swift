//
//  HTTPService.swift
//  Aries
//
//  Created by David Clawson on 9/22/21.
//

import Foundation

public class HTTPService {
    private let messageReceiver: MessageReceiver
    
    public init(messageReceiver: MessageReceiver){
        self.messageReceiver = messageReceiver
    }
    
    public func send(message: Data, endpoint: String, completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        
        //Based off of https://www.advancedswift.com/http-requests-in-swift/
        guard
            let url = URL(string: endpoint)
        else {
            completion(.failure(HTTPServiceError.invalidURL))
            return
        }
        var request = URLRequest(url:url)
        request.setValue("application/ssi-agent-wire", forHTTPHeaderField: "Content-Type")
        
        do {
            let body = try JSONSerialization.data(withJSONObject: message, options: [])
            request.httpMethod = "POST"
            request.httpBody = body
        } catch {
            completion(.failure(HTTPServiceError.serializationError(error)))
            return
        }
        
        // HTTP request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(HTTPServiceError.HTTPError(error)))
            } else if let data = data {
                self.messageReceiver.receiveMessage(message: data)
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    enum HTTPServiceError: Error {
        case invalidURL
        case serializationError(Error)
        case HTTPError(Error)
    }
}
