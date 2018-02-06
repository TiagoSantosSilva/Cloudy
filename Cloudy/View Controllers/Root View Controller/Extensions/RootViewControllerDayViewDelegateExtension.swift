//
//  RootViewControllerDayViewDelegateExtension.swift
//  Cloudy
//
//  Created by Tiago Santos on 05/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension RootViewController: DayViewDelegate {
    
    func controllerDidTapSettingsButton(controller: RootViewController) {
        let settingsViewController = SettingsViewController()
        settingsViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        present(navigationController, animated: true)
    }
    
    func controllerDidTapLocationButton(controller: RootViewController) {
        let locationsViewController = LocationsViewController()
        locationsViewController.delegate = self
        locationsViewController.currentLocation = currentLocation
        let navigationController = UINavigationController(rootViewController: locationsViewController)
        present(navigationController, animated: true)
    }
}
