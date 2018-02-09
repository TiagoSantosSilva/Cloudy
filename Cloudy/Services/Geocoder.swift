//
//  Geocoder.swift
//  Cloudy
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import CoreLocation

class Geocoder: LocationService {
    
    // MARK: -
    
    private lazy var geocoder = CLGeocoder()
    
    // MARK: -
    
    func geocode(addressString: String?, completionHandler: @escaping LocationService.LocationServiceCompletionHandler) {
        guard let addressString = addressString, !addressString.isEmpty else {
            completionHandler([], nil)
            return
        }
        
        // Geocode Address String
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                completionHandler([], error)
                print("Unable to Forward Geocode Address (\(error)")
                
            } else if let _placemarks = placemarks {
                let locations = _placemarks.flatMap({ (placemark) -> Location? in
                    guard let name = placemark.name else { return nil }
                    guard let location = placemark.location else { return nil }
                    return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                })
                completionHandler(locations, nil)
            }
        }
    }
}
