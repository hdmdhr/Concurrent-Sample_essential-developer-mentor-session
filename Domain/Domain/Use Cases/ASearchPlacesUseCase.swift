//
//  ASearchPlacesUseCase.swift
//  Domain
//
//  Created by 胡洞明 on 2021-11-17.
//

import Foundation

public protocol ASearchPlacesUseCase {
    
    func search(query: Places.SearchQuery) async throws -> InnerPagingEnvelop<Places.Place>
    
}
