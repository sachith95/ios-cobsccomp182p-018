//
//  AddEventViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/13/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class AddEventViewController: RootViewController {
    var longtitude:String?
    var latitude:String?
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var venuTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var lateTextField: UITextField!
    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var entranceTextField: UITextField!
    
    var mapVC = MapViewController();
    
    var imagePicker = UIImagePickerController()
    let eventID = String(1000+arc4random_uniform(8999))
    override func viewDidLoad() {
        super.viewDidLoad()
       imagePicker.delegate = self
       startDateTextField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
       endDateTextField.addInputViewDatePicker(target: self, selector: #selector(endDateDoneButtonPressed))
       longTextField.text = longtitude
       lateTextField.text = latitude
    }
    @objc func doneButtonPressed() {
        if let  datePicker = self.startDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            self.startDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.startDateTextField.resignFirstResponder()
    }

    @objc func endDateDoneButtonPressed() {
        if let  datePicker = self.endDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            self.endDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.endDateTextField.resignFirstResponder()
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
    override func viewDidAppear(_ animated: Bool){
        longTextField.text = longtitude
        lateTextField.text = latitude
        hostTextField.text =  UserDefaults.standard.string(forKey: "username") ?? "Hosted by NIBM"
        eventTypeTextField.text = eventTypeTextField.text != "" ? eventTypeTextField.text : "Public"
        entranceTextField.text = entranceTextField.text != "" ? entranceTextField.text : "Free"
    }
    
    @IBAction func openMapButtonPress(_ sender: Any) {
        self.performSegue(withIdentifier: "toMapView", sender: self)
    }
    @IBAction func saveButtonPress(_ sender: Any) {
        FirebaseManager.addEvent(eventId: self.eventID, startDate: startDateTextField.text ?? "", endDate: endDateTextField.text ?? "", title: eventNameTextField.text ?? "", organizer: hostTextField.text ?? "", about: detailTextField.text ?? "", longitude: longTextField.text ?? "", latitude: lateTextField.text ?? "", venu: venuTextField.text ?? "", eventType: eventTypeTextField.text ?? "", entrance: entranceTextField.text ?? "", goingCount: "1")
        if (self.eventImageView.image != nil){
        self.uploadImage(image: (eventImageView.image ?? nil)!)
        }
        _ = navigationController?.popViewController(animated: true)
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
        FirebaseManager.UploadEventPhoto(profileImage: image, eventID: self.eventID)
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
extension UITextField {
    
    func addInputViewDatePicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .dateAndTime
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}
