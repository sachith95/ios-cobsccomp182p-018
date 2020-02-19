//
//  PasswordResetViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Janith Ganewatta on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func resetButtonPress(_ sender: Any) {
        if(emailTextField.text! != ""){
            FirebaseManager.passwordReset(email: emailTextField.text!) { (value) in
                if(value == "true"){
                    let alertController = UIAlertController(title: "Succesfull", message:
                        "We have send a password reset link to your mail.please check your mail and follow the instruction ", preferredStyle: .alert)

                    let createAccAction = UIAlertAction(title: "ok", style: .default) {
                        UIAlertAction in
                        self.performSegue(withIdentifier: "reset", sender: self)
                    }
                     alertController.addAction(createAccAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: value, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
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
