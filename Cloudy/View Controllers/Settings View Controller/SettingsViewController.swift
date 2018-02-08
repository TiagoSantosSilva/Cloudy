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
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    func setupView() {
        setupNavigationBar()
        registerSettingCell()
        setupTableView()
    }
    
    func setupNavigationBar() {
        title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonWasTapped))
    }
    
    @objc func doneButtonWasTapped() {
        navigationController?.dismiss(animated: true, completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func registerSettingCell() {
        let cellNib = UINib(nibName: SettingCell.nibName, bundle: nil)
        settingsTableView.register(cellNib, forCellReuseIdentifier: SettingCell.reuseIdentifier)
    }
    
    func setupTableView() {
        settingsTableView.separatorInset = UIEdgeInsets.zero
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
        
        var viewModel: SettingsRepresentable?
        
        switch section {
        case .time:
            guard let timeNotation = TimeNotation(rawValue: indexPath.row) else {
                fatalError("Unexpected Index Path")
            }
            viewModel = SettingsTimeViewModel(timeNotation: timeNotation)
            
        case .units:
            guard let unitsNotation = UnitsNotation(rawValue: indexPath.row) else {
                fatalError("Unexpected Index Path")
            }
            viewModel = SettingsUnitsViewModel(unitsNotation: unitsNotation)
            
        case .temperature:
            guard let temperatureNotation = TemperatureNotation(rawValue: indexPath.row) else {
                fatalError("Unexpected Index Path")
            }
            viewModel = SettingsTemperatureViewModel(temperatureNotation: temperatureNotation)
        }
        
        guard viewModel != nil else { return cell }
        
        cell.mainLabel.text = viewModel!.text
        cell.accessoryType = viewModel!.accessoryType
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        switch section {
        case .time:
            let timeNotation = UserDefaults.timeNotation()
            guard indexPath.row != timeNotation.rawValue else { return }
            
            if let newTimeNotation = TimeNotation(rawValue: indexPath.row) {
                UserDefaults.setTimeNotation(timeNotation: newTimeNotation)
                delegate?.controllerDidChangeTimeNotation(controller: self)
            }
        case .units:
            let unitsNotation = UserDefaults.unitsNotation()
            guard indexPath.row != unitsNotation.rawValue else { return }
            
            if let newUnitNotation = UnitsNotation(rawValue: indexPath.row) {
                UserDefaults.setUnitsNotation(unitsNotation: newUnitNotation)
                delegate?.controllerDidChangeUnitsNotation(controller: self)
            }
        case .temperature:
            let temperatureNotation = UserDefaults.temperatureNotation()
            guard indexPath.row != temperatureNotation.rawValue else { return }
            
            if let newTemperatureNotation = TemperatureNotation(rawValue: indexPath.row) {
                UserDefaults.setTemperatureNotation(temperatureNotation: newTemperatureNotation)
                delegate?.controllerDidChangeTemperatureNotation(controller: self)
            }
        }
        
        settingsTableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
}
