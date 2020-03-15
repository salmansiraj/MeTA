//
//  ViewController.swift
//  MeTA
//
//  Created by salman siraj on 2/20/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit
import RealmSwift

class LoginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myEmail: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPassword.isSecureTextEntry = true
        myPassword.delegate = self
        myEmail.delegate = self
        
    }
    

    @IBAction func checkUser(_ sender: Any) {
        let userBase = realm.objects(User.self)
        for user in userBase {
            if (user.email == myEmail.text) && (user.password == myPassword.text) {
                UserDefaults.standard.set(user.username, forKey: "currUser")
                performSegue(withIdentifier: "showDetail1", sender: nil)
            }
        }
        let alert = UIAlertController(title: "Invalid Login", message: "MeTA account doesn't exist. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        self.performSegue(withIdentifier: "signupSegue", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myEmail.resignFirstResponder()
        myPassword.resignFirstResponder()
        return true
    }
    
}

