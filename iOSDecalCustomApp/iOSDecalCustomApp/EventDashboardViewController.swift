//
//  EventDashboardViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase
import QRCode
class EventDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var ref: FIRDatabaseReference!
//    var events: [FIRDataSnapshot]! = []
//    fileprivate var _refHandle: FirDatabaseHandle!

    @IBOutlet weak var EventDashboardTableView: UITableView!
    
    @IBAction func CreateEventButton(_ sender: Any) {
        performSegue(withIdentifier: "dashToCreateEvent", sender: nil)
    }
    
    let currentUser = CurrentUser()
    
    
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "dashToLogin", sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    @IBAction func unwindToDash(segue: UIStoryboardSegue) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        EventDashboardTableView.delegate = self
        EventDashboardTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData() {
        //clears events, invites, and users lists
        clearAll()
        
        //adds all events to events list
        getEvents(user: currentUser, completion: {
        (eventsArray) in
            for event in eventsArray! {
                addEventToList(event: event, user: self.currentUser)
            }
        })
        
        //adds all invites to the invites list
        getInvites(completion: {
            (inviteArray) in
            for invite in inviteArray! {
                addInviteToList(invite: invite)
            }
        })

        //add all users to user list
        getUsers(completion: {
            (usersArray) in
            for user in usersArray! {
                addUserToList(user: user)
            }
        })
        
        self.EventDashboardTableView.reloadData()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventTypes.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventTypes[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let deats = eventTypes[section]
        return events[deats]!.count
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashCell", for: indexPath) as! EventDashboardTableViewCell
        if let event = getEventFromIndexPath(indexPath: indexPath) {
            cell.EventName.text = event.name
            cell.EventDate.text = String(describing: event.date)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let event = getEventFromIndexPath(indexPath: indexPath) {
            let eventType = eventTypes[indexPath.section]
            if eventType == "Current Events" {
                let dest = MyEventViewController()
                dest.event = event
                performSegue(withIdentifier: "dashToMyEvent", sender: self)
            } else if eventType == "Invited To" {
                //todo?
                let uid = currentUser.id
                let eid = event.eventId
                let qrCode = QRCode(uid!)
                
                let dest = AttendingEventViewController()
                dest.MyQRCode.image = qrCode?.image
                performSegue(withIdentifier: "dashToQREvent", sender: self)
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
