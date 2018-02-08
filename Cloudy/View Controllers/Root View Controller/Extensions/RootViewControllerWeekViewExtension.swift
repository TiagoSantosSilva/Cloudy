//
//  RootViewControllerWeekViewExtension.swift
//  Cloudy
//
//  Created by Tiago Santos on 04/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

protocol WeekViewDelegate {
    func controllerDidRefresh(controller: RootViewController)
}

extension RootViewController {
    func reloadWeekViewData() {
        updateWeekView()
    }
    
    internal func updateWeekView() {
        weekActivityIndicator.stopAnimating()
        weekWeatherTableView.refreshControl?.endRefreshing()
        
        guard weekViewViewModel != nil else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."
            return
        }
        
        updateWeatherDataContainer()
    }
    
    func turnWeekContainerVisible() {
        weekView.isHidden = false
    }
    
    internal func setupTableView() {
        weekWeatherTableView.separatorInset = UIEdgeInsets.zero
    }
    
    internal func setupRefreshControl() {
        // Initialize Refresh Control
        let refreshControl = UIRefreshControl()
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(didRefresh(sender:)), for: .valueChanged)
        
        // Update Table View)
        weekWeatherTableView.refreshControl = refreshControl
    }
    
    // MARK: -
    
    internal func updateWeatherDataContainer() {
        turnWeekContainerVisible()
        weekWeatherTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func didRefresh(sender: UIRefreshControl) {
        weekViewDelegate?.controllerDidRefresh(controller: self)
    }
}
