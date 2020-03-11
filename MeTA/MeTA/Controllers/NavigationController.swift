//
//  NavigationController.swift
//  MeTA
//
//  Created by salman siraj on 3/4/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "showDetail2", sender: nil)
    }

    
}
