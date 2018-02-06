//
//  LocationsViewController.swift
//  Cloudy
//
//  Created by Tiago Santos on 05/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import CoreLocation

// TODO: - 
protocol LocationsViewControllerDelegate {
    func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation)
}

class LocationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -
    
    var currentLocation: CLLocation?
    
    var favorites = UserDefaults.loadLocations()
    
    // MARK: -
    
    private var hasFavorites: Bool {
        return favorites.count > 0
    }
    
    // MARK: - Delegate
    
    var delegate: LocationsViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setups
    
    func setupView() {
        registerLocationCell()
        setupDelegates()
        setupNavigationBar()
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonWasTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonWasTapped))
    }
    
    func registerLocationCell() {
        let cellNib = UINib(nibName: LocationCell.nibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: LocationCell.reuseIdentifier)
    }
    
    // MARK: - Selectors
    
    @objc func addButtonWasTapped() {
        print("Add button pressed.")
    }
    
    @objc func doneButtonWasTapped() {
        navigationController?.dismiss(animated: true, completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }
}

extension LocationsViewController: UITableViewDataSource {
    
    private enum Section: Int {
        
        case current
        case favorite
        
        // MARK: - Properties
        
        var title: String {
            switch self {
            case .current: return "Current Location"
            case .favorite: return "Favorite Locations"
            }
        }
        
        var numberOfRows: Int {
            switch self {
            case .current: return 1
            case .favorite: return 0
            }
        }
        
        static var count: Int {
            return Section.favorite.rawValue + 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected section")
        }
        
        switch section {
        case .current:
            return 1
        case .favorite:
            return max(favorites.count, 1)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected Section")
        }
        return section.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseIdentifier, for: indexPath) as? LocationCell else {
            fatalError("Unexpected Table View Cell")
        }
        
        var viewModel: LocationRepresentable?
        
        switch section {
        case .current:
            if let currentLocation = currentLocation {
                viewModel = LocationsViewModel(location: currentLocation)
            } else {
                cell.mainLabel.text = "Current Location Unkown"
            }
        case .favorite:
            if favorites.count > 0 {
                let favorite = favorites[indexPath.row]
                viewModel = LocationsViewModel(location: favorite.location, locationAsString: favorite.name)
            } else {
                cell.mainLabel.text = "No Favorites Found"
            }
        }
        
        if let viewModel = viewModel {
            cell.configure(withViewModel: viewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        switch section {
        case .current: return false
        case .favorite: return hasFavorites
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let location = favorites[indexPath.row]
        
        favorites.remove(at: indexPath.row)
        
        UserDefaults.removeLocation(location)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension LocationsViewController: UITableViewDelegate {
    
}
