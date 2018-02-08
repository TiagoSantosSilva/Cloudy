//
//  SettingsTimeViewModel.swift
//  Cloudy
//
//  Created by Tiago Santos on 08/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

struct SettingsTimeViewModel {
    
    // MARK: - Properties
    
    let timeNotation: TimeNotation
    
    // MARK: -
    
    var text: String {
        switch timeNotation {
        case .twelveHour:
            return "12 Hour"
        case .twentyFourHour:
            return "24 Hour"
        }
    }
    
    var accessoryType: UITableViewCellAccessoryType {
        guard UserDefaults.timeNotation() == timeNotation else { return .none }
        return .checkmark
    }
}

extension SettingsTimeViewModel: SettingsRepresentable {
    
}
