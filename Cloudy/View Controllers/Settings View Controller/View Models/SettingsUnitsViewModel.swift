//
//  SettingsUnitsViewModel.swift
//  Cloudy
//
//  Created by Tiago Santos on 08/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

struct SettingsUnitsViewModel {
    
    // MARK: - Properties
    
    let unitsNotation: UnitsNotation
    
    // MARK: -
    
    var text: String {
        switch unitsNotation {
        case .imperial:
            return "Imperial"
        case .metric:
            return "Metric"
        }
    }
    
    var acessoryType: UITableViewCellAccessoryType {
        guard UserDefaults.unitsNotation() == unitsNotation else { return .none }
        return .checkmark
    }
}
