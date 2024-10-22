//
//  UIColor+Extensions.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import UIKit

extension UIColor {
    
    var accent: UIColor { .loadColor(named: "accent") }
    var accentHighlighted: UIColor { .loadColor(named: "accentHighlighted") }
    var textPrimary: UIColor { .loadColor(named: "textPrimary") }
    var textSecondary: UIColor { .loadColor(named: "textSecondary") }
    var textplaceholder: UIColor { .loadColor(named: "textplaceholder") }
    var textBorder: UIColor { .loadColor(named: "textBorder") }
    
    
    private static func loadColor(named: String) -> UIColor {
        let bundle = Bundle(identifier: "com.home.Weather-SDK")
        
        guard let color = UIColor(named: named, in: bundle, compatibleWith: nil) else { abort() }
        
        return color
    }
}
