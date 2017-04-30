//
//  EventDashboardViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class EventDashboardViewController: UIViewController, UITableViewDelegate {
//    var ref: FIRDatabaseReference!
//    var events: [FIRDataSnapshot]! = []
//    fileprivate var _refHandle: FirDatabaseHandle!

    @IBOutlet weak var EventDashboardTableView: UITableView!
    
    @IBAction func CreateEventButton(_ sender: Any) {
        performSegue(withIdentifier: "dashToCreateEvent", sender: nil)
    }
    
    
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
    
    //    deinit {
    //        if let refHandle = _refHandle {
    //            self.ref.child("events").removeObserver(withHandle: _refHandle)
    //        }
    //    }
    
    
    //    func configureDatabase() {
    //        ref = FIRDatabase.database().reference()
    //        // Listen for new messages in the Firebase database
    //        _refHandle = self.ref.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
    //            guard let strongSelf = self else { return }
    //            strongSelf.messages.append(snapshot)
    //            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
    //        })
    //    }
    //
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        // Dequeue cell
    //        let cell = EventDashboardTableView.dequeueReusableCell(withIdentifier: "EventDashboardTableViewCell", for: indexPath)
    //        // Unpack message from Firebase DataSnapshot
    //        let eventSnapshot = EventDashboardTableView.messages[indexPath.row]
    //        guard let event = eventSnapshot.value as? [String: String] else { return cell }
    //        let name = events[Constants.MessageFields.name] ?? ""
    //        let text = events[Constants.MessageFields.text] ?? ""
    //        cell.textLabel?.text = name + ": " + text
    //        cell.imageView?.image = UIImage(named: "ic_account_circle")
    //        if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL),
    //            let data = try? Data(contentsOf: URL) {
    //            cell.imageView?.image = UIImage(data: data)
    //        }
    //        return cell
    //    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        EventDashboardTableView.delegate = self
        //        EventDashboardTableView.source = self
        // Do any additional setup after loading the view.
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return eventTypes.count
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return eventTypes[section]
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let deats = eventTypes[section]
//        return events[deats]!.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "dashCell", for: indexPath) as! EventDashboardTableViewCell
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let deats = getEvent(indexPath: indexPath) {
//            let eventType = eventTypes[indexPath.section]
//            if eventType == "Current Events" {
//                performSegue(withIdentifier: "dashToMyEvent", sender: self)
//            } else if eventType == "Invited To" {
//                performSegue(withIdentifier: "dashToQREvent", sender: self)
//            }
//        }
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
