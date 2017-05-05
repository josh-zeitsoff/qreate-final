//
//  CreateEventViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/4/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class CreateEventViewController: UIViewController {

    @IBAction func backButton(_ sender: Any) {
        //self.performSegue(withIdentifier: "unwindToDash", sender: self)
    }
    
    var dateChanged = false
  
    let currentUser = CurrentUser()
    
    var date: String?
    
    @IBOutlet weak var EventDateAndTimePicker: UIDatePicker!
    
    @IBOutlet weak var EventNameInput: UITextField!
    
    @IBOutlet weak var EventLocationInput: UITextField!
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        dateChanged = true
        print("entered")
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        var strDate = dateFormatter.string(from: (EventDateAndTimePicker?.date)!)
        print(strDate)
        self.date = strDate
    }
    
    @IBAction func CreateEventButton(_ sender: UIButton) {
        if !dateChanged {
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            var strDate = dateFormatter.string(from: (EventDateAndTimePicker?.date)!)
            self.date = strDate

        }
        func randomString(length: Int) -> String {

            let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let len = UInt32(letters.length)
            
            var randomString = ""
            
            for _ in 0 ..< length {
                let rand = arc4random_uniform(len)
                var nextChar = letters.character(at: Int(rand))
                randomString += NSString(characters: &nextChar, length: 1) as String
            }
            
            return randomString
        }
        let id = randomString(length: 6)
        
        
        addEvent(dateString: date!, host: currentUser.username, location: EventLocationInput!.text!, name: EventNameInput!.text!, id: id)
        //self.performSegue(withIdentifier: "unwindToDash", sender: self)
        
        // Create event and send data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
