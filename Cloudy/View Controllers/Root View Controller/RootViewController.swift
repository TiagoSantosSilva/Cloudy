//
//  RootViewController.swift
//  Cloudy
//
//  Created by Tiago Santos on 04/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weekWeatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerWeekWeatherCell()
        weekWeatherTableView.dataSource = self
        weekWeatherTableView.delegate = self
    }
    
    func registerWeekWeatherCell() {
        let weekWeatherCellNib = UINib(nibName: "WeekWeatherCell", bundle: nil)
        weekWeatherTableView.register(weekWeatherCellNib, forCellReuseIdentifier: "weekWeatherCell")
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weekWeatherCell = weekWeatherTableView.dequeueReusableCell(withIdentifier: "weekWeatherCell", for: indexPath) as? WeekWeatherCell else {
            return UITableViewCell()
        }
        return weekWeatherCell
    }
}
