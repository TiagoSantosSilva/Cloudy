//
//  RootViewControllerDayViewExtension.swift
//  Cloudy
//
//  Created by Tiago Santos on 04/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

protocol DayViewDelegate {
    func controllerDidTapSettingsButton(controller: RootViewController)
    func controllerDidTapLocationButton(controller: RootViewController)
}

extension RootViewController {
    
    func reloadDayViewData() {
        updateDayView()
    }
    
    func updateDayView() {
        dayActivityIndicator.stopAnimating()
        
        if let now = now {
            updateDayWeatherDataContainer(withWeatherData: now)
            
        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."
        }
    }
    
    func updateDayWeatherDataContainer(withWeatherData weatherData: WeatherData) {
        var windSpeed = weatherData.windSpeed
        var temperature = weatherData.temperature
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM d"
        dateLabel.text = dateFormatter.string(from: weatherData.time)
        
        let timeFormatter = DateFormatter()
        
        if UserDefaults.timeNotation() == .twelveHour {
            timeFormatter.dateFormat = "hh:mm a"
        } else {
            timeFormatter.dateFormat = "HH:mm"
        }
        
        timeLabel.text = timeFormatter.string(from: weatherData.time)
        
        descriptionLabel.text = weatherData.summary
        
        if UserDefaults.temperatureNotation() != .fahrenheit {
            temperature = temperature.toCelcius()
            temperatureLabel.text = String(format: "%.1f °C", temperature)
        } else {
            temperatureLabel.text = String(format: "%.1f °F", temperature)
        }
        
        if UserDefaults.unitsNotation() != .imperial {
            windSpeed = windSpeed.toKPH()
            windSpeedLabel.text = String(format: "%.f KPH", windSpeed)
        } else {
            windSpeedLabel.text = String(format: "%.f MPH", windSpeed)
        }
        
        iconImageView.image = imageForIcon(withName: weatherData.icon)
    }
}
