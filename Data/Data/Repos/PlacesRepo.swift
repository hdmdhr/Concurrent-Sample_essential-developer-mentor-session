//
//  PlacesRepo.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-17.
//

import Foundation
import Domain

public class PlacesRepo: APlacesRepo {
    
    private typealias API = APIs.Places
    
    public static let shared: PlacesRepo = .init(httpClient: HttpClient.stagingClient)
    
    internal init(httpClient: AHttpClient) {
        self.httpClient = httpClient
    }
    
    private let httpClient: AHttpClient
    
    public func search(query: Places.SearchQuery) async throws -> InnerPagingEnvelop<Places.Place> {
        let envelop: PagingEnvelop<Places.Place> = try await httpClient.request(url: API.searchPlaces,
                                                                                method: .get(queryItemsProvider: query))
        
        if envelop.data.currentPage == 0 {
            persistFirstPageOfPlaces(envelop.data.items)
        }
        
        return envelop.data
    }
    
    /// On a background context
    private func persistFirstPageOfPlaces(_ places: [Places.Place]) {
        let bgMoc = CoreDataStack.default.newBackgroundContext()
        
        do {
            // batch delete existing first
            try bgMoc.batchDeleteAndMergeChanges(fetchRequest: CDPlace.fetchRequest())
            
            // create new batch
            _ = places.map { CDPlace(context: bgMoc, domain: $0) }
            
            // save
            try bgMoc.saveIfNeeded()
        } catch {
            print(error)
        }
    }
    
}
