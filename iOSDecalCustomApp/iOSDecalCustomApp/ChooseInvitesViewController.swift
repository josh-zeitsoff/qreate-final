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
    var toAttend = Set<String>()
    var event : Event?
    @IBOutlet weak var ChooseInvitesTableView: UITableView!
    
    @IBAction func invitePressed(_ sender: UIButton) {
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
        toAttend.insert((users?[indexPath.row].username)!)
        addInvite(eventId: (event?.eventId)!, username: (users?[indexPath.row].username!)!, present: "false")
        invites.append(Invites.init(eventID: (event?.eventId)!, userID: (users?[indexPath.row].username!)!, present: "false"))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
