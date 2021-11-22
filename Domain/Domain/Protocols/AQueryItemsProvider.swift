//
//  AQueryItemsProvider.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-16.
//

import Foundation

public protocol AQueryItemsProvider {
    
    func queryItems() throws -> [URLQueryItem]?
    
}


extension Dictionary: AQueryItemsProvider where Key == String {
    
    public func queryItems() -> [URLQueryItem]? {
        reduce(into: [URLQueryItem]()) { acc, keyValue in
            acc?.append(URLQueryItem(name: keyValue.key, value: "\(keyValue.value)"))
        }
    }
    
}



extension AQueryItemsProvider where Self: Encodable {
    
    public func queryItems() throws -> [URLQueryItem]? {
        let dict = try toDictionary(withEncoder: JSONEncoder())
        return dict?.queryItems()
    }
    
}
