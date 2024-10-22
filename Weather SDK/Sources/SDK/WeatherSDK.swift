//
//  WeatherSDK.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import UIKit

public protocol WeatherSDKDelegate: AnyObject {
    
    func onFinished(controller: WeatherForecastViewController)
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
    
    public func showForecastController(viewController: UIViewController, cityName: String, delegate: WeatherSDKDelegate? = nil) {
        let weatherForecastController = storyboard.instantiateViewController(withIdentifier: WeatherForecastViewController.identifier) as! WeatherForecastViewController
        
        weatherForecastController.moduleInput().initializeModule(cityName: cityName, delegate: delegate)
        
        let navigationController = UINavigationController(rootViewController: weatherForecastController)
        
        navigationController.modalPresentationStyle = .fullScreen
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
