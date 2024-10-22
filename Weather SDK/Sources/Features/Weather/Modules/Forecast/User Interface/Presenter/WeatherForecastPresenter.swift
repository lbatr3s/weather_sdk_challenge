//
//  WeatherForecastPresenter.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

protocol WeatherForecastModuleInput: AnyObject {
    
    func initializeModule(cityName: String, delegate: WeatherSDKDelegate?)
}

final class WeatherForecastPresenter {
    
    weak var view: WeatherForecastViewInput!
    var interactor: WeatherForecastInteractorInput!
    
    private var cityName: String!
    private var delegate: WeatherSDKDelegate?
}

// MARK: WeatherForecastModuleInput methods

extension WeatherForecastPresenter: WeatherForecastModuleInput {
    
    func initializeModule(cityName: String, delegate: WeatherSDKDelegate?) {
        self.cityName = cityName
        self.delegate = delegate
    }
}

// MARK: WeatherForecastViewOutput methods

extension WeatherForecastPresenter: WeatherForecastViewOutput {
    
    func viewIsReady() {
        view.showLoading()
        interactor.retrieveCurrentWeather(city: cityName)
    }
    
    func didTapBackButton() {
        delegate?.onFinished(controller: view as! WeatherForecastViewController)
    }
}

// MARK: WeatherForecastInteractorOutput methods

extension WeatherForecastPresenter: WeatherForecastInteractorOutput {
    
    func didRetrieveCurrentWeatherData(_ data: WeatherData) {
        guard let timezone = data.timezone, let title = data.cityName ?? cityName  else { return }
        
        let viewModel = CurrentWeatherViewModel(title: "The weather in \(title) is:",
                                                temperature: String.temperatureFormatted(value: data.temperature),
                                                weatherDescription: data.weather.description,
                                                time: "AT \(String.utcToLocalTime(data.utcTimestamp, timezone: timezone)) LOCAL TIME")
        view.setupInitialState(viewModel: viewModel)
        
        interactor.retrieveHourlyWeather(city: cityName)
    }
    
    func didRetrieveHourlyWeatherData(_ data: [WeatherData]) {
        view.updateScreenWithHourlyData(data: data.compactMap({ weatherData in
            guard let time = weatherData.localTimestamp?.formattedTime() else { return nil }
            
            return HourlyWeatherViewModel(time: time,
                                          temperature: String.temperatureFormatted(value: weatherData.temperature),
                                          description: weatherData.weather.description)
        }))
        
        view.hideLoading()
    }
    
    func didFailRetrievingCurrentWeatherData(message: String) {
        view.hideLoading()
        delegate?.onFinishedWithError(message, controller: view as! WeatherForecastViewController)
    }
}
