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
        FirebaseManager.createUser(email:  emailTextField.text!, password: passwordTextField.text!, name: userNameTextField.text!, contactNo: contactNoTextField.text!){
            (result:String) in
            print(result)
        }
    }
    

}
