//
//  AttendingEventViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class AttendingEventViewController: UIViewController {
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToDash", sender: self)
    }
    
    @IBOutlet weak var AttendingEventName: UILabel!

    @IBOutlet weak var AttendingEventDate: UILabel!
    
    @IBOutlet weak var AttendingEventTime: UILabel!
    
    @IBOutlet weak var AttendingEventLocation: UILabel!
    
    @IBOutlet weak var AttendingEventHost: UILabel!
    
    var image : UIImage?
    
    @IBOutlet weak var MyQRCode: UIImageView?
    
    var event : Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MyQRCode?.image = image
        AttendingEventDate?.text = event?.date
        AttendingEventLocation?.text = event?.location
        AttendingEventName?.text = event?.name
        AttendingEventHost?.text = event?.host

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
