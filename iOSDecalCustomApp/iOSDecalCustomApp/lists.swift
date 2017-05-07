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
var inviteIDs : [String] = []
var users: [User]?

/*
func updateInvites() {
    let dbRef = FIRDatabase.database().reference()
    var count = 0
    var dict: [String:[String:AnyObject]]?
    for inv in invites {
        dict = [count.description:[
            "username": inv.username as AnyObject,
            "eventid": inv.eventId as AnyObject,
            "count": inv.count as AnyObject
        ]]
        count += 1
    }
    dbRef.child(firInvitesNode).setValue(dict)
}
 */
 
func eventDateToString(eventDate: String) -> String {
    var dateComponent = DateComponents()
    //get month
    let monthIndex = eventDate.index(eventDate.startIndex, offsetBy: 2)
    let monthString = eventDate.substring(to: monthIndex)
    let month = Int(monthString)
 
    //get day
    let dayIndex1 = eventDate.index(eventDate.startIndex, offsetBy:3)
    let dayRest = eventDate.substring(from: dayIndex1)
    let dayIndex2 = dayRest.index(dayRest.startIndex, offsetBy: 2)
    let dayString = dayRest.substring(to: dayIndex2)
    let day = Int(dayString)

    //get year
    let yearIndex1 = eventDate.index(eventDate.startIndex, offsetBy:6)
    let yearRest = eventDate.substring(from: yearIndex1)
    let yearIndex2 = yearRest.index(yearRest.startIndex, offsetBy: 2)
    let yearString = yearRest.substring(to: yearIndex2)
    let year = Int("20" + yearString)

 
    dateComponent.month = month
    dateComponent.day = day
    dateComponent.year = year
    
    let dateDate = Calendar.current.date(from: dateComponent)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM dd, yyyy"
    let stringDate = dateFormatter.string(from: dateDate!)
    
    
    return stringDate
 
 
 
 
 }

func addEventToList(event: Event, user: CurrentUser) {
    if event.host == user.username {
        events["Current Events"]!.append(event)
    }
    for inv in invites {
        if inv.eventId == event.eventId {
            if inv.username == user.username {
                events["Invited To"]!.append(event)
            }
        }
    }
}

func clearAll() {
    events["Current Events"] = []
    events["Invited To"] = []
    invites = []
    users = []
}



func addUserToList(user: User) {
    users!.append(user)
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

 func addInvite(eventId: String, username: String, present: String) -> String{
    let dbRef = FIRDatabase.database().reference()
    let key = dbRef.child(firInvitesNode).childByAutoId().key
    let dict: [String:AnyObject] = [
        "username": username as AnyObject,
        "eventid": eventId as AnyObject,
        "present": present as AnyObject,
        "key": key as AnyObject
    ]
    dbRef.child(firInvitesNode).child(key).setValue(dict )
    inviteIDs.append(key)
    return key
}

func addUser(userid: String, username: String, email: String, password: String) {
    let dbRef = FIRDatabase.database().reference()
    
    let dict: [String:AnyObject] = [
        //"name": username as AnyObject
        //"userid": userid as AnyObject,
        //"username": username as AnyObject,
        "name": email as AnyObject,
        //"password" : password as AnyObject
    ]
    dbRef.child(firUsersNode).childByAutoId().setValue(dict)
}

func getInvites(completion: @escaping ([Invites]?) -> Void) {
    let dbRef = FIRDatabase.database().reference()
    var inviteArray: [Invites] = []
    dbRef.child(firInvitesNode).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if snapshot.exists() {
            if let invitesDict = snapshot.value as? [String : AnyObject] {
                for key in invitesDict.keys {
                    let userid = invitesDict[key]?["username"] as! String
                    let eventid = invitesDict[key]?["eventid"] as! String
                    let present = invitesDict[key]?["present"] as! String
                    let key = invitesDict[key]?["key"] as! String
                    let invite = Invites.init(eventID: eventid, userID: userid, present: present, key: key)
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




func getUsers(completion: @escaping ([User]?) -> Void) {
    let dbRef = FIRDatabase.database().reference()
    var users: [User] = []
    dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if snapshot.exists() {
            if let usersDict = snapshot.value as? [String : AnyObject] {
                for key in usersDict.keys {
                    
                    //let q = usersDict[key]?["q"] as! String
                    let name = usersDict[key]?["name"] as! String
                    let user = User.init(name: name)
                    
                    users.append(user)
                    userDict[name] = user
                }
                completion(users)
            }
            else {
            completion(nil)
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
