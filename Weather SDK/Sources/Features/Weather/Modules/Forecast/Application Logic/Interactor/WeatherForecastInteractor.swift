//
//  WeatherForecastInteractor.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Combine

protocol WeatherForecastInteractorInput {
    
    func retrieveCurrentWeather(city: String)
    func retrieveHourlyWeather(city: String)
}

protocol WeatherForecastInteractorOutput: AnyObject {
    
    func didRetrieveCurrentWeatherData(_ data: WeatherData)
    func didRetrieveHourlyWeatherData(_ data: [WeatherData])
    func didFailRetrievingCurrentWeatherData(message: String)
}

class WeatherForecastInteractor: WeatherForecastInteractorInput {
    
    private var cancellables: Set<AnyCancellable> = []
    private let client = WeatherClient(configuration: NetworkingService().configuration)
    
    weak var output: WeatherForecastInteractorOutput!
    
    func retrieveCurrentWeather(city: String) {
        let request = CurrentWeatherRequest(city: city, key: NetworkingService.sessionId)
        
        client.current(request: request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let networkingError as NetworkingError):
                    switch networkingError {
                    case .apiError(_, let apiError as ErrorModel):
                        self?.output.didFailRetrievingCurrentWeatherData(message: apiError.error)
                    default:
                        self?.output.didFailRetrievingCurrentWeatherData(message: networkingError.localizedDescription)
                    }
                default:
                    break
                }
            } receiveValue: { [weak self] response in
                if let weatherData = response.data.first {
                    self?.output.didRetrieveCurrentWeatherData(weatherData)
                } else {
                    self?.output.didFailRetrievingCurrentWeatherData(message: "No data found")
                }
            }.store(in: &cancellables)
    }
    
    func retrieveHourlyWeather(city: String) {
        let request = HourlyWeatherRequest(city: city, key: NetworkingService.sessionId)
        
        client.hourly(request: request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let networkingError as NetworkingError):
                    switch networkingError {
                    case .apiError(_, let apiError as ErrorModel):
                        self?.output.didFailRetrievingCurrentWeatherData(message: apiError.error)
                    default:
                        self?.output.didFailRetrievingCurrentWeatherData(message: networkingError.localizedDescription)
                    }
                default:
                    break
                }
            } receiveValue: { [weak self] response in
                if !response.data.isEmpty {
                    self?.output.didRetrieveHourlyWeatherData(response.data)
                } else {
                    self?.output.didFailRetrievingCurrentWeatherData(message: "No data found")
                }
            }.store(in: &cancellables)

    }
}
