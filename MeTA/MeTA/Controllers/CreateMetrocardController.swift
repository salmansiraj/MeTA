//
//  CreateMetrocardController.swift
//  MeTA
//
//  Created by salman siraj on 2/22/20.
//  Copyright © 2020 senior design. All rights reserved.
//


import UIKit
import RealmSwift

class CreateMetrocardController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var currUser = UserDefaults.standard.string(forKey: "currUser")
    
    @IBOutlet var timePaymentCompleteView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet var directDepositCompleteView: UIView!
    @IBOutlet var errorView: UIView!
    
    @IBOutlet weak var amountAdded: UITextField!
    
    
//    Popup views + their attributes
    let realm = try! Realm()

    @IBOutlet weak var coverBackground: UIImageView!
    @IBOutlet weak var coverBackground2: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var connectCardButton: UIButton!
    
    let metroCardTypes = [
        "Direct Deposit",
        "Weekly Card",
        "Monthly Card"
    ]
    
    
    func animateIn(output: String) {
        if output == "directDeposit" {
            self.view.addSubview(directDepositCompleteView)
            directDepositCompleteView.center = self.view.center
            directDepositCompleteView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            directDepositCompleteView.alpha = 0
            
            UIView.animate(withDuration: 0.4) {
                self.directDepositCompleteView.alpha = 1
                self.directDepositCompleteView.transform = CGAffineTransform.identity
            }
        } else if (output == "unlimitedDeposit") {
            self.view.addSubview(timePaymentCompleteView)
            timePaymentCompleteView.center = self.view.center
            timePaymentCompleteView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            timePaymentCompleteView.alpha = 0
            
            UIView.animate(withDuration: 0.4) {
                self.timePaymentCompleteView.alpha = 1
                self.timePaymentCompleteView.transform = CGAffineTransform.identity
            }
        } else {
            self.view.addSubview(errorView)
            errorView.center = self.view.center
            errorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            errorView.alpha = 0
            
            UIView.animate(withDuration: 0.4) {
                self.errorView.alpha = 1
                self.errorView.transform = CGAffineTransform.identity
            }
        }
    }
    
    
    func checkCard(currUser : String) -> Bool {
        let cardDB = realm.objects(Metrocard.self).filter("username = %@", currUser)
        if (cardDB.count == 0) {
            return true
        } else {
            return false
        }
    }
    
    func createMetroCard(currUser : String, cardType : String, amtToAdd : String) -> Bool {
        if (checkCard(currUser: currUser)) {
            let newCard = Metrocard()
            newCard.cardID = realm.objects(Metrocard.self).count + 1
            newCard.username = currUser
            if (amtToAdd == "inf") {
                newCard.balance = Double.greatestFiniteMagnitude
            }
            else {  newCard.balance += Double(amtToAdd)! }
            let today = Date()
            switch cardType {
                case "Weekly Card":
                    UserDefaults.standard.set("Weekly Card", forKey: "cardType")
                    
                    let expirDate = Calendar.current.date(byAdding: .day, value: 7, to: today)
                    newCard.expirationDate = expirDate!
                case "Monthly Card":
                    UserDefaults.standard.set("Monthly Card", forKey: "cardType")
                    let expirDate = Calendar.current.date(byAdding: .month, value: 1, to: today)
                    newCard.expirationDate = expirDate!
                default:
                    
                    UserDefaults.standard.set("Direct Deposit", forKey: "cardType")
                    newCard.expirationDate = today
            }
            newCard.cardType = cardType
            do {
                try realm.write() { realm.add(newCard)  }
            } catch { print("Error initialising new realm, \(error)") }
            return true
        } else {
            return false
        }
    }
    
    @IBAction func completePressed(_ sender: Any) {
        let floatValue = NSString(string: amountAdded.text!).floatValue
        
        if (amountAdded.text == "") || (floatValue < 0) {
            coverBackground.isHidden = true
            coverBackground2.isHidden = false
            animateIn(output: "Error: Insufficient amount")
            
        } else if (floatValue > 0) {
            if (createMetroCard(currUser: currUser!, cardType: "Direct Deposit", amtToAdd: amountAdded.text!)) {
//                animateIn(output: "directDeposit")
                self.performSegue(withIdentifier: "example", sender: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "User metrocard exists already", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Return", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        } else {
            animateIn(output: "Error")
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return metroCardTypes.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return metroCardTypes[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        pickerView.setValue(UIColor.white, forKeyPath: "textColor")
        amountAdded.delegate = self
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        let selectedValue = metroCardTypes[pickerView.selectedRow(inComponent: 0)]
        
        if selectedValue == "Direct Deposit" {
            coverBackground.isHidden = true
            coverBackground2.isHidden = false
            
        } else if (selectedValue == "Monthly Card") {
            if (createMetroCard(currUser: currUser!, cardType: "Monthly Card", amtToAdd: "inf")) {
//                    animateIn(output: "unlimitedDeposit")
                connectCardButton.isHidden = false
                continueButton.isHidden = true
//                self.performSegue(withIdentifier: "example", sender: nil)
            } else {
                let alert = UIAlertController(title: "Error?", message: "User metrocard exists already", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Return", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            if (createMetroCard(currUser: currUser!, cardType: "Weekly Card", amtToAdd: "inf")) {
                connectCardButton.isHidden = false
                continueButton.isHidden = true
//                self.performSegue(withIdentifier: "example", sender: nil)
//                    animateIn(output: "unlimitedDeposit")
            } else {
                let alert = UIAlertController(title: "Error?", message: "User metrocard exists already", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Return", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func connectCardPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "example", sender: nil)
    }
    
    @IBAction func tryAgainPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            self.errorView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.errorView.alpha = 0.0;

        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.errorView.removeFromSuperview()
                self.coverBackground.isHidden = false
                self.coverBackground2.isHidden = true
            }
        });
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountAdded.delegate = self
        return true
    }
    
}
