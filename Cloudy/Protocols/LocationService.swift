//
//  LocationService.swift
//  Cloudy
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

protocol LocationService {
    typealias LocationServiceCompletionHandler = ([Location], Error?) -> Void
    
    func geocode(addressString: String?, completionHandler: @escaping LocationServiceCompletionHandler)
}
