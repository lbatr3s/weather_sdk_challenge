//
//  WeatherClient.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Combine

protocol WeatherClientProvider {
    
    func current(request: CurrentWeatherRequest) -> AnyPublisher<WeatherResponse, Error>
    func hourly(request: HourlyWeatherRequest) -> AnyPublisher<WeatherResponse, Error>
}

final class WeatherClient: RestClient, WeatherClientProvider {
    
    func current(request: CurrentWeatherRequest) -> AnyPublisher<WeatherResponse, Error> {
        self.request(resource: WeatherResource.current, parameters: request.json, type: WeatherResponse.self, errorType: ErrorModel.self)
    }
    
    func hourly(request: HourlyWeatherRequest) -> AnyPublisher<WeatherResponse, Error> {
        self.request(resource: WeatherResource.hourly, parameters: request.json, type: WeatherResponse.self, errorType: ErrorModel.self)
    }
}
