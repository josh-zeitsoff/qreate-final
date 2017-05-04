//
//  ChooseInvitesViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class ChooseInvitesViewController: UIViewController {
    var users : [User] = []

    @IBOutlet weak var ChooseInvitesTableView: UITableView!
    
    @IBAction func invitePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToMyEvent", sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMyEvent", sender: self)
    }
    
    @IBOutlet weak var InviteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUsers(completion: { (users : [User]?) -> Void in
            self.users = users!
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WhosComingTableView.dequeueReusableCell(withIdentifier: "chooseThreadCell") as! WhosComingTableViewCell
        cell.AttendeeName.text =
        cell.AttendeeUsername.text =
        return kill
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.length
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //chosenThreadLabel.text = threadNames[indexPath.row]
    }

    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
