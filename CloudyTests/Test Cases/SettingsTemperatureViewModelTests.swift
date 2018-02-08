//
//  SettingsTemperatureViewModelTests.swift
//  CloudyTests
//
//  Created by Tiago Santos on 08/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsTemperatureViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
    }
    
    // MARK: - Tests for Text
    
    func testText_Fahrenheit() {
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .fahrenheit)
        
        XCTAssertEqual(viewModel.text, "Fahrenheit")
    }
    
    func testText_Celsius() {
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .celsius)
        
        XCTAssertEqual(viewModel.text, "Celsius")
    }
    
    // MARK: - Tests for Accessory Type
    
    func testAccessoryType_Fahrenheit_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .fahrenheit)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
    
    func testAccessoryType_Fahrenheit_Celsius() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .celsius)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_Celsius_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .fahrenheit)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_Celsius_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .celsius)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
}
