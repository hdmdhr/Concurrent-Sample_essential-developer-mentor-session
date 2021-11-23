//
//  URL+QueryItem.swift
//  SwiftUI Introduction
//
//  Created by 胡洞明 on 2021-10-10.
//

import Foundation


extension URL {
    
    /// If any step throws an error, use the original url.
    mutating func appendQueryItems(_ queryItems: [URLQueryItem]?) {
        self = appendingQueryItems(queryItems)
    }
    
    
    /// - returns: A url after appending query items, if any step throws an error, the original url is returned.
    func appendingQueryItems(_ queryItems: [URLQueryItem]?) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return self }
        
        
        if components.queryItems == nil {
            components.queryItems = queryItems
        } else {
            components.queryItems?.append(contentsOf: queryItems ?? [])
        }
        
        return components.url ?? self
    }
    
}
