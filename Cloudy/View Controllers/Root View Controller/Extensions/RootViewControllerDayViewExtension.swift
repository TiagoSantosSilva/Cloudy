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
        
        if let dayViewViewModel = dayViewViewModel {
            updateDayWeatherDataContainer(withViewModel: dayViewViewModel)
            
        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."
        }
    }
    
    func updateDayWeatherDataContainer(withViewModel viewModel: DayViewViewModel) {
        turnDayContainerVisible()
        
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        iconImageView.image = viewModel.image
        windSpeedLabel.text = viewModel.windSpeed
        descriptionLabel.text = viewModel.summary
        temperatureLabel.text = viewModel.temperature
    }
    
    func turnDayContainerVisible() {
        dayView.isHidden = false
    }
}
