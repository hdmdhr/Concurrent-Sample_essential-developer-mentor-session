//
//  HeadersType.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-16.
//

import Foundation


enum HeadersType {
    case json
    case multipartForm
    case custom(headers: [String: String])
    
    var headers: [String: String] {
        switch self {
        case .json:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        case .multipartForm:
            return ["Content-Type": "multipart/form-data", "Accept": "application/json"]
        case .custom(let headers):
            return headers
        }
    }
}
