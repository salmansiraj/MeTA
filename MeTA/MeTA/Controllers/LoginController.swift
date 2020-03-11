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
    @IBOutlet weak var myUsername: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPassword.isSecureTextEntry = true
    }
    
    
    @IBAction func checkUser(_ sender: Any) {
        let userBase = realm.objects(User.self)
        for user in userBase {
            if (user.username == myUsername.text) && (user.password == myPassword.text) {
                UserDefaults.standard.set(user.username, forKey: "currUser")
                performSegue(withIdentifier: "showDetail1", sender: nil)
            }
        }
        let alert = UIAlertController(title: "Invalid Login", message: "MeTA account doesn't exist. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}
