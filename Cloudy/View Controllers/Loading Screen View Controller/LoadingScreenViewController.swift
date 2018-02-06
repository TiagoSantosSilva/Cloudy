//
//  LoadingScreenViewController.swift
//  Cloudy
//
//  Created by Tiago Santos on 06/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class LoadingScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRootViewController()
    }
    
    func loadRootViewController() {
        let rootViewController = RootViewController()
        present(rootViewController, animated: true)
    }
}
