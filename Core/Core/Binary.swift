//
//  Binary.swift
//  Core
//
//  Created by 胡洞明 on 2021-11-15.
//

import Foundation

// MARK: - Binary

public enum Binary<A, B> {
    case a(A)
    case b(B)
}


extension Binary: Equatable where A: Equatable, B: Equatable { }

extension Binary {
    
    var a: A? {
        guard case .a(let caseA) = self else { return nil }
        
        return caseA
    }
    
    var b: B? {
        guard case .b(let caseB) = self else { return nil }
        
        return caseB
    }
    
}


// MARK: - Ternary

public enum Ternary<A, B, C> {
    case a(A)
    case b(B)
    case c(C)
}

extension Ternary: Equatable where A: Equatable, B: Equatable, C: Equatable { }

extension Ternary {
    
    var a: A? {
        guard case .a(let caseA) = self else { return nil }
        
        return caseA
    }
    
    var b: B? {
        guard case .b(let caseB) = self else { return nil }
        
        return caseB
    }
    
    var c: C? {
        guard case .c(let caseC) = self else { return nil }
        
        return caseC
    }
}
