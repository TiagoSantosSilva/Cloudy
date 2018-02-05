//
//  RootViewController.swift
//  Cloudy
//
//  Created by Tiago Santos on 04/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    @IBOutlet weak var dayActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var weekActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weekWeatherTableView: UITableView!
    
    // MARK: -
    
    var dayViewDelegate: DayViewDelegate?
    var weekViewDelegate: WeekViewDelegate?
    
    // MARK: -
    
    internal var currentLocation: CLLocation? {
        didSet {
            fetchWeatherData()
        }
    }
    
    private lazy var dataManager = {
        return DataManager(baseURL: API.AuthenticatedBaseURL)
    }()
    
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.distanceFilter = 1000.0
        locationManager.desiredAccuracy = 1000.0
        
        return locationManager
    }()
    
    // MARK: -
    
    var now: WeatherData? {
        didSet {
            updateDayView()
        }
    }
    
    var week: [WeatherDayData]? {
        didSet {
            updateWeekView()
        }
    }
    
    // MARK: -
    
    internal lazy var dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    internal lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        weekWeatherTableView.dataSource = self
        weekWeatherTableView.delegate = self
    }
    
    // MARK : - Setups
    
    func setupView() {
        setupActivityIndicators()
        registerWeekWeatherCell()
        setupNotificationHandling()
    }
    
    func setupActivityIndicators() {
        dayActivityIndicator.startAnimating()
        dayActivityIndicator.hidesWhenStopped = true
        
        weekActivityIndicator.startAnimating()
        weekActivityIndicator.hidesWhenStopped = true
    }
    
    func registerWeekWeatherCell() {
        let weekWeatherCellNib = UINib(nibName: WeekWeatherCell.nibIdentifier, bundle: nil)
        weekWeatherTableView.register(weekWeatherCellNib, forCellReuseIdentifier: WeekWeatherCell.reuseIdentifier)
    }
    
    // MARK: - Notification Handling
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    // MARK: - Helper Methods
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(RootViewController.applicationDidBecomeActive(notification:)), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    private func requestLocation() {
        // Configure Location Manager
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // Request Current Location
            locationManager.requestLocation()
            
        } else {
            // Request Authorization
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    internal func fetchWeatherData() {
        guard let location = currentLocation else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        print("\(latitude), \(longitude)")
        
        dataManager.weatherDataForLocation(latitude: latitude, longitude: longitude) { (response, error) in
            if let error = error {
                print(error)
            } else if let response = response {
                // Configure Day View Controller
                self.now = response
                
                // Configure Week View Controller
                self.week = response.dailyData
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func imageForIcon(withName name: String) -> UIImage? {
        switch name {
        case "clear-day":
            return UIImage(named: "clear-day")
        case "clear-night":
            return UIImage(named: "clear-night")
        case "rain":
            return UIImage(named: "rain")
        case "snow":
            return UIImage(named: "snow")
        case "sleet":
            return UIImage(named: "sleet")
        case "wind", "cloudy", "partly-cloudy-day", "partly-cloudy-night":
            return UIImage(named: "cloudy")
        default:
            return UIImage(named: "clear-day")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapSettingsButton(sender: UIButton) {
        dayViewDelegate?.controllerDidTapSettingsButton(controller: self)
    }
    
    @IBAction func didTapLocationButton(sender: UIButton) {
        dayViewDelegate?.controllerDidTapLocationButton(controller: self)
    }
}
