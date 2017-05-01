//
//  lists.swift
//  iOSDecalCustomApp
//
//  Created by Angela Wong on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//
import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

//will change later, prob not string
var events: [String: [String]] = ["Current Events": [], "Invited To": []]
//
let eventTypes = ["Current Events", "Invited To"]

func getEvent(indexPath: IndexPath) -> String? {
    let eventType = eventTypes[indexPath.section]
    if let event = events[eventType] {
        return event[indexPath.row]
    }
    return nil
    
}

var people : [String: [String]] = ["People to Invite": []]
let pList = ["People To Invite"]

func getPerson(indexPath: IndexPath) -> String? {
    let num = pList[indexPath.section]
    if let person = people[num] {
        return person[indexPath.row]
    }
    return nil
}

func addInvite(eventID: String, userID: String, count: Int) {
    let dbRef = FIRDatabase.database().reference()
    let dict: [String:AnyObject] = [
        "userid": userID as AnyObject,
        "eventid": eventID as AnyObject,
        "count": count as AnyObject
    ]
    dbRef.child(firInvitesNode).childByAutoId().setValue(dict)
}

func getInvites(user: CurrentUser, completion: @escaping ([Invites]?) -> Void) {
    let dbRef = FIRDatabase.database().reference()
    var inviteArray: [Invites] = []
    dbRef.child(firInvitesNode).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if snapshot.exists() {
            if let invitesDict = snapshot.value as? [String : AnyObject] {
                for key in invitesDict.keys {
                    let userid = invitesDict[key]?["userid"] as! String
                    let eventid = invitesDict[key]?["eventid"] as! String
                    let count = invitesDict[key]?["count"] as! String
                    let invite = Invites.init(eventID: eventid, userID: userid, count: Int(count)!)
                    inviteArray.append(invite)
                }
                completion(inviteArray)
            }
        }
        else {
            completion(nil)
        }
    })
}
