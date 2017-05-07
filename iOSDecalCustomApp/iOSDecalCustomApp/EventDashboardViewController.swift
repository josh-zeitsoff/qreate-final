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
    var passingEvent : Event?
    var passingImage : UIImage?
    var refreshControl = UIRefreshControl()
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EventDashboardTableView.delegate = self
        EventDashboardTableView.dataSource = self
        EventDashboardTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(EventDashboardViewController.refreshData(sender:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching events ...")
        refreshControl.tintColor = UIColor(red:0.50, green: 0.30, blue:0.40, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    
    func refreshData(sender: Any) {
        updateData()
        self.refreshControl.endRefreshing()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData() {
        //clears events, invites, and users lists
        clearAll()
        
        //add all users to user list
        
        getUsers(completion: {
            (usersArray) in
            if usersArray != nil {
                for user in usersArray! {
                    addUserToList(user: user)
                }
                self.EventDashboardTableView.reloadData()
            }
        })
        
        //adds all invites to the invites list
        getInvites(completion: {
            (inviteArray) in
            if (inviteArray != nil) {
                for invite in inviteArray! {
                    addInviteToList(invite: invite)
                }
                self.EventDashboardTableView.reloadData()
            }
        })
        
        //adds all events to events list
        getEvents(user: currentUser, completion: {
        (eventsArray) in
            if (eventsArray != nil) {
                for event in eventsArray! {
                    addEventToList(event: event, user: self.currentUser)
                }
                self.EventDashboardTableView.reloadData()
            }
        })
        
        

        
        
        
        
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
            cell.EventDate.text = eventDateToString(eventDate: event.date) 
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let event = getEventFromIndexPath(indexPath: indexPath) {
            let eventType = eventTypes[indexPath.section]
            passingEvent = event
            if eventType == "Current Events" {
                
//                let dest = MyEventViewController()
//                dest.event = event
                performSegue(withIdentifier: "dashToMyEvent", sender: self)
            } else if eventType == "Invited To" {
                //todo?
                let username = currentUser.username
                let eid = event.eventId
                var qrCode = QRCode(eid + " " + username!)
                //print(uid!)
                qrCode?.color = CIColor.black()
                qrCode?.size = CGSize(width: 300, height: 300)
                //let dest = AttendingEventViewController()
                passingImage = qrCode?.image
                performSegue(withIdentifier: "dashToQREvent", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "dashToMyEvent" {
                if let dest = segue.destination as? MyEventViewController {
                    dest.event = passingEvent
                }
            }
            else if identifier == "dashToQREvent" {
                if let dest = segue.destination as? AttendingEventViewController {
                    //print("xgop")
                    dest.event = passingEvent
                    dest.image = passingImage!
                }
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
