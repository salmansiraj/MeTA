//
//  CoreMLController.swift
//  SeeFood
//
//  Created by Brittany Ng on 2/24/20.
//  Copyright © 2020 Brittany Ng. All rights reserved.
//

import UIKit
import CoreML
import Vision
import RealmSwift

class CoreMLController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var currUser = UserDefaults.standard.string(forKey: "currUser")
    let realm = try! Realm()

//    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImageView.image = userPickedImage
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CI Image")
            }
            detect(image: ciimage)
        }
        // imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
 func detect(image: CIImage) {
            let fare = 2.75
            let cardDB = realm.objects(Metrocard.self).filter("username = %@", currUser!)
            
            guard let model = try? VNCoreMLModel(for: OMNYClassifier3().model) else {
                fatalError("Loading CoreML Model Failed")
            }
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                guard let result = request.results as? [VNClassificationObservation] else {
                    fatalError("Model failed to process image.")
                }

                if let firstResult = result.first {
                    // verifying OMNY scanner
                    if firstResult.identifier.contains("OMNY") {
                        self.navigationItem.title = "OMNY"
                        // checking card type
                        if (cardDB[0].cardType == "Direct Deposit") {
                            // checking balance
                            if (cardDB[0].balance - fare) < 0 {
                                self.imagePicker.dismiss(animated: true, completion: nil)
                                 let alert = UIAlertController(title: "Insufficient Balance", message: "Not enough money on your card. ", preferredStyle: .alert)
                                 alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                                 self.present(alert, animated: true, completion: nil)
                            
                             } else {
                                 try! self.realm.write {
                                    cardDB[0].balance -= fare
                                    self.imagePicker.dismiss(animated: true, completion: nil)

                                 }
                             }
                        }
                    // if not OMNY
                    } else {
                        self.navigationItem.title = "Not OMNY"
                        self.imagePicker.dismiss(animated: true, completion: nil)
                        let alert = UIAlertController(title: "Error!    ", message: "OMNY Scanner not detected. Please try again...", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            
            do {
                try! handler.perform([request])
            }
        }

    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    //    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
//        present(imagePicker, animated: true, completion: nil)
//
//    }
    
}

