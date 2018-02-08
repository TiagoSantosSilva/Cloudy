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
        guard let weekViewViewModel = weekViewViewModel else { return 0 }
        return weekViewViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weekViewViewModel = weekViewViewModel else { return 0 }
        return weekViewViewModel.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = weekWeatherTableView.dequeueReusableCell(withIdentifier: WeekWeatherCell.reuseIdentifier, for: indexPath) as? WeekWeatherCell else {
            return UITableViewCell()
        }
        
        guard let weekViewViewModel = weekViewViewModel else { return cell }
        
        cell.dayLabel.text = weekViewViewModel.day(for: indexPath.row)
        cell.dateLabel.text = weekViewViewModel.date(for: indexPath.row)
        cell.iconImageView.image = weekViewViewModel.image(for: indexPath.row)
        cell.windSpeedLabel.text = weekViewViewModel.windSpeed(for: indexPath.row)
        cell.temperatureLabel.text = weekViewViewModel.temperature(for: indexPath.row)
        
        return cell
    }
}
