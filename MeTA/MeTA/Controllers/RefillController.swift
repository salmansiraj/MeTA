//
//  RefillController.swift
//  MeTA
//
//  Created by salman siraj on 2/24/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit
import RealmSwift

class RefillController: UIViewController {
    
    @IBOutlet var completeView: UIView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var depositLabel: UILabel!
    @IBOutlet weak var depositText: UITextField!
    
    var currUser = UserDefaults.standard.string(forKey: "currUser")
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeView.layer.cornerRadius = 5
    }
    
    
    func animateIn() {
        depositLabel.isHidden = true
        depositText.isHidden = true
        self.view.addSubview(completeView)
        completeView.center = self.view.center
        completeView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        completeView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.completeView.alpha = 1
            self.completeView.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func completePressed(_ sender: Any) {
        let doubleValue = NSString(string: depositText.text!).doubleValue
        let cardDB = realm.objects(Metrocard.self).filter("username = %@", currUser!)

        if (depositText.text != "") || (doubleValue > 0.0) {
            try! realm.write {
                cardDB[0].balance += doubleValue
            }
            animateIn()
        } else {
            let alert = UIAlertController(title: "Error?", message: "Insufficient amount added. Please try again...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    
}
