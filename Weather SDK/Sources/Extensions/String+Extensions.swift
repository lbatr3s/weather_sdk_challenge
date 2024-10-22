//
//  String+Extensions.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Foundation
import UIKit

extension String {
    
    private static let measurementFormatter: MeasurementFormatter = MeasurementFormatter()
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        return dateFormatter
    }()
    
    static func temperatureFormatted(value: Double, unit: UnitTemperature = .celsius) -> String {
        let temperature = Measurement(value: value, unit: unit)
        
        return measurementFormatter.string(from: temperature)
    }
    
    static func utcToLocalTime(_ timestamp: TimeInterval, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        dateFormatter.dateFormat = "H:mm"
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        
        return dateFormatter.string(from: date)
    }
    
    func formattedTime() -> String? {
        String.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = String.dateFormatter.date(from: self) else { return nil }
        
        String.dateFormatter.dateFormat = "H:mm"
        return String.dateFormatter.string(from: date)
    }
    
    func attributed(font: UIFont, textColor: UIColor) -> AttributedString {
        let textAttributes = AttributeContainer([NSAttributedString.Key.font: font,
                                                 NSAttributedString.Key.foregroundColor: textColor])
        
        let attributedString = AttributedString(self, attributes: textAttributes)
        
        return attributedString
    }
}
