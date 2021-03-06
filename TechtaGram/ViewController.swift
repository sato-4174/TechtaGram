//
//  ViewController.swift
//  TechtaGram
//
//  Created by Satoru Nalamura on 2020/12/12.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraImageView: UIImageView!
    
    var originalImage: UIImage!
    
    var filter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePhonto() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
            
        } else{
            
            print("error")
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
                                    [UIImagePickerController.InfoKey : Any ]) {
            
            cameraImageView.image = info[.editedImage] as? UIImage
            
            originalImage = cameraImageView.image
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func savePhonto(){
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
    }
    
    @IBAction func colorFilter(){
        
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColerControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        filter.setValue(1.0, forKey: "inputSaturation")
        
        filter.setValue(0.5, forKey: "inputBrightness")
        
        filter.setValue(2.5, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
    }
    
    @IBAction func openAlbum(){
    
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }
    }

    @IBAction func snsPhonto (){
    
        let shareText = "写真加工いえい"
        
        let shareImage = cameraImageView.image!
        
        let activityItems: [Any] = [shareText, shareImage]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
        
        activityViewController.excludedActivityTypes = excludedActivityTypes
        
        present(activityViewController, animated: true, completion: nil)
        
    }

}
