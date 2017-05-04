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
var events: [String: [Event]] = ["Current Events": [], "Invited To": []]
//
let eventTypes = ["Current Events", "Invited To"]
var userDict : [String: User] = [:]
var invites : [Invites] = []

var users: [User] = []


func updateInvites() {
    let dbRef = FIRDatabase.database().reference()
    var count = 0
    for inv in invites {
        let dict: [String:[String:AnyObject]] = [count.description:[
            "userid": inv.userId as AnyObject,
            "eventid": inv.eventId as AnyObject,
            "count": inv.count as AnyObject
        ]]
        count += 1
    }
    dbRef.child(firInvitesNode).setValue([:])
}

func addEventToList(event: Event, user: CurrentUser) {
    if event.host == user.username {
        events["Current Events"]!.append(event)
    }
    else {
        events["Invited To"]!.append(event)
    }
    
}

func clearAll() {
    events["Current Events"] = []
    events["Invited To"] = []
    invites = []
    users = []
}



func addUserToList(user: User) {
    users.append(user)
}

func addInviteToList(invite: Invites) {
    invites.append(invite)
}

func getEventFromIndexPath(indexPath: IndexPath) -> Event? {
    let eventType = eventTypes[indexPath.section]
    if let currOrInvite = events[eventType] {
        return currOrInvite[indexPath.row]
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

func addInvite(eventId: String, userId: String, count: Int) {
    let dbRef = FIRDatabase.database().reference()
    let dict: [String:AnyObject] = [
        "userid": userId as AnyObject,
        "eventid": eventId as AnyObject,
        "count": count as AnyObject
    ]
    dbRef.child(firInvitesNode).childByAutoId().setValue(dict)
}

func getInvites(completion: @escaping ([Invites]?) -> Void) {
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
                }
                completion(inviteArray)
            }
            else {
                completion(nil)
            }
        })
}


func getUserInvites(user: CurrentUser, completion: @escaping ([Invites]?) -> Void) {
    let dbRef = FIRDatabase.database().reference()
    var inviteArray: [Invites] = []
    dbRef.child(firInvitesNode).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if snapshot.exists() {
            if let invitesDict = snapshot.value as? [String : AnyObject] {
                for key in invitesDict.keys {
                    let userid = invitesDict[key]?["userid"] as! String
                    if (userid == user.id) {
                        let eventid = invitesDict[key]?["eventid"] as! String
                        let count = invitesDict[key]?["count"] as! String
                        let invite = Invites.init(eventID: eventid, userID: userid, count: Int(count)!)
                        inviteArray.append(invite)
                    }
                }
                completion(inviteArray)
            }
        }
        else {
            completion(nil)
        }
    })
}

func getUsers(completion: @escaping ([User]?) -> Void) {
    let dbRef = FIRDatabase.database().reference()
    var users: [User] = []
    dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if snapshot.exists() {
            if let usersDict = snapshot.value as? [String : AnyObject] {
                for key in usersDict.keys {
                    
                    let q = usersDict[key]?["q"] as! String
                    let host = usersDict[key]?["host"] as! [String]
                    let name = usersDict[key]?["name"] as! String
                    let user = User.init(q: q, host: host, name: name)
                    
                    users.append(user)
                    userDict[name] = user
                }
                completion(users)
            }
        }
        else {
            completion(nil)
        }
    })
}

func addEvent(dateString: String, host: String, location: String, name: String, id: String) {
    let dbRef = FIRDatabase.database().reference()
    let dict: [String:AnyObject] = [
        "date": dateString as AnyObject,
        "host": host as AnyObject,
        "location": location as AnyObject,
        "name": name as AnyObject,
        "eventid": id as AnyObject
    ]
    dbRef.child(firEventsNode).childByAutoId().setValue(dict)
}
//(dateString: String, host: String, location: String, name: String, id: String)
//Arguments may need changing
func getEvents(user: CurrentUser, completion: @escaping ([Event]?) -> Void) {
    let dbRef = FIRDatabase.database().reference()
    var eventArray: [Event] = []
    dbRef.child(firEventsNode).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if snapshot.exists() {
            if let eventsDict = snapshot.value as? [String : AnyObject] {
                for key in eventsDict.keys {
                    let eventid = eventsDict[key]?["eventid"] as! String
                    let date = eventsDict[key]?["date"] as! String
                    let host = eventsDict[key]?["host"] as! String
                    let location = eventsDict[key]?["location"] as! String
                    let name = eventsDict[key]?["name"] as! String
                    let event = Event(dateString: date, host: host, location: location, name: name, id: eventid)
                    eventArray.append(event)
                    //Modify for Event object's children
                }
                completion(eventArray)
            }
            else {
            completion(nil)}
        }
        else {
            completion(nil)
        }
    })
}
