//
//  CurrentUser.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/24/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class CurrentUser {
    
    var username: String!
    var QRCode: String!
    var hostedEvents: [String]?
    var invitedEvents: [String]?
    var id: String?
    
    let dbRef : FIRDatabaseReference!
    //let dbRef = FIRDatabase.database().reference()
    
    init() {
        let currentUser = FIRAuth.auth()?.currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
        dbRef =  FIRDatabase.database().reference()
    }
    
    /*
     TODO:
     
     Retrieve a list of post ID's that the user has already opened and return them as an array of strings.
     Note that our database is set up to store a set of ID's under the readPosts node for each user.
     Make a query to Firebase using the 'observeSingleEvent' function (with 'of' parameter set to .value) and retrieve the snapshot that is returned. If the snapshot exists, store its value as a [String:AnyObject] dictionary and iterate through its keys, appending the value corresponding to that key to postArray each time. Finally, call completion(postArray).
     */
    
    func getInvitedEvents(completion: @escaping ([String]) -> Void){
        var invitedEvents: [String] = []
        //Needs new logic!
        dbRef.child(firUsersNode).child(id!).child(firInvitedEventsNode).queryOrdered(byChild: "userid").queryEqual(toValue: id!).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let invitedEventsDict = snapshot.value as? [String: AnyObject] {
                    for key in invitedEventsDict.keys {
                        invitedEvents.append(invitedEventsDict[key] as! String)
                    }
                    completion(invitedEvents)
                }
            }
 
        })
        }
    
    func addNewInvitedEvent(eventId: String) {
        var dict = [String : String]()
        dict["count"] = "0"
        dict["userid"] = id!
        dict["eventid"] = eventId
        
        dbRef.child(firInvitesNode).childByAutoId().setValue(dict)
        // Test
    }
    
    func addNewHostedEvent(postID: String) {
        dbRef.child(firUsersNode).child(id!).child(firHostedEventsNode).childByAutoId().setValue(postID)
        // Test
    }
    
}
