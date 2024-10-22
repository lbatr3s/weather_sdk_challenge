//
//  Weather.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

struct Weather: Codable {
    
    let description: String
    
    init(description: String) {
        self.description = description
    }
}
