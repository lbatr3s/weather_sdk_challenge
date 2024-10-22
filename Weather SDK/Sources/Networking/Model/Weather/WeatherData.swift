//
//  WeatherData.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

struct WeatherData: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case cityName = "city_name"
        case temperature = "temp"
        case weather
        case utcTimestamp = "ts"
        case localTimestamp = "timestamp_local"
        case timezone
        
    }
    
    let cityName: String?
    let temperature: Double
    let weather: Weather
    let utcTimestamp: TimeInterval
    let localTimestamp: String?
    let timezone: String?
    
    init(cityName: String? = nil, temperature: Double, weather: Weather, utcTimestamp: TimeInterval, localTimestamp: String?, timezone: String? = nil) {
        self.cityName = cityName
        self.temperature = temperature
        self.weather = weather
        self.utcTimestamp = utcTimestamp
        self.localTimestamp = localTimestamp
        self.timezone = timezone
    }
}
