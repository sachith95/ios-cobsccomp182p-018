//
//  PublicUserProfileViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/24/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class PublicUserProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var contactNoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fbURLabel: UILabel!
    
    var userID:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userID)
        FirebaseManager.getUserDetail(userID: self.userID){ (user) in
            self.fillUser(userDetails: user)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(PublicUserProfileViewController.tapFunction))
        fbURLabel.isUserInteractionEnabled = true
        fbURLabel.addGestureRecognizer(tap)
    }
    @objc func tapFunction() {
        let fb  = fbURLabel?.text ?? "https://www.facebook.com/"
        let url = URL(string: fb)!
        UIApplication.shared.open(url)
    }
    
    func fillUser(userDetails:User) {
        userNameLabel.text = userDetails.username
        emailLabel.text = userDetails.email
        contactNoLabel.text = userDetails.contactNo
        aboutLabel.text = userDetails.about
        profileImageView.image = userDetails.getProfileImage()
        fbURLabel.text = userDetails.fbURL
    }
}
