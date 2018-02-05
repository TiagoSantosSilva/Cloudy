//
//  RootViewControllerSettingsViewControllerDelegateExtension.swift
//  Cloudy
//
//  Created by Tiago Santos on 05/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

extension RootViewController: SettingsViewControllerDelegate {

    func controllerDidChangeTimeNotation(controller: SettingsViewController) {
        reloadDayViewData()
        reloadWeekViewData()
    }

    func controllerDidChangeUnitsNotation(controller: SettingsViewController) {
        reloadDayViewData()
        reloadWeekViewData()
    }

    func controllerDidChangeTemperatureNotation(controller: SettingsViewController) {
        reloadDayViewData()
        reloadWeekViewData()
    }

}

