//
//  AuthViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Janith Ganewatta on 2/8/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: RootViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        login()
    }
    
    @IBAction func createAccButtonPressed(_ sender: Any) {
         self.performSegue(withIdentifier: "userRegistration", sender: self)
    }
    
    func login() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (result, error) in
            if error != nil {
                print("error: \(error!)")
                let alertController = UIAlertController(title: "Cant't find account", message:
                    "It looks like \(self.emailTextField.text) doesnt match an existing account.if you dont have a NIBM Event account, you can create one now ", preferredStyle: .alert);
                let createAccAction = UIAlertAction(title: "CREATE ACCOUNT", style: .default) {
                    UIAlertAction in
                    self.performSegue(withIdentifier: "userRegistration", sender: self)
                };
                
                alertController.addAction( createAccAction);
                alertController.addAction(UIAlertAction(title: "TRY AGAIN", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                print("Login Success.")
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
                
                // SVProgressHUD.dismiss()
            }
        }
        
    }
    
    func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let e = error{
                callback?(e)
                return
            }
            callback?(nil)
        }
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
