//
//  FirebaseManager.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by user164669 on 2/10/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: NSObject {
    
    static let databaseRef = Database.database().reference()
    static var currentUserId:String = Auth.auth().currentUser!.uid
    static var currentUser: FirebaseAuth.User? = nil
    static var events = [Event]()
    
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
    
    static func passwordReset(email: String,completion: @escaping (_ success:String) -> Void) {
         Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                print(error.localizedDescription)
                completion(error.localizedDescription)
            } else {
                completion("true") }
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
                    "userName": name,
                    "email": email,
                    "contactNo": contactNo,
                    "profileImageUrl":""]
        databaseRef.child("users").child(currentUserId).setValue(user){ error, ref in
            if error != nil {
                print("asdrt", error as Any)
            }
        }
    }
    
    static func UpdateUser(name:String, email:String, contactNo:String, about: String, firstName:String, lastName: String){
        let user = ["uid":currentUserId,
                    "userName": name,
                    "email": email,
                    "contactNo": contactNo,
                    "firstName": firstName,
                    "lastName": lastName,
                    "about": about]
        databaseRef.child("users").child(currentUserId).setValue(user){ error, ref in
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
                    FirebaseManager.databaseRef.child("users").child(currentUserId).updateChildValues(["profileImageUrl": downloadUrl.absoluteString])
                    })
                    
                }
            }
        }
    }
    
    static func UploadEventPhoto(profileImage:UIImage, eventID: String){
        let eventImageRef = Storage.storage().reference().child("EventImages").child("\(NSUUID().uuidString).jpg")
        if let imageData = profileImage.jpegData(compressionQuality: 0.25){
            eventImageRef.putData(imageData, metadata:nil){
                metadata, error in
                if error != nil {
                    print(error as Any)
                    return
                } else {
                    print(metadata as Any)
                    eventImageRef.downloadURL(completion: { (URL, Error) in
                        guard let downloadUrl = URL else {
                            print(Error as Any)
                            return
                        }
                       databaseRef.child("Events").queryOrdered(byChild: "eventId").queryEqual(toValue: eventID).ref.updateChildValues(["eventImageUrl": downloadUrl.absoluteString])
                    })
                    
                }
            }
        }
    }
    static func getCurrentUser(completion: @escaping (User) -> ()) {
        databaseRef.child("users").child(currentUserId).observeSingleEvent(of: .value, with: {
            snapshot in
            if let result = snapshot.value as? [String:AnyObject]{
                let uid = result["uid"]! as! String
                let username = result["userName"]! as! String
                let email = result["email"]! as! String
                let firstName = result["firstName"] as? String ?? ""
                let lastName = result["lastName"] as? String ?? ""
                let contactNo = result["contactNo"]! as! String
                let about = result["about"]as? String ?? ""
                let profileImageUrl = result["profileImageUrl"]! as! String
                
                let u = User(uid: uid, username: username, email: email, contactNo: contactNo, about: about, firstName:firstName, lastName: lastName, profileImageUrl: profileImageUrl)
                completion(u)
            }
        })
    }
    
    static func addEvent(eventId:String, startDate:String, endDate:String, title:String, organizer:String, about:String, longitude:String, latitude:String, venu:String, eventType:String, entrance:String, goingCount:String){
        let e = Event(userId: currentUserId, eventId: eventId, startDate: startDate, endDate: endDate, title: title, organizer: organizer, about: about, longitude: longitude, latitude: latitude, venu: venu, eventType: eventType, entrance: entrance, goingCount: goingCount, eventImageUrl: "")
        let event = [
            "uid":currentUserId,
            "eventId" : e.eventId,
            "startDate" : e.startDate,
            "endDate" : e.endDate,
            "title" : e.title,
            "organizer" : e.organizer,
            "about" : e.about,
            "longitude" : e.longitude,
            "latitude" : e.latitude,
            "venu" : e.venu,
            "eventType" : e.eventType,
            "entrance" : e.entrance,
            "goingCount" : e.goingCount,
            "eventImageUrl" : ""
            ] as [String : Any]
            databaseRef.child("Events").childByAutoId().setValue(event)
    }
    
    static func getUserEvents(completion: @escaping ([Event]) -> ()) {
        events = []
        databaseRef.child("Events").queryOrdered(byChild: "uid").queryEqual(toValue:currentUserId).observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject]{
                print(result)
                let userId = ""
                let eventId = result["eventId"]! as! String
                let startDate = result["startDate"]! as! String
                let endDate = result["endDate"]! as! String
                let title = result["title"]! as! String
                let organizer = result["organizer"]! as! String
                let about = result["about"]! as! String
                let longitude = result["longitude"]! as! String
                let latitude = result["latitude"]! as! String
                let venu = result["venu"]! as! String
                let eventType = result["eventType"]! as! String
                let entrance = result["entrance"]! as! String
                let goingCount = result["goingCount"]! as! String
                let eventImageUrl = result["eventImageUrl"]! as! String
                
                let e = Event(userId: userId, eventId: eventId, startDate: startDate, endDate: endDate, title: title, organizer: organizer, about: about, longitude: longitude, latitude: latitude, venu: venu, eventType: eventType, entrance: entrance, goingCount: goingCount, eventImageUrl: eventImageUrl)
                
                FirebaseManager.events.append(e)
            }
            completion(FirebaseManager.events)
        })
    }
    
    static func updateGoingCount(eventId:String){
        databaseRef.child("Events").queryOrdered(byChild: "eventId").queryEqual(toValue:eventId).observe(.childAdded, with: {
            snapshot in
            let result = snapshot.value as? [String:AnyObject]
            let goingCount = result?["goingCount"]! as! String
            let updateCount = Int(goingCount)!+1
            databaseRef.child("Events").child(snapshot.key).updateChildValues(["goingCount": String(updateCount)])
        })
        databaseRef.child("users").child(currentUserId).observeSingleEvent(of: .value, with: {
            snapshot in
            let result = snapshot.value as? [String:AnyObject]
            var goingEvent: [String] = result?["goingEvents"] as! [String]
            goingEvent.append(eventId)
            databaseRef.child("users").child(currentUserId).updateChildValues(["goingEvents": goingEvent ])
        })
    }
    static func updateNotGoingCount(eventId:String){
        databaseRef.child("Events").queryOrdered(byChild: "eventId").queryEqual(toValue:eventId).observe(.childAdded, with: {
            snapshot in
            let result = snapshot.value as? [String:AnyObject]
            let goingCount = result?["goingCount"]! as! String
            let updateCount = Int(goingCount)!-1
            databaseRef.child("Events").child(snapshot.key).updateChildValues(["goingCount": String(updateCount)])
        })
        databaseRef.child("users").child(currentUserId).observeSingleEvent(of: .value, with: {
            snapshot in
            let result = snapshot.value as? [String:AnyObject]
            var goingEvent: [String] = result?["goingEvents"] as! [String]
            goingEvent.removeAll{$0 == eventId}
            databaseRef.child("users").child(currentUserId).updateChildValues(["goingEvents": goingEvent ])
        })
    }
    static func getAllEvents(completion: @escaping ([Event]) -> ()) {
        events = []
        databaseRef.child("Events").observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject]{
                let userId = result["uid"] as! String
                let eventId = result["eventId"]! as! String
                let startDate = result["startDate"]! as! String
                let endDate = result["endDate"]! as! String
                let title = result["title"]! as! String
                let organizer = result["organizer"]! as! String
                let about = result["about"]! as! String
                let longitude = result["longitude"]! as! String
                let latitude = result["latitude"]! as! String
                let venu = result["venu"]! as! String
                let eventType = result["eventType"]! as! String
                let entrance = result["entrance"]! as! String
                let goingCount = result["goingCount"]! as! String
                let eventImageUrl = result["eventImageUrl"]! as! String
                
                let e = Event(userId: userId, eventId: eventId, startDate: startDate, endDate: endDate, title: title, organizer: organizer, about: about, longitude: longitude, latitude: latitude, venu: venu, eventType: eventType, entrance: entrance, goingCount: goingCount, eventImageUrl: eventImageUrl)
                
                FirebaseManager.events.append(e)
            }
            completion(FirebaseManager.events)
        })
    }
    
    static func search(searchText:String,completion: @escaping ([Event]) -> ()) {
        events = []
        databaseRef.child("Events").queryOrdered(byChild: "title").queryEqual(toValue: searchText).observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject]{
                let userId = result["uid"]! as! String
                let eventId = result["eventId"]! as! String
                let startDate = result["startDate"]! as! String
                let endDate = result["endDate"]! as! String
                let title = result["title"]! as! String
                let organizer = result["organizer"]! as! String
                let about = result["about"]! as! String
                let longitude = result["longitude"]! as! String
                let latitude = result["latitude"]! as! String
                let venu = result["venu"]! as! String
                let eventType = result["eventType"]! as! String
                let entrance = result["entrance"]! as! String
                let goingCount = result["goingCount"]! as! String
                let eventImageUrl = result["eventImageUrl"]! as! String
                
                let e = Event(userId: userId, eventId: eventId, startDate: startDate, endDate: endDate, title: title, organizer: organizer, about: about, longitude: longitude, latitude: latitude, venu: venu, eventType: eventType, entrance: entrance, goingCount: goingCount, eventImageUrl: eventImageUrl)
                
                FirebaseManager.events.append(e)
            }
            completion(FirebaseManager.events)
        })
    }

    static func checkGoingEvent(eventId:String,completion: @escaping (Bool) -> ()) {
        databaseRef.child("users").child(currentUserId).observeSingleEvent(of: .value, with: {
            snapshot in
            let result = snapshot.value as? [String:AnyObject]
            var goingEvent: [String] = result?["goingEvents"] as! [String]
            if goingEvent.contains(eventId) {
                completion(true)
            }
            completion(false)
        })
    }
}

