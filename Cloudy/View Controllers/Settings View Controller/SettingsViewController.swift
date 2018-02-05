//
//  SettingsViewController.swift
//  Cloudy
//
//  Created by Tiago Santos on 05/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func controllerDidChangeTimeNotation(controller: SettingsViewController)
    func controllerDidChangeUnitsNotation(controller: SettingsViewController)
    func controllerDidChangeTemperatureNotation(controller: SettingsViewController)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    func setupView() {
        setupNavigationBar()
        registerSettingCell()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
    }
    
    @objc func doneButtonPressed() {
        print("Done button pressed.")
    }
    
    func registerSettingCell() {
        let cellNib = UINib(nibName: SettingCell.nibName, bundle: nil)
        settingsTableView.register(cellNib, forCellReuseIdentifier: SettingCell.reuseIdentifier)
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    private enum Section: Int {
        case time
        case units
        case temperature
        
        var numberOfRows: Int {
            return 2
        }
        
        static var count: Int {
            return (Section.temperature.rawValue + 1)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected section")
        }
        return section.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section")
        }
        
        guard let cell = settingsTableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as? SettingCell else {
            fatalError("Unexpected Table View Cell")
        }
        
        switch section {
        case .time:
            cell.mainLabel.text = (indexPath.row == 0) ? "12 Hour" : "24 Hour"
            
            let timeNotation = UserDefaults.timeNotation()
            
            if indexPath.row == timeNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .units:
            cell.mainLabel.text = (indexPath.row == 0) ? "Imperial" : "Metric"
            
            let unitNotation = UserDefaults.unitsNotation()
            
            if indexPath.row == unitNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .temperature:
            cell.mainLabel.text = (indexPath.row == 0) ? "Fahrenheit" : "Celcius"
            
            let temperatureNotation = UserDefaults.temperatureNotation()
            
            if indexPath.row == temperatureNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        switch section {
        case .time:
            break
        case .units:
            break
        case .temperature:
            break
        }
    }
}
