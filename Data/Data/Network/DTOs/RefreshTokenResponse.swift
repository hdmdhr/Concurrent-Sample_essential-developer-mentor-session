//
//  RefreshTokenResponse.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-18.
//

import Foundation

struct RefreshTokenResponse: Decodable {
    
    let accessToken, refreshToken: String
    let expires: TimeInterval
    
}
