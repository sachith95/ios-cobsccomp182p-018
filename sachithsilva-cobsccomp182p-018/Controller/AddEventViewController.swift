//
//  AddEventViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/13/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class AddEventViewController: RootViewController {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var venuTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var lateTextField: UITextField!
    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var entranceTextField: UITextField!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       imagePicker.delegate = self
    }

    @IBAction func uploadButtonPress(_ sender: Any) {
        let uploadImageOptionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let openCameraAction = UIAlertAction(title: "Open Camera", style: .default, handler: {
            _ in self.openCamera()
        })
        let fromLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: {_ in self.openGallary()})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        uploadImageOptionMenu.addAction(openCameraAction)
        uploadImageOptionMenu.addAction(fromLibraryAction)
        uploadImageOptionMenu.addAction(cancelAction)
        
        self.present(uploadImageOptionMenu, animated: true, completion: nil)
    }
    @IBAction func openMapButtonPress(_ sender: Any) {
    }
    @IBAction func saveButtonPress(_ sender: Any) {
        FirebaseManager.addEvent(eventId: "123", startDate: startDateTextField.text ?? "", endDate: endDateTextField.text ?? "", title: eventNameTextField.text ?? "", organizer: hostTextField.text ?? "", about: detailTextField.text ?? "", longitude: longTextField.text ?? "", latitude: lateTextField.text ?? "", venu: venuTextField.text ?? "", eventType: eventTypeTextField.text ?? "", entrance: entranceTextField.text ?? "", goingCount: "1")
          self.performSegue(withIdentifier: "myevent", sender: self)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have a camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func uploadImage(image :UIImage){
        FirebaseManager.UploadProfilePhoto(profileImage: image)
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension AddEventViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage{
            self.eventImageView.image = editedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
