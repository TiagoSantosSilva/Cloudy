//
//  LocationCell.swift
//  Cloudy
//
//  Created by Tiago Santos on 05/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    static let reuseIdentifier = "LocationCell"
    static let nibName = "LocationCell"
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withViewModel viewModel: LocationRepresentable) {
        mainLabel.text = viewModel.text
    }
}
