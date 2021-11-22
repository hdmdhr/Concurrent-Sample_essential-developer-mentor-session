//
//  Staging.Account.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-11.
//

import Foundation

extension APIs.Staging {
    
    enum Account: String, HasBaseUrl, UrlConvertible {
        static let baseUrl: URL? = APIs.Staging.baseUrl?.appendingPathComponent(path)
        
        case refreshToken = "refreshtoken"
        
        enum Phone: String, HasBaseUrl, UrlConvertible {
            static let baseUrl: URL? = Account.baseUrl?.appendingPathComponent(path)
            
            case verify
        }
    }
    
    
}
