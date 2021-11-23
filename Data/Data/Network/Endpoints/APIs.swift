//
//  APIs.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-11.
//

import Foundation

enum APIs {
    
    enum Places: String, HasBaseUrl, UrlConvertible {
        static let baseUrl: URL? = .init(string: "https://sample-api-new.herokuapp.com/")
        
        case searchPlaces = "places"
    }
    
    
    enum Staging: HasBaseUrl, UrlConvertible {
        static let baseUrl: URL? = .init(string: "https://api.staging.com/api/")
        
        case verifyPhone
        
        var optionalUrl: URL? {
            switch self {
            case .verifyPhone: return Account.Phone.verify.url
            }
        }
            
    }
    
    
}

