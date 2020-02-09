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
import SwiftyJSON

enum NetworkError: Error {
    case failure
    case success
}

class FirebaseRequestFetcher {
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    init() {
         self.ref = Database.database().reference()
    }
    var searchResults = [JSON]()
    
    func search(searchText: String, completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
        let urlToSearch = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=\(searchText)&gpslimit=10"
        
//        Alamofire.request(urlToSearch).responseJSON { response in
//            guard let data = response.data else {
//                completionHandler(nil, .failure)
//                return
//            }
//
//            let json = try? JSON(data: data)
//            let results = json?["query"]["pages"].arrayValue
//            guard let empty = results?.isEmpty, !empty else {
//                completionHandler(nil, .failure)
//                return
//            }
//
//            completionHandler(results, .success)
//        }
    }
    
    func fetchImage(url: String, completionHandler: @escaping (UIImage?, NetworkError) -> ()) {
//        Alamofire.request(url).responseData { responseData in
//
//            guard let imageData = responseData.data else {
//                completionHandler(nil, .failure)
//                return
//            }
//
//            guard let image = UIImage(data: imageData) else {
//                completionHandler(nil, .failure)
//                return
//            }
//
//            completionHandler(image, .success)
//        }
//    }
}
   /*
    func addUserDetails(_username) -> Void {
        ref.child("users").child(userID).setValue(["username": _username])
    }
 */
    
    
}
