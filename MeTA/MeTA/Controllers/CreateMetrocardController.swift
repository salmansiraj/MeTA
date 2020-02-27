//
//  CreateMetrocardController.swift
//  MeTA
//
//  Created by salman siraj on 2/22/20.
//  Copyright © 2020 senior design. All rights reserved.
//


import UIKit


class CreateMetrocardController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var timePaymentCompleteView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet var directDepositCompleteView: UIView!
    @IBOutlet var errorView: UIView!
    
    @IBOutlet weak var amountAdded: UITextField!
    
    
//    Popup views + their attributes

    @IBOutlet weak var coverBackground: UIImageView!
    @IBOutlet weak var coverBackground2: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    
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
    
    @IBAction func completePressed(_ sender: Any) {
        let floatValue = NSString(string: amountAdded.text!).floatValue
        
        if (amountAdded.text == "") || (floatValue < 0) {
            coverBackground.isHidden = true
            coverBackground2.isHidden = false
            animateIn(output: "error")
            
        } else if (floatValue > 0) {
            animateIn(output: "directDeposit")
            
        } else {
            animateIn(output: "error")
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
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        let selectedValue = metroCardTypes[pickerView.selectedRow(inComponent: 0)]
        
        if selectedValue == "Direct Deposit" {
            coverBackground.isHidden = true
            coverBackground2.isHidden = false
        } else {
            coverBackground2.isHidden = false
            animateIn(output: "unlimitedDeposit")
        }
    }
    
    @IBAction func tryAgainPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            self.errorView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.errorView.alpha = 0.0;

        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.errorView.removeFromSuperview()
            }
        });
    }
    
}
