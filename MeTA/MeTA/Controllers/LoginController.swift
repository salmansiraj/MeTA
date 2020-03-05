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
    @IBOutlet weak var myEmail: UITextField!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPassword.isSecureTextEntry = true
    }
    
    
    @IBAction func checkUser(_ sender: Any) {
        let userBase = realm.objects(User.self)
        for user in userBase {
            if (user.email != myEmail.text) && (user.password != myPassword.text) {
                let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            } else {
                performSegue(withIdentifier: "showDetail1", sender: nil)
            }
        }
    }
    


}
