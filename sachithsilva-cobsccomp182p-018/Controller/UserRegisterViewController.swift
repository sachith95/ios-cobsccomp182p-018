//
//  UserRegisterViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/8/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserRegisterViewController: RootViewController {
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var contactNoTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createAccButtonPress(_ sender: Any) {
        if(ValidationController.isValidPassword(password: passwordTextField.text!)){ if(ValidationController.isValidEmail(email: emailTextField.text!)){
            FirebaseManager.createUser(email:  emailTextField.text!, password: passwordTextField.text!, name: userNameTextField.text!, contactNo: contactNoTextField.text!){
                (result:String) in
                print(result)
            }
        }else{
            let alertController = UIAlertController(title: "Error", message: "Invalid Email", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            }
        } else{
            let alertController = UIAlertController(title: "Error", message: "Paasword should be 6 character with a special character", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
}
