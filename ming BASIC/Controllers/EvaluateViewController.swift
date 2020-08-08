//
//  EvaluateViewController.swift
//  ming BASIC (MLEvaluate experiment)
//
//  Created by Leping Qiu on 2020/8/3.
//  Copyright © 2020 bluemagic. All rights reserved.
//

import UIKit
import CoreML
import Vision

class EvaluateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController() //create new image picker class
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "评估"
        
        // imagePicker properties
        imagePicker.delegate = self //set image picker delegate
        imagePicker.sourceType = .camera //implementing camera functionality
        imagePicker.allowsEditing = false //allowing to crop or edit image
    }
    
    // (1) do something with image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // (1) retrieve image //downcasting Any to UIImage with an optional binding
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // (1) set background
            imageView.image = userPickedImage
            
            // (2) convert image to ciimage for ML
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("could not convert to CIImage") //safety feature
            }
            
            // (2) Call on method
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    // (2) create method to use model
    func detect(image: CIImage) {
        
        //create model
        guard let model = try? VNCoreMLModel(for: MyTextClassifierOne().model)  else {
            fatalError("Failed to load coreML model") //"try" attempt operation
        }
        
        //request to call on model to classify data
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            
            // (3) results (good for now) (need to edit when model updates)
            
            print(results) //debug only
            
            if let firstResult = results.first {
                if firstResult.identifier.contains("李") {
                    self.navigationItem.title = "李"
                } else {
                    self.navigationItem.title = "勇"
                }
            }
        }
        
        //data passed is defined as a handler
        let handler = VNImageRequestHandler(ciImage: image)
        
        //use image handler to perform classification
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        // (1) present imagePicker to user
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}
