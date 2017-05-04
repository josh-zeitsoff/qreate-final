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
   
    @IBAction func backButton(_ sender: UIButton) {
        updateInvites()
        self.performSegue(withIdentifier: "unwindToMyEvent", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = MTBBarcodeScanner(previewView: previewView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            try self.scanner?.startScanning(resultBlock: { codes in
                if let codes = codes {
                    for code in codes {
                        let stringValue = code.stringValue!
                        print("Found code: \(stringValue)")
                        for inv in invites {
                            if (inv.eventId == stringValue) {
                                print("success")
                                inv.count = inv.count + 1
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
}
