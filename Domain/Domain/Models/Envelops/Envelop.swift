//
//  Envelop.swift
//  SwiftUI Introduction
//
//  Created by 胡洞明 on 2021-10-10.
//

import Foundation

public struct Envelop<D: Decodable>: Decodable {
    public let data: D
    public let code: String
    public let message, exceptionName, stackTrace: String?
}

