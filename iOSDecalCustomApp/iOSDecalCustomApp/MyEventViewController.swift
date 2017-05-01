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
    
    @IBOutlet weak var EventTime: UILabel!
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
