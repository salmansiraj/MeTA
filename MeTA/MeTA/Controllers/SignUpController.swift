//
//  SignUpController.swift
//  MeTA
//
//  Created by salman siraj on 3/3/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit
import RealmSwift

class SignUpController: UIViewController, UITextFieldDelegate {
    let realm = try! Realm()
    var userBase = [User]()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
    }
    
    
    @IBAction func createUser(_ sender: Any) {
        let newUser = User()
        newUser.username = firstName.text!
        newUser.firstName = firstName.text!
        newUser.lastName = lastName.text!
        newUser.email = email.text!
        newUser.password = password.text!
        
        self.userBase.append(newUser)
        self.saveUser(newUser: newUser)
    }
    
    func saveUser(newUser : User) {
        do {
            try realm.write() {
                realm.add(newUser)
            }
        } catch {
            print("Error initialising new realm, \(error)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    
    
}
