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

class CoreMLController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        imagePicker.dismiss(animated: true, completion: nil)

    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: OMNYClassifier3().model) else {
            fatalError("Loading CoreML Model Failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            print(result)
            if let firstResult = result.first {
                if firstResult.identifier.contains("OMNY") {
                    self.navigationItem.title = "OMNY"
                } else {
                    self.navigationItem.title = "Not OMNY"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try! handler.perform([request])
        } catch {
            print(error)
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

