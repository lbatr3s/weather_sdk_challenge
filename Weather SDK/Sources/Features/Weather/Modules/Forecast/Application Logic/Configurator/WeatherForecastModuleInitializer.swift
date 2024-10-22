//
//  WeatherForecastModuleInitializer.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation

final class WeatherForecastModuleInitializer: NSObject {
    
    @IBOutlet weak var weatherForecastViewController: WeatherForecastViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let configurator = WeatherForecastModuleConfigurator()
        configurator.configureModuleForViewInput(weatherForecastViewController)
    }
}
