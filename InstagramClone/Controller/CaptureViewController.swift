//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Vichet Meng on 10/29/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imagePickerImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBAction func onSubmit(_ sender: Any) {
        if let image = imagePickerImageView.image {
            Post.postUserImage(image: image, withCaption: captionTextField.text) { (success, error) in
                if success {
                    print("succesfully posted an image")
                } else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.allowsEditing = true
        imagePickerVC.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerVC.sourceType = .photoLibrary
        } else {
            imagePickerVC.sourceType = .photoLibrary
        }
        
        self.present(imagePickerVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[.originalImage] as! UIImage
        let editedImage = info[.editedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        imagePickerImageView.image = editedImage
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
