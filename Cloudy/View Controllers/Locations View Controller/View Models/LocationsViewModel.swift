//
//  LocationsViewModel.swift
//  Cloudy
//
//  Created by Tiago Santos on 06/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationsViewModel {
    
    // MARK: - Properties
    
    let location: CLLocation?
    let locationAsString: String?
    
    // MARK: - Initialization
    
    init(location: CLLocation? = nil, locationAsString: String? = nil) {
        self.location = location
        self.locationAsString = locationAsString
    }
}

extension LocationsViewModel: LocationRepresentable {
    
    var text: String {
        if let locationAsString = locationAsString {
            return locationAsString
        } else if let location = location {
            return location.asString
        }
        
        return "Unkown Location"
    }
}

extension CLLocation {
    
    var asString: String {
        let latitude = String(format: "%.3f", coordinate.latitude)
        let longitude = String(format: "%.3f", coordinate.longitude)
        return "\(latitude), \(longitude)"
    }
}
