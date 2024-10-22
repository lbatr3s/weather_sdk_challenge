//
//  HourlyWeatherRequest.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

struct HourlyWeatherRequest: Codable {
    
    let city: String
    let hours: Int
    let key: String
    
    init(city: String, hours: Int = 24, key: String) {
        self.city = city
        self.hours = hours
        self.key = key
    }
}
