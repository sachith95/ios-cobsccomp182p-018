//
//  AuthViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/8/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class AuthViewController: RootViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
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
                // self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)
                
                // SVProgressHUD.dismiss()
            }
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
