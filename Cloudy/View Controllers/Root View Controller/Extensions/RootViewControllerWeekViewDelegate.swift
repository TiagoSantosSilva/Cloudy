//
//  RootViewControllerWeekViewDelegate.swift
//  Cloudy
//
//  Created by Tiago Santos on 05/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

extension RootViewController: WeekViewDelegate {
    
    func controllerDidRefresh(controller: RootViewController) {
        fetchWeatherData()
    }
    
}
