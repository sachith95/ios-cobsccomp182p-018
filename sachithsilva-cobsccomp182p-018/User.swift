//
//  User.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by user164669 on 2/11/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    var username:String = ""
    var email:String = ""
    var contactNo:String = ""
    var uid:String = ""
    var profileImageUrl:String = ""
    var about:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var fbURL:String = ""
    var goingEvents:[String] = []
    
    init(uid:String, username:String, email:String, contactNo:String, about:String, firstName:String, lastName:String, profileImageUrl:String, fbURL: String){
        self.uid = uid
        self.username = username
        self.email = email
        self.contactNo = contactNo
        self.profileImageUrl = profileImageUrl
        self.about = about
        self.firstName = firstName
        self.lastName = lastName
        self.fbURL = fbURL
    }
    
    func getProfileImage() -> UIImage {
        if let url = NSURL(string: profileImageUrl){
            if let data = NSData(contentsOf: url as URL){
                return UIImage(data: data as Data)!
            }
        }
        return UIImage()
    }
}
