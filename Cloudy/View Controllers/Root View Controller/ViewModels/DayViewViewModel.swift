//
//  DayViewViewModel.swift
//  Cloudy
//
//  Created by Tiago Santos on 07/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

struct DayViewViewModel {
    
    // MARK: - Properties
    
    let weatherData: WeatherData
    
    // MARK: -
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    // MARK: -
    
    var date: String {
        dateFormatter.dateFormat = "EEE, MMMM d"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String {
        dateFormatter.dateFormat = UserDefaults.timeNotation().timeFormat
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        let temperature = weatherData.temperature
        
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.1f ºF", temperature)
        default:
            return String(format: "%.1f ºC", temperature.toCelcius())
        }
    }
    
    var windSpeed: String {
        let windSpeed = weatherData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f MPH", windSpeed)
        case .metric:
            return String(format: "%.f KPH", windSpeed.toKPH())
        }
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName: weatherData.icon)
    }
}
