//
//  NetworkError.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-16.
//

import Foundation

enum NetworkError: LocalizedError {
    
    /// Inner error is very likely to be an `EncodingError`
    case invalidRequest(innerError: Error)
    case decodingError(innerError: DecodingError, data: Data)
    case urlError(URLError)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest(let innerError):
            if let encodingError = innerError as? EncodingError {
                print(encodingError)
            }
            
            return "Invalid request"
            
        case let .decodingError(innerError, data):
            print(innerError)
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let message = jsonObject["message"] as? String
            else {
                return "Unable to parse returned data"
            }

            return message
            
        case .urlError(let urlError):
            let debugMessage = ([urlError.errorCode, urlError.failureURLString ?? "", urlError.code]).compactMap{ "\($0)" }.joined(separator: ", ")
            print(debugMessage)
            
            return urlError.localizedDescription
            
        case .unknown(let error):
            print(error)
            
            return "Unknown error"
        }
    }
    
}
