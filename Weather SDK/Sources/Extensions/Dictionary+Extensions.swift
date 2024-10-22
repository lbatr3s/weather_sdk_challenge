//
//  Dictionary+Extensions.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

extension Dictionary {
    
    var jsonString: String?  {
        guard let jsonData = jsonData else { return nil }
        
        return String(data: jsonData, encoding: .utf8)
    }
    
    var jsonData: Data? {
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        
        return data
    }
}
