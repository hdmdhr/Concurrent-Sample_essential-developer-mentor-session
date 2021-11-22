//
//  HttpClientConfig.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-16.
//

import Foundation

struct AccessToken {
    let token: String
    let expiryDate: Date
    
    var isValid: Bool { expiryDate > Date() }
    var isExpired: Bool { !isValid }
}

class HttpClientConfig {
    internal init(baseUrl: URL, headersType: HeadersType = .json, accessToken: AccessToken? = nil) {
        self.baseUrl = baseUrl
        self.headersType = headersType
        self.accessToken = accessToken
    }
    
    let baseUrl: URL
    let headersType: HeadersType
    var accessToken: AccessToken?
        
    var headers: [String: String] { headersType.headers }
}
