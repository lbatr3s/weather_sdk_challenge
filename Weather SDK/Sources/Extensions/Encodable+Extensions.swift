//
//  Encodable+Extensions.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

extension Encodable {
    
    var json: JSON? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? JSON }
    }
    
    var jsonString: String? {
        let jsonEncoder = JSONEncoder()
        
        jsonEncoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try jsonEncoder.encode(self)
            
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
