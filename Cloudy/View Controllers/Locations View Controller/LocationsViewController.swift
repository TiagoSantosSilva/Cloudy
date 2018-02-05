//
//  LocationsViewController.swift
//  Cloudy
//
//  Created by Tiago Santos on 05/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupDelegates()
        setupNavigationBar()
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    }
    
    @objc func addButtonPressed() {
        print("Add button pressed.")
    }
    
    @objc func doneButtonPressed() {
        print("Done button pressed.")
    }
}

extension LocationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: -
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: -
        return UITableViewCell()
    }
}
