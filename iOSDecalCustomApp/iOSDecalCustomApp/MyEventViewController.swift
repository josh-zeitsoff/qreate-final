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
    
    @IBAction func SeeWhosComingButton(_ sender: Any) {
        performSegue(withIdentifier: "myEventToWhosComing", sender: nil)
    }
    
    @IBAction func inviteButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "myEventToChooseInvites", sender: self)
    }
    @IBOutlet weak var FractionAttending: UILabel!
    @IBAction func ScanCodesButton(_ sender: Any) {
        performSegue(withIdentifier: "myEventToCamera", sender: nil)
    }
    
    @IBAction func unwindToMyEvent(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for e in events["Current Events"]! {
            if e.eventId == event?.eventId {
                EventName.text = e.name
                EventLocation.text = e.location
                EventDate.text = e.date
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
