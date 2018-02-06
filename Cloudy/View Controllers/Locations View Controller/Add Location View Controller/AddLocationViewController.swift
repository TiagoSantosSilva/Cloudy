//
//  AddLocationViewController.swift
//  Cloudy
//
//  Created by Tiago Santos on 06/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import CoreLocation

protocol AddLocationViewControllerDelegate {
    func controller(_ controller: AddLocationViewController, didAddLocation location: Location)
}

class AddLocationViewController: UIViewController {

    // MARK: - View Components
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: -
    
    private var locations: [Location] = []
    
    // MARK: -
    
    private lazy var geocoder = CLGeocoder()
    
    // MARK: - Delegates
    
    var delegate: AddLocationViewControllerDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setups
    func setupView() {
        title = "Add Location"
        registerLocationCell()
        setupDelegates()
        setupSearchBar()
    }
    
    func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    func registerLocationCell() {
        let cellNib = UINib(nibName: LocationCell.nibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: LocationCell.reuseIdentifier)
    }
    
    // TODO: - Setup the search bar.
    func setupSearchBar() {
        
        searchBar.becomeFirstResponder()
    }
    
    // TODO: - Setup 'Back' and 'Done' buttons.
    func setupNavigationButtons() {
        
    }
    
    // MARK: - Helper methods
    private func geocode(addressString: String?) {
        guard let addressString = addressString else {
            locations = []
            tableView.reloadData()
            return
        }
        
        // Geocode City
        geocoder.geocodeAddressString(addressString) { [weak self] (placemarks, error) in
            DispatchQueue.main.async {
                self?.processResponse(withPlacemarks: placemarks, error: error)
            }
        }
    }
    
    // MARK: -
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            
        } else if let matches = placemarks {
            // Update Locations
            locations = matches.flatMap({ (match) -> Location? in
                guard let name = match.name else { return nil }
                guard let location = match.location else { return nil }
                return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            })
            
            // Update Table View
            tableView.reloadData()
        }
    }
}

extension AddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseIdentifier, for: indexPath) as? LocationCell else {
            fatalError("Unexpected Table View Cell")
        }
        
        let location = locations[indexPath.row]
        let viewModel = LocationsViewModel(location: location.location, locationAsString: location.name)
        cell.configure(withViewModel: viewModel)
        return cell
    }
}

extension AddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        
        // Notify Delegate
        delegate?.controller(self, didAddLocation: location)
        
        // Pop View Controller From Navigation Stack
        navigationController?.popViewController(animated: true)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()
        
        // Forward Geocode Address String
        geocode(addressString: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()
        
        // Clear Locations
        locations = []
        
        tableView.reloadData()
    }
}
