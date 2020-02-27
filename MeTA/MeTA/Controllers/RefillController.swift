//
//  RefillController.swift
//  MeTA
//
//  Created by salman siraj on 2/24/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit

class RefillController: UIViewController {
    
    @IBOutlet var completeView: UIView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var depositLabel: UILabel!
    @IBOutlet weak var depositText: UITextField!
    
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
        animateIn()
    }
    
    @IBAction func tryAgainPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            self.completeView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.completeView.alpha = 0.0;

        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.completeView.removeFromSuperview()
            }
        });
    }
    
    
    
}
