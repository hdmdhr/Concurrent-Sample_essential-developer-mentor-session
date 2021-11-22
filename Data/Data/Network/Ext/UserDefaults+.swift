//
//  UserDefaults+.swift
//  Data
//
//  Created by 胡洞明 on 2021-06-15.
//

import Foundation

public extension UserDefaults {
    
    enum Keys: String {
        case refreshToken
    }
    
    var refreshToken: String? {
        get {
            Self.standard.string(forKey: Keys.refreshToken.rawValue)
        }
        set {
            Self.standard.setValue(newValue, forKey: Keys.refreshToken.rawValue)
        }
    }
    
    
}
