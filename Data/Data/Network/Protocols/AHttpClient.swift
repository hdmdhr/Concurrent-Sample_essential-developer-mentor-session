//
//  AHttpClient.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-17.
//

import Foundation


protocol AHttpClient {
    
    func request<Response: Decodable>(url urlConvertible: UrlConvertible,
                                      method: HttpMethod,
                                      requireAuthorization: Bool,
                                      shouldRecover401UnauthorizedError: Bool) async throws -> Response
    
}

extension AHttpClient {
    
    /// A override which has some default parameters
    func request<Response: Decodable>(url urlConvertible: UrlConvertible,
                                      method: HttpMethod = .get(queryItemsProvider: nil),
                                      requireAuthorization: Bool = true,
                                      shouldRecover401UnauthorizedError: Bool = true) async throws -> Response
    {
        try await self.request(url: urlConvertible,
                               method: method,
                               requireAuthorization: requireAuthorization,
                               shouldRecover401UnauthorizedError: shouldRecover401UnauthorizedError)
    }
    
}
