//
//  HttpMethod.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-11.
//

import Foundation
import Domain


enum HttpRawMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}


enum HttpMethod {
    case get(queryItemsProvider: AQueryItemsProvider?)
    case mutable(method: HttpRawMethod, bodyDataProvider: ABodyDataProvider?)
    
    /// Shortcut
    static func get(provider: AQueryItemsProvider? = nil) -> Self {
        .get(queryItemsProvider: provider)
    }
    
    /// Shortcut
    static func post(body: Encodable, encoder: JSONEncoder = .init()) -> Self {
        self.init(method: .POST, body: body, encoder: encoder)
    }
    
    init(method: HttpRawMethod = .POST, body: Encodable, encoder: JSONEncoder = .init()) {
        self = .mutable(method: method,
                        bodyDataProvider: EncodableBodyDataProvider(body: body, jsonEncoder: encoder))
    }
    
    var httpRawMethod: HttpRawMethod {
        switch self {
        case .get:
            return HttpRawMethod.GET
        case let .mutable(method, _):
            return method
        }
    }
}
