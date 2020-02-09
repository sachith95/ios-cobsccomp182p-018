//
//  FirebaseRequestFetcher.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/9/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseRequestFetcher {
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    init() {
         self.ref = Database.database().reference()
    }
   /*
    func addUserDetails(_username) -> Void {
        ref.child("users").child(userID).setValue(["username": _username])
    }
 */
    
    
}
