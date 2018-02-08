//
//  WeekWeatherCell.swift
//  Cloudy
//
//  Created by Tiago Santos on 04/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class WeekWeatherCell: UITableViewCell {
    
    // MARK: - Identifiers
    
    static let reuseIdentifier = "WeekWeatherCell"
    static let nibIdentifier = "WeekWeatherCell"

    // MARK: - Outlets
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - Configuration
    func configure(withViewModel viewModel: WeatherDayRepresentable) {
        dayLabel.text = viewModel.day
        dateLabel.text = viewModel.date
        temperatureLabel.text = viewModel.temperature
        windSpeedLabel.text = viewModel.windSpeed
        iconImageView.image = viewModel.image
    }
}
