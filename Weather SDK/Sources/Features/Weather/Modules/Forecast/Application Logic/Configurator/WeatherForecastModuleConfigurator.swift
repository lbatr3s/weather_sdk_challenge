//
//  WeatherForecastModuleConfigurator.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import UIKit

final class WeatherForecastModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(_ viewInput: UIViewController) {
        if let viewController = viewInput as? WeatherForecastViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: WeatherForecastViewController) {

        let presenter = WeatherForecastPresenter()
        presenter.view = viewController

        let interactor = WeatherForecastInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
