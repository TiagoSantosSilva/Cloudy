//
//  SettingsRepresentable.swift
//  Cloudy
//
//  Created by Tiago Santos on 08/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    
    var text: String { get }
    var accessoryType: UITableViewCellAccessoryType { get }
}
