//
//  MyEventViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class MyEventViewController: UIViewController {

    @IBOutlet weak var Invite: UIButton!
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var EventName: UILabel!
    
    @IBOutlet weak var EventLocation: UILabel!
    
    @IBOutlet weak var EventDate: UILabel!
    

    var event: Event?
    var numAttending: String?
    var whoHasCheckedIn : [String]?
    var scanned : [String: [String]] = ["":[]]
    var attending : [String : [String]] = ["":[]]
    
    @IBAction func SeeWhosComingButton(_ sender: Any) {
        performSegue(withIdentifier: "myEventToWhosComing", sender: nil)
    }
    
    @IBAction func inviteButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "myEventToChooseInvites", sender: self)
    }
    
    @IBAction func ScanCodesButton(_ sender: Any) {
        self.performSegue(withIdentifier: "myEventToCamera", sender: self)
    }
    
    @IBAction func unwindToMyEvent(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for e in events["Current Events"]! {
            if e.eventId == event?.eventId {
                EventName.text = "Name: " + e.name
                EventLocation.text = "Location: " + e.location
                EventDate.text = "Date and Time: " + eventDateToString(eventDate: e.date)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "myEventToWhosComing" {
                if let dest = segue.destination as? WhosComingViewController {
                    dest.eventId = event?.eventId
                    //dest.whoHasCheckedIn = whoHasCheckedIn
                    if (!attending.keys.contains((event?.eventId)!)) {
                        attending[(event?.eventId)!] = [String]()
                        
                    }
                    dest.scanned = scanned
                    dest.allInvited = attending
                }
            }
            else if identifier == "myEventToChooseInvites" {
                if let dest = segue.destination as? ChooseInvitesViewController {
                    dest.event = event
                    dest.users = users
                }
            }
            
//            else if identifier == "goToSettings" {
//                if let dest = segue.destination as? SettingsViewController {
//                    // do stuff in the settingsVC before it loads
//                }
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
}
