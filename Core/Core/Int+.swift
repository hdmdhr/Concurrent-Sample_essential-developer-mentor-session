//
//  Int+.swift
//  Staging
//
//  Created by 胡洞明 on 2021-04-20.
//

import Foundation

public extension Int {
    
    func toStringWithLeadingZero(digits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        return formatter.string(from: self as NSNumber)!
    }
    
    var toDouble: Double { Double(self) }
    
    var toFloat: Float { Float(self) }
    
    var toString: String { String(self) }
    
}
