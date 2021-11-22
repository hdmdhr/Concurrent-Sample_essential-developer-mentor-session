//
//  Data+PrettyString.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-15.
//

import Foundation

extension Data {
    
    var prettyJsonString: String? {
        guard let jsonObj = try? JSONSerialization.jsonObject(with: self, options: []),
              let prettyData = try? JSONSerialization.data(withJSONObject: jsonObj, options: [.prettyPrinted]),
              let jsonString = String(data: prettyData, encoding: .utf8)
        else { return nil }
        
        return jsonString
    }
    
}
