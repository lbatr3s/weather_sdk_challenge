//
//  WeatherSDK.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import UIKit

/// Use the delegate to listen for SDK update
public protocol WeatherSDKDelegate: AnyObject {
    
    /// This method is called when user taps on back button.
    /// - Parameters:
    ///   - controller: The ViewController to be dismissed.
    func onFinished(controller: WeatherForecastViewController)
    
    /// This method is called when a failure ocurrs in the SDK.
    /// - Parameters:
    ///   - error: The error ocurred in the SDK
    ///   - controller: The ViewController to be dismissed.
    func onFinishedWithError(_ error: String, controller: WeatherForecastViewController)
}

public struct WeatherSDK {
    
    private let storyboardName = "Weather"
    private let storyboard: UIStoryboard
    private let bundle: Bundle?
    
    public init() {
        bundle = Bundle(for: WeatherForecastViewController.self)
        storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
    }
    
    ///  Use this method to retrieve the Weather Forecast of a given City.
    ///
    ///  - Parameters:
    ///     - viewController: The viewController that will present forecast results
    ///     - cityName: The City to retrieve the forecast
    ///     - delegate: The delegate to listen for SDK updates.
    public func showForecastController(viewController: UIViewController, cityName: String, delegate: WeatherSDKDelegate? = nil) {
        let weatherForecastController = storyboard.instantiateViewController(withIdentifier: WeatherForecastViewController.identifier) as! WeatherForecastViewController
        
        weatherForecastController.moduleInput().initializeModule(cityName: cityName, delegate: delegate)
        
        let navigationController = UINavigationController(rootViewController: weatherForecastController)
        
        navigationController.modalPresentationStyle = .fullScreen
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
