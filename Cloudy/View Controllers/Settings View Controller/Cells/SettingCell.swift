//
//  SettingCell.swift
//  Cloudy
//
//  Created by Tiago Santos on 05/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    // MARK: - Type Properties
    
    static let reuseIdentifier = "SettingCell"
    static let nibName = "SettingCell"
    
    // MARK: - Properties
    
    @IBOutlet weak var mainLabel: UILabel!
    
    // MARK: - Configuration
    
    func configure(withViewModel viewModel: SettingsRepresentable) {
        mainLabel.text = viewModel.text
        accessoryType = viewModel.accessoryType
    }
}
