//
//  PagingEnvelop.swift
//  SwiftUI Intro
//
//  Created by 胡洞明 on 2021-10-16.
//

import Foundation

public typealias PagingEnvelop<T: Decodable> = Envelop<InnerPagingEnvelop<T>>


public struct InnerPagingEnvelop<T: Decodable>: Decodable {
    public let items: [T]
    public let currentPage, totalPages, totalItems, perPage: Int
}

