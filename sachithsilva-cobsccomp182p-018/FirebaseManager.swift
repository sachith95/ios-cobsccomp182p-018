//
//  FirebaseManager.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by user164669 on 2/10/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: NSObject {
    
    static let databaseRef = Database.database().reference()
    static var currentUserId:String = ""
    static var currentUser: FirebaseAuth.User? = nil
    
   static func login(email: String,password:String,completion: @escaping (_ success:Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password:password , completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                currentUser = user?.user
                currentUserId = (user?.user.uid)!
                completion(true) }
        })
    }
    
    
    static func createUser(email: String, password: String, name:String, contactNo:String, completion: @escaping(_ result:String) -> Void){
        Auth.auth().createUser(withEmail: email, password: password, completion:{ (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            AddUser(name: name, email: email, contactNo: contactNo)
            completion("")
        })
    }
    static func AddUser(name:String, email:String, contactNo:String){
        let uid = Auth.auth().currentUser?.uid
        let post = ["uid":uid!,
                    "name":name,
                    "email":email,
                    "contactNo":contactNo,
                    "profileImageUrl":""]
        databaseRef.child("users").child(uid!).setValue(post)
    }
}
