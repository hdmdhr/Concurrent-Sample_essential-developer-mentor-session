//
//  CaseIterable+Next.swift
//  Staging
//
//  Created by 胡洞明 on 2021-04-20.
//

import Foundation

extension CaseIterable where Self: Equatable {
    
    var index: Self.AllCases.Index { Self.allCases.firstIndex(of: self)! }
    
    var next: Self? {
        let all = Self.allCases
        let idx = index
        guard idx < all.index(all.endIndex, offsetBy: -1) else { return nil }
        return all[all.index(after: idx)]
    }
    
    var prev: Self? {
        let all = Self.allCases
        let idx = index
        guard idx > all.startIndex else { return nil }
        return all[all.index(idx, offsetBy: -1)]
    }
    
    /// Is there is no next, return first
    func nextOne() -> Self {
        next ?? first
    }
    
    /// Is there is no previous, return last
    func prevOne() -> Self {
        prev ?? last
    }
    
    var first: Self {
        let all = Self.allCases
        return all.first!
    }
    
    var last: Self {
        let all = Self.allCases
        return all[all.index(all.endIndex, offsetBy: -1)]
    }
    
    var isFirst: Bool { self == first }
    
    var isLast: Bool { self == last }
    
}
