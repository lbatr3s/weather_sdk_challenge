//
//  ViewController.swift
//  Example App
//
//  Created by Lester Batres on 21/10/24.
//

import UIKit
import Weather_SDK

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .h2
            titleLabel.textColor = .textPrimary
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .left
            titleLabel.text = "Enter a city name for the \nweather forecast"
        }
    }
    
    @IBOutlet weak var textField: CustomTextField! {
        didSet {
            textField.attributedPlaceholder = NSMutableAttributedString("Search city".attributed(font: .label, textColor: .placeholderText))
            textField.autocorrectionType = .no
            textField.clearButtonMode = .whileEditing
        }
    }
    
    @IBOutlet weak var weatherForecastButton: UIButton! {
        didSet {
            weatherForecastButton.layer.cornerRadius = 56.0 / 2
            weatherForecastButton.backgroundColor = .accent
            weatherForecastButton.titleLabel?.font = .textTitle
            weatherForecastButton.setTitleColor(.white, for: .normal)
            weatherForecastButton.setTitle("Weather Forecast", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Example App"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func didTapWeatherForecastButton(_ sender: UIButton) {
        guard let cityName = textField.text, !cityName.isEmpty else { return }
        
        let sdk = WeatherSDK()
        sdk.showForecastController(viewController: self, cityName: cityName, delegate: self)
    }
}

// MARK: WeatherSDKDelegate methods

extension ViewController: WeatherSDKDelegate {
    
    func onFinished(controller: WeatherForecastViewController) {
        controller.dismiss(animated: true)
    }
    
    func onFinishedWithError(_ error: String, controller: WeatherForecastViewController) {
        controller.dismiss(animated: true) { [weak self] in
            self?.showAlert(message: error)
        }
    }
    
    private func showAlert(message: String) {
        let okAction = UIAlertAction(title: "Ok", style: .default)
        let alertController = UIAlertController(title: "Example App", message: message, preferredStyle: .alert)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}
