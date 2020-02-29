//
//  AuthViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/8/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import SVProgressHUD

class AuthViewController: RootViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func guestButtonPress(_ sender: Any) {
         self.performSegue(withIdentifier: "guestView", sender: self)
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        
//        if(ValidationController.isValidPassword(password: passwordTextField.text!) && ValidationController.isValidEmail(email: emailTextField.text!)){
          SVProgressHUD.show()
            FirebaseManager.login(email: emailTextField.text!,password: passwordTextField.text!){
                (success:Bool) in
                if(!success) {
                    let alertController = UIAlertController(title: "Cant't find account", message:
                        "It looks like \(self.emailTextField.text!) doesnt match an existing account.if you dont have a NIBM Event account, you can create one now ", preferredStyle: .alert);
                    let createAccAction = UIAlertAction(title: "CREATE ACCOUNT", style: .default) {
                        UIAlertAction in
                        self.performSegue(withIdentifier: "userRegistration", sender: self)
                    };
                    
                    alertController.addAction( createAccAction);
                    alertController.addAction(UIAlertAction(title: "TRY AGAIN", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    print("Login Success.")
                    
                    UserDefaults.standard.set(true, forKey: "status")
                    Switcher.updateRootVC()
                    
                    self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)
                    
                    SVProgressHUD.dismiss()
                }
            }
//        }else{
//            let alertController = UIAlertController(title: "Error", message: "Invalid Email Address or Passsword", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
//
//            self.present(alertController, animated: true, completion: nil)
//        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "guestView",
            let destinationViewController = segue.destination as? RecentEventTableViewController {
            destinationViewController.isGuest = true
        }
    }
}
