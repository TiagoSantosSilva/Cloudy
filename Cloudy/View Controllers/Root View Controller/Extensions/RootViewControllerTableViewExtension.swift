//
//  RootViewControllerTableViewExtension.swift
//  Cloudy
//
//  Created by Tiago Santos on 04/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return week == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let week = week else { return 0 }
        return week.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = weekWeatherTableView.dequeueReusableCell(withIdentifier: WeekWeatherCell.reuseIdentifier, for: indexPath) as? WeekWeatherCell else {
            return UITableViewCell()
        }
        
        if let week = week {
            // Fetch Weather Data
            let weatherData = week[indexPath.row]
            
            var windSpeed = weatherData.windSpeed
            var temperatureMin = weatherData.temperatureMin
            var temperatureMax = weatherData.temperatureMax
            
            if UserDefaults.temperatureNotation() != .fahrenheit {
                temperatureMin = temperatureMin.toCelcius()
                temperatureMax = temperatureMax.toCelcius()
            }
            
            // Configure Cell
            cell.dayLabel.text = dayFormatter.string(from: weatherData.time)
            cell.dateLabel.text = dateFormatter.string(from: weatherData.time)
            
            let min = String(format: "%.0f°", temperatureMin)
            let max = String(format: "%.0f°", temperatureMax)
            
            cell.temperatureLabel.text = "\(min) - \(max)"
            
            if UserDefaults.unitsNotation() != .imperial {
                windSpeed = windSpeed.toKPH()
                cell.windSpeedLabel.text = String(format: "%.f KPH", windSpeed)
            } else {
                cell.windSpeedLabel.text = String(format: "%.f MPH", windSpeed)
            }
            
            cell.iconImageView.image = imageForIcon(withName: weatherData.icon)
        }
        
        return cell
    }
}
