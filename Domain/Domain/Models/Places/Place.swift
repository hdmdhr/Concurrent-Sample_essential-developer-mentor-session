//
//  Place.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-16.
//

import Foundation


public extension Places {
    
    struct Place: Decodable {
        public init(id: String, name: String, address: String, type: Places.TypeEnum, imageUrl: URL?) {
            self.id = id
            self.name = name
            self.address = address
            self.type = type
            self.imageUrl = imageUrl
        }
        
        public let id, name, address: String
        public let type: TypeEnum
        public let imageUrl: URL?
    }
    
}



extension Places.Place: Identifiable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Places.Place, rhs: Places.Place) -> Bool {
        lhs.id == rhs.id
    }
    
    
}
