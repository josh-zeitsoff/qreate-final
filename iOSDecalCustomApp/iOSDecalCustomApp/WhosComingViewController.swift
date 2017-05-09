//
//  WhosComingViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class WhosComingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var eventId : String?

    var attending : [User]?
    
    var peopleHere: [Bool]?
    
    var whoHasCheckedIn : [String]?
    
    var scanned : [String: [String]]?
    
    var allInvited : [String: [String]]?
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var WhosComingTableView: UITableView!

    @IBAction func backButtonPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "unwindToMyEvent", sender: self)
    }
    
    override func viewDidLoad() {
            
        super.viewDidLoad()
        WhosComingTableView.dataSource = self
        WhosComingTableView.delegate = self
        WhosComingTableView.allowsSelection = false
        attending = [User]()
        peopleHere = [Bool]()

        // Do any additional setup after loading the view.
        //invites is an array of invites to be defined in lists.swift
        getInvites(completion: { (inviteObj) in
            invites = inviteObj!
        })
        
        for inv in invites {
            if (inv.eventId == self.eventId!) {
                //users is a map String -> User where the string is the userid
                if (!(allInvited?[inv.eventId]?.contains(inv.username))!) {
                    allInvited?[inv.eventId]?.append(inv.username)
                }
                if inv.present == "true" {
                    peopleHere?.append(true)
                }
                else {
                    peopleHere?.append(false)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WhosComingTableView.dequeueReusableCell(withIdentifier: "whosComingTableViewCell") as! WhosComingTableViewCell
        if (scanned?.keys.contains(eventId!))! {
            if scanned?[eventId!] != nil {
                if (scanned?[eventId!]?.contains((allInvited?[eventId!]?[indexPath.row])!))! {
                    cell.checkmark.text = "\u{2714}"
                }
                else {
                    cell.checkmark.text = "\u{25EF}"
                }
            }
        }
        else {
            cell.checkmark.text = "\u{25EF}"
        }
        cell.name.text = allInvited?[self.eventId!]![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allInvited?[self.eventId!]!.count)!
    }
    
}
