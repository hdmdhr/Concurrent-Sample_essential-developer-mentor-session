//
//  HttpClient.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-15.
//

import Foundation
import Domain

/// Different APIs should use different ``HttpClient`` to meet their own needs
class HttpClient: AHttpClient {
    
    typealias RefreshTokenAsyncClosure = (_ client: HttpClient, _ refreshToken: String) async -> AccessToken?
    
    /// Out of box client for Staging API, has refresh token method setup
    static let stagingClient = HttpClient(
        urlSession: .shared,
        config: HttpClientConfig(baseUrl: APIs.Staging.baseUrl!),
        jsonDecoder: .init(),
        refreshTokenMethod: { client, refreshToken in
            let requestBody = RefreshTokenRequest(refreshToken: refreshToken)
            
            guard let response: Envelop<RefreshTokenResponse> = try? await client.request(
                url: APIs.Staging.Account.refreshToken,
                method: .post(body: requestBody),
                requireAuthorization: false,
                shouldRecover401UnauthorizedError: false)
            else { return nil }
            
            let updated = AccessToken(token: response.data.accessToken,
                                      expiryDate: Date().addingTimeInterval(response.data.expires))
            client.config.accessToken = updated
            
            return updated
        })
    
    /// - parameters:
    ///   - refreshTokenMethod: Should also take care of updating the stored access token in config
    internal init(urlSession: URLSession,
                  config: HttpClientConfig,
                  jsonDecoder: JSONDecoder = .init(),
                  refreshTokenMethod: RefreshTokenAsyncClosure? = nil)
    {
        self.urlSession = urlSession
        self.config = config
        self.jsonDecoder = jsonDecoder
        self.refreshTokenMethod = refreshTokenMethod
    }
    
    
    let urlSession: URLSession
    let config: HttpClientConfig
    let jsonDecoder: JSONDecoder
    
    let refreshTokenMethod: RefreshTokenAsyncClosure?
    
    
    func request<Response: Decodable>(url urlConvertible: UrlConvertible,
                                      method: HttpMethod,
                                      requireAuthorization: Bool,
                                      shouldRecover401UnauthorizedError: Bool = true) async throws -> Response
    {
        var url = urlConvertible.url
        
        // query (optional)
        if case .get(let queryItemsProvider) = method, let provider = queryItemsProvider {
            do {
                let queryItems = try provider.queryItems()
                url.appendQueryItems(queryItems)
            } catch {
                // must be EncodingError
                throw NetworkError.invalidRequest(innerError: error)
            }
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.httpRawMethod.rawValue
        
        // headers
        config.headers.forEach { (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if requireAuthorization, let accessToken = config.accessToken, accessToken.isValid {
            urlRequest.setValue("Bearer " + accessToken.token, forHTTPHeaderField: "Authorization")
        }
        
        // body (optional)
        if case let .mutable(_, bodyDataProvider) = method, let provider = bodyDataProvider {
            do {
                urlRequest.httpBody = try provider.bodyData()
            } catch {
                // must be EncodingError
                throw NetworkError.invalidRequest(innerError: error)
            }
        }
        
        
        var httpUrlResponse: HTTPURLResponse?
        var data: Data = .init()
        
        do {
            let tuple = try await urlSession.data(for: urlRequest)
            httpUrlResponse = tuple.1 as? HTTPURLResponse
            data = tuple.0
            
            let response = try jsonDecoder.decode(Response.self, from: data)
            
            #if DEBUG
            let debugMessage = [
                urlRequest.httpMethod,
                urlRequest.url?.relativeString,
                httpUrlResponse?.statusCode.toString,
                data.prettyJsonString
            ]
                .compactMap { $0 }
                .joined(separator: "\n")
            
            print(debugMessage)
            #endif
            
            return response
        } catch let urlError as URLError {
            throw NetworkError.urlError(urlError)
        } catch let decodingError as DecodingError {
            guard shouldRecover401UnauthorizedError,
                  httpUrlResponse?.statusCode == 401,
                  let refreshToken = UserDefaults.standard.refreshToken,
                  let _ = await self.refreshTokenMethod?(self, refreshToken)
            else {
                throw NetworkError.decodingError(innerError: decodingError, data: data)
            }
            
            return try await request(url: urlConvertible,
                                     method: method,
                                     requireAuthorization: requireAuthorization,
                                     shouldRecover401UnauthorizedError: false)
        } catch {
            throw NetworkError.unknown(error)
        }
        
    }
        
    
}
