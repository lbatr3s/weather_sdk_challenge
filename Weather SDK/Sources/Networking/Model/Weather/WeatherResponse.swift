//
//  WeatherResponse.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

struct WeatherResponse: Codable {
    
    let data: [WeatherData]
    
    init(data: [WeatherData]) {
        self.data = data
    }
}
