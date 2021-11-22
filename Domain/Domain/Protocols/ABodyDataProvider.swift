//
//  ABodyDataProvider.swift
//  SwiftUI Introduction
//
//  Created by 胡洞明 on 2021-10-10.
//

import Foundation
import Core

public protocol ABodyDataProvider {
    func bodyData() throws -> Data
}


public struct EncodableBodyDataProvider: ABodyDataProvider {
    
    public init(body: Encodable, jsonEncoder: JSONEncoder = .init()) {
        self.body = body
        self.jsonEncoder = jsonEncoder
    }
    
    let body: Encodable
    var jsonEncoder: JSONEncoder = .init()
    
    public func bodyData() throws -> Data {
        try body.toData(withEncoder: jsonEncoder)
    }
    
}

