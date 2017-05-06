//
//  CodeScannerViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase
import MTBBarcodeScanner

class CodeScannervarwController: UIViewController {
    
    @IBOutlet var previewView: UIView!
    var scanner: MTBBarcodeScanner?
    var usersNamesOfPeopleThatAreHere : [String]?
    var eid: String?
    
    @IBOutlet weak var label: UILabel!
    @IBAction func backButton(_ sender: UIButton) {
        //updateInvites()
        //self.performSegue(withIdentifier: "backToEvent", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = MTBBarcodeScanner(previewView: self.previewView)
        self.usersNamesOfPeopleThatAreHere = [String]()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            try self.scanner?.startScanning(resultBlock: { codes in
                if let codes = codes {
                    for code in codes {
                        
                        let stringValue = code.stringValue!
                        let eventIndex = stringValue.index(stringValue.startIndex, offsetBy: 6)
                        let userIndex = stringValue.index(stringValue.userIndex, offsetBy: 7)
                        eid = stringValue.substring(to: eventIndex)
                        let username = str.substring(from: userIndex)
                        
                        for inv in invites {
                            if (inv.eventId == eid && inv.username == username && inv.present == "false") {
                                self.label.text = "Status: Success! " + inv.username
                                self.usersNamesOfPeopleThatAreHere?.append(inv.username)
                                inv.present = "true"
                                //tell database scanned
                            }
                        }
                    }
                }
            })
        } catch {
            NSLog("Unable to start scanning")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "unwindToMyEvent" {
                if let dest = segue.destination as? MyEventViewController {
                    dest.scanned[eid] += self.usersNamesOfPeopleThatAreHere
                    //dest.whoHasCheckedIn = self.usersNamesOfPeopleThatAreHere
                }
            }
        }
    }
}
