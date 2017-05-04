//
//  CreateEventViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/4/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class CreateEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToDash", sender: self)
    }
    
    @IBOutlet weak var EventNameInput: UITextField!
    
    
    @IBOutlet weak var EventLocationInput: UITextField!
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
    }

    
    @IBAction func CreateEventButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToDash", sender: self)
        // Create event and send data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return pList[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let p = pList[section]
        return people[p]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseInviteesCell", for: indexPath) as! ChooseInvitesTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let invitee = getPerson(indexPath: indexPath) {
            performSegue(withIdentifier: "createEventToInvite", sender: self)
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
