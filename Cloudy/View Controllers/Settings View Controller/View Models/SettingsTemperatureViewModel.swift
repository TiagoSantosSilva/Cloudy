//
//  SettingsTemperatureViewModel.swift
//  Cloudy
//
//  Created by Tiago Santos on 08/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

struct SettingsTemperatureViewModel {
    
    // MARK: - Properties
    
    let temperatureNotation: TemperatureNotation
    
    // MARK: -
    
    var text: String {
        switch temperatureNotation {
        case .fahrenheit:
            return "Fahrenheit"
        case .celsius:
            return "Celsius"
        }
    }
    
    var accessoryType: UITableViewCellAccessoryType {
        guard UserDefaults.temperatureNotation() == temperatureNotation else { return .none }
        return .checkmark
    }
}

extension SettingsTemperatureViewModel: SettingsRepresentable {
    
}
