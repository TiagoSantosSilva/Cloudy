//
//  SettingsUnitsViewModelTests.swift
//  CloudyTests
//
//  Created by Tiago Santos on 08/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsUnitsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
    }
    
    // MARK: - Tests for Text
    
    func testText_Imperial() {
        let viewModel = SettingsUnitsViewModel(unitsNotation: .imperial)
        
        XCTAssertEqual(viewModel.text, "Imperial")
    }
    
    func testText_Metric() {
        let viewModel = SettingsUnitsViewModel(unitsNotation: .metric)
        
        XCTAssertEqual(viewModel.text, "Metric")
    }
    
    // MARK: - Tests for Accessory Type
    
    func testAccessoryType_Imperial_Imperial() {
        let unitNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        
        let viewModel = SettingsUnitsViewModel(unitsNotation: .imperial)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
    
    func testAccessoryType_Imperial_Metric() {
        let unitNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        
        let viewModel = SettingsUnitsViewModel(unitsNotation: .metric)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_Metric_Imperial() {
        let unitNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        
        let viewModel = SettingsUnitsViewModel(unitsNotation: .imperial)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.none)
    }
    
    func testAccessoryType_Metric_Metric() {
        let unitNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        
        let viewModel = SettingsUnitsViewModel(unitsNotation: .metric)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCellAccessoryType.checkmark)
    }
}
