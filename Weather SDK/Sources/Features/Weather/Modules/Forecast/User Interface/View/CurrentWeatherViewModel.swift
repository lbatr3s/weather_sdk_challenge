//
//  CurrentWeatherViewModel.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import UIKit

struct CurrentWeatherViewModel {
    
    let title: String
    let temperature: String
    let weatherDescription: String
    let time: String
    
    init(title: String, temperature: String, weatherDescription: String, time: String) {
        self.title = title
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.time = time
    }
}
