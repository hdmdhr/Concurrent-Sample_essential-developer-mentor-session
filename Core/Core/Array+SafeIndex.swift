//
//  Array+SafeIndex.swift
//  Staging
//
//  Created by 胡洞明 on 2021-11-01.
//

import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
    
}
