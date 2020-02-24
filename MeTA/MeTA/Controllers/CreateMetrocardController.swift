//
//  CreateMetrocardController.swift
//  MeTA
//
//  Created by salman siraj on 2/22/20.
//  Copyright © 2020 senior design. All rights reserved.
//


import UIKit


class CreateMetrocardController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var coverBackground: UIImageView!
    
    let metroCardTypes = [
        "Direct Deposit",
        "Weekly Card",
        "Monthly Card"
    ]
    
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
    }
    @IBAction func buttonPressed(_ sender: Any) {
        let selectedValue = metroCardTypes[pickerView.selectedRow(inComponent: 0)]
        
        if selectedValue == "Direct Deposit" {
            coverBackground.isHidden = true
        }
    }
}
