//
//  URL Protocols.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-11.
//

import Foundation


protocol HasBaseUrl {
    static var baseUrl: URL? { get }
}

extension HasBaseUrl {
    static var path: String { String(describing: Self.self).lowercased() }
}

protocol UrlConvertible {
    var optionalUrl: URL? { get }
}

extension UrlConvertible {
    var url: URL { optionalUrl! }
}

extension UrlConvertible where Self: HasBaseUrl & RawRepresentable, RawValue == String {
    var optionalUrl: URL? { Self.baseUrl?.appendingPathComponent(rawValue) }
}
