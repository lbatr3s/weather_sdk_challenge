//
//  HourlyWeatherTableViewCell.swift
//  Weather SDK
//
//  Created by Lester Batres on 22/10/24.
//

import UIKit

class HourlyWeatherTableViewCell: UITableViewCell {
    
    static let identifier = "HourlyWeatherTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        selectionStyle = .none
    }
    
    func configure(viewModel: HourlyWeatherViewModel) {
        titleLabel.attributedText = viewModel.attributedHourlyWeather
    }
}
