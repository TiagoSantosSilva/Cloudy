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
        let settingsController = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: settingsController)
        present(navigationController, animated: true)
    }
    
    func controllerDidTapLocationButton(controller: RootViewController) {
        // TODO: -
        // performSegue(withIdentifier: segueLocationsView, sender: self)
    }
    
}
