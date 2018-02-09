//
//  AddLocationViewModelTests.swift
//  CloudyTests
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import Cloudy

class AddLocationViewModelTests: XCTestCase {
    
    private class MockLocationService: LocationService {
        func geocode(addressString: String?, completionHandler: @escaping LocationService.LocationServiceCompletionHandler) {
            if let addressString = addressString, !addressString.isEmpty {
                // Create Location
                let location = Location(name: "Porto", latitude: 41.1496, longitude: -8.6109)
                
                // Invoke Completion Handler
                completionHandler([location], nil)
            } else {
                // Invoke Completion Handler
                completionHandler([], nil)
            }
        }
    }
    
    // MARK: - Properties
    
    var viewModel: AddLocationViewModel!
    
    // MARK: -
    
    var scheduler: SchedulerType!
    
    // MARK: -
    
    var query: BehaviorRelay<String>!
    
    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        
        // Initialize Query
        query = BehaviorRelay<String>(value: "")
        
        // Initialize Location Service
        let locationService = MockLocationService()
        
        // Initialize View Model
        viewModel = AddLocationViewModel(query: query.asDriver(), locationService: locationService)
        
        // Initialize Scheduler
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Tests for Locations
    
    func testLocations_HasLocations() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Set Query
        query.accept("Por")
        
        // Fetch Result (Synchronous)
        let result = try! observable.skip(1).toBlocking().first()!
        
        // Asserts
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 1)
        
        // Fetch Location
        let location = result.first!
        
        XCTAssertEqual(location.name, "Porto")
    }
    
    func testLocations_NoLocations() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Fetch Result
        let result: [Location] = try! observable.toBlocking().first()!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 0)
    }
    
    // MARK: - Tests for Location At Index
    
    func testLocationAtIndex_NonNil() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Set Query
        query.accept("Por")
        
        // Fetch Result
        let _ = try! observable.skip(1).toBlocking().first()!
        
        // Fetch Location
        let result = viewModel.location(at: 0)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.name, "Porto")
    }
    
    func testLocationAtIndex_Nil() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Set Query
        query.accept("Por")
        
        // Fetch Result
        let _ = try! observable.skip(1).toBlocking().first()!
        
        // Fetch Location
        let result = viewModel.location(at: 1)
        
        XCTAssertNil(result)
    }
}














