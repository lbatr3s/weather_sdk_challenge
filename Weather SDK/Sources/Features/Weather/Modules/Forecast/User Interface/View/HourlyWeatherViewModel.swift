//
//  HourlyWeatherViewModel.swift
//  Weather SDK
//
//  Created by Lester Batres on 22/10/24.
//

import UIKit

struct HourlyWeatherViewModel {
    
    let time: String
    let temperature: String
    let description: String
    
    var attributedHourlyWeather: NSAttributedString {
        var attributedString = AttributedString()
        
        attributedString.append(time.attributed(font: .textRegular, textColor: .textPrimary))
        attributedString.append("  \(temperature)  ".attributed(font: .textTitle, textColor: .textPrimary))
        attributedString.append(description.attributed(font: .textRegular, textColor: .textPrimary))
        
        return NSAttributedString(attributedString)
    }
}
