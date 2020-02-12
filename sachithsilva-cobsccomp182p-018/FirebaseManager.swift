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
import FirebaseStorage

class FirebaseManager: NSObject {
    
    static let databaseRef = Database.database().reference()
    static var currentUserId:String = Auth.auth().currentUser!.uid
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
                print("asdxd", error.localizedDescription)
                return
            }
            AddUser(name: name, email: email, contactNo: contactNo)
            completion("")
        })
    }
    static func AddUser(name:String, email:String, contactNo:String){
        let user = ["uid":currentUserId,
                    "userName":name,
                    "email":email,
                    "contactNo":contactNo,
                    "profileImageUrl":""]
        databaseRef.child("users").child(currentUserId).setValue(user){ error, ref in
            if error != nil {
                print("asdrt", error as Any)
            }
        }
    }
    
    static func UpdateUser(name:String, email:String, contactNo:String){
        let post = ["uid":currentUserId,
                    "userName":name,
                    "email":email,
                    "contactNo":contactNo,
                    "profileImageUrl":""]
        databaseRef.child("users").child(currentUserId).setValue(post){ error, ref in
            if error != nil {
                print("asdrt", error as Any)
            }
        }
    }
    
    static func UploadProfilePhoto(profileImage:UIImage){
        let profileImageRef = Storage.storage().reference().child("profileImages").child("\(NSUUID().uuidString).jpg")
        if let imageData = profileImage.jpegData(compressionQuality: 0.25){
            profileImageRef.putData(imageData, metadata:nil){
                metadata, error in
                if error != nil {
                    print(error as Any)
                    return
                } else {
                    print(metadata as Any)
                    profileImageRef.downloadURL(completion: { (URL, Error) in
                        guard let downloadUrl = URL else {
                            print(Error as Any)
                            return
                        }
                    FirebaseManager.databaseRef.child("users").child(currentUserId).updateChildValues(["profileImageUrl": downloadUrl])
                    })
                    
                }
            }
        }
    }
    
    static func getCurrentUser(uid:String , completion: @escaping (User) -> Void) {
        databaseRef.child("users").observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject]{
                let uid = result["uid"]! as! String
                let username = result["username"]! as! String
                let email = result["email"]! as! String
                let profileImageUrl = result["profileImageUrl"]! as! String
                
                let u = User(uid: uid, username: username, email: email, contactNo: <#String#>, about: <#String#>, firstName: <#String#>, lastName: <#String#>, profileImageUrl: profileImageUrl)
                completion(u)
            }
        })
    }
}
