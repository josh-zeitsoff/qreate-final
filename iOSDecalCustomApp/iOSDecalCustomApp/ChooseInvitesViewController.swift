//
//  ChooseInvitesViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class ChooseInvitesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users : [User]?
    //var toAttend = Set<String>()
    var event : Event?
   // var allInvited : [String: [String]] = ["":[]]
    var toInvite = [String]()
    
    @IBOutlet weak var ChooseInvitesTableView: UITableView!
    
    @IBAction func invitePressed(_ sender: UIButton) {
        for person in toInvite {
            let key = addInvite(eventId: (self.event?.eventId)!, username: person, present: "false")
            invites.append(Invites.init(eventID: (self.event?.eventId)!, userID: person, present: "false", key: key))
        }
        
        //toAttend stuff
        //self.performSegue(withIdentifier: "unwindToMyEvent", sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        //self.performSegue(withIdentifier: "unwindToMyEvent", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChooseInvitesTableView.delegate = self
        ChooseInvitesTableView.dataSource = self
        //allInvited is nil initially
//        if allInvited != nil {
//            if (!(allInvited.keys.contains((self.event?.eventId)!))) {
//                allInvited[(self.event?.eventId)!] = [String]()
//            }
//        } else {
//        allInvited[(self.event?.eventId)!]! = [String]()
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChooseInvitesTableView.dequeueReusableCell(withIdentifier: "chooseInviteesCell") as! ChooseInvitesTableViewCell
        cell.InviteeUsername.text = users?[indexPath.row].username
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name : String = (users?[indexPath.row].username)!
        if let cell = tableView.cellForRow(at: indexPath) {
//            if cell.isSelected {
//                cell.accessoryType = .checkmark
//            }
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                var found = false
                for inv in invites {
                    if (inv.eventId == event?.eventId && inv.username == name) {
                        found = true
                        break
                    }
                }
                if !found {
                    toInvite.append((users?[indexPath.row].username!)!)
                }
            }
            else {
                cell.accessoryType = .none
                if toInvite.contains(name) {
                    if let index = toInvite.index(of : name) {
                        toInvite.remove(at: index)
                    }
                }
            }
        }
        
        
        
        
        /*
        if (!(allInvited[(self.event?.eventId)!]?.contains(name))!) {
            allInvited[(self.event?.eventId)!]!.append(name)
            addInvite(eventId: (self.event?.eventId)!, username: (users?[indexPath.row].username!)!, present: "false")
            invites.append(Invites.init(eventID: (self.event?.eventId)!, userID: (users?[indexPath.row].username!)!, present: "false"))
        }
 */
        //toAttend.insert((users?[indexPath.row].username)!)
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
