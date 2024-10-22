//
//  CurrentWeatherRequest.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

struct CurrentWeatherRequest: Codable {
    
    let city: String
    let key: String
    
    init(city: String, key: String) {
        self.city = city
        self.key = key
    }
}
