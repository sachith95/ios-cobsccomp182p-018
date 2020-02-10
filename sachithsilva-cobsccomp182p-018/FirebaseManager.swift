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
    
    
    func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let e = error{
                callback?(e)
                return
            }
            callback?(nil)
        }
    }
    
    static func AddUser(username:String, email:String){
        let uid = Auth.auth().currentUser?.uid
        let post = ["uid":uid!,
                    "username":username,
                    "email":email,
                    "profileImageUrl":""]
        databaseRef.child("users").child(uid!).setValue(post)
    }
}
