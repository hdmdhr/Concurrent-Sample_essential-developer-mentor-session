//
//  SearchQuery.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-16.
//

import Foundation

public extension Places {
    
    struct SearchQuery: Encodable, AQueryItemsProvider {
        public init(type: Places.TypeEnum? = nil, keyword: String? = nil, page: Int = 0, perPage: Int = 10) {
            self.type = type
            self.keyword = keyword
            self.page = page
            self.perPage = perPage
        }
        
        public var type: TypeEnum?
        public var keyword: String?
        public var page: Int = 0
        public let perPage: Int
    }
    
    enum TypeEnum: String, Codable {
        case restaurant,
             gym,
             theatre,
             museum,
             gallery,
             casino,
             park
    }
    
}

