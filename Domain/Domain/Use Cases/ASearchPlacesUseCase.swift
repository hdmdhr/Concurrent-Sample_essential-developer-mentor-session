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


public class SearchPlacesUseCase: ASearchPlacesUseCase {
    
    public init(repo: APlacesRepo) {
        self.repo = repo
    }
    
    
    private let repo: APlacesRepo
    
    public func search(query: Places.SearchQuery) async throws -> InnerPagingEnvelop<Places.Place> {
        try await repo.search(query: query)
    }
    
}
