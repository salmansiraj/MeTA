//
//  ViewController.swift
//  MeTA
//
//  Created by salman siraj on 2/20/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit
import RealmSwift

class LoginController: UIViewController {

    @IBOutlet weak var myPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
//        myPassword.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }


}

