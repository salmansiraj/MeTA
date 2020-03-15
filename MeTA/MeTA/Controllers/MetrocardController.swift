//
//  MetroCardPage.swift
//  MeTA
//
//  Created by salman siraj on 2/22/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MetrocardController: UIViewController {
    
    var currUser = UserDefaults.standard.string(forKey: "currUser")
    let realm = try! Realm()
    
    @IBOutlet weak var currBalance: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var expirDate: UILabel?
    
    
    @IBAction func refillPressed(_ sender: Any) {
        let cardDB = realm.objects(Metrocard.self).filter("username = %@", currUser!)
        
        if (cardDB[0].cardType == "Direct Deposit") {
            self.performSegue(withIdentifier: "refill", sender: nil)
            
        } else {
            let alert = UIAlertController(title: "Invalid Action", message: "Card Type is unlimited. You can only refill if you have a direct deposit type card", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Return", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cardDB = realm.objects(Metrocard.self).filter("username = %@", currUser!)
        if (cardDB.count == 0) {
            currBalance.text = "$ 0.00"
            cardType.text = " None "
            expirDate!.text = " N/A "
        } else {
            if (cardDB[0].balance == Double.greatestFiniteMagnitude) {
                currBalance.text = "Unlimited"
            }
            else {
                currBalance.text = "$ " + String(cardDB[0].balance)
            }
            cardType.text = cardDB[0].cardType
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .short
            expirDate!.text = formatter1.string(from: cardDB[0].expirationDate ?? Date())
        }
        // Do any additional setup after loading the view.
    }
    
    
    
}


