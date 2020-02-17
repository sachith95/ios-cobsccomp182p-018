//
//  UserProfileViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/10/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class UserProfileViewController: RootViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactNoTextField: UITextField!
    @IBOutlet weak var aboutTextField: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        FirebaseManager.getCurrentUser(){ (user) in
            self.fillUser(userDetails: user)
        }
        
        imagePicker.delegate = self
    }

 
    @IBAction func signOutButtonPress(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
    }
    
    @IBAction func saveButtonPress(_ sender: Any) {
        FirebaseManager.UpdateUser(name: userNameTextField.text ?? "", email: emailTextField.text ?? "", contactNo: contactNoTextField.text ?? "", about: aboutTextField.text ?? "", firstName: fNameTextField.text ?? "", lastName: lNameTextField.text ?? "")
        self.uploadImage(image: (profileImageView.image ?? nil)! )
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
    func fillUser(userDetails:User) {
        userNameTextField.text = userDetails.username
        emailTextField.text = userDetails.email
        fNameTextField.text = userDetails.firstName
        lNameTextField.text = userDetails.lastName
        contactNoTextField.text = userDetails.contactNo
        aboutTextField.text = userDetails.about
        profileImageView.image = userDetails.getProfileImage()
    }
    
    
}


extension UserProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let editedImage = info[.editedImage] as? UIImage{
            self.profileImageView.image = editedImage
        }

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
