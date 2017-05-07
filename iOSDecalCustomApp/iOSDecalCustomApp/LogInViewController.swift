//
//  ViewController.swift
//  iOSDecalCustomApp
//
//  Created by Cathy Pham Le on 4/4/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LogInViewController: UIViewController, GIDSignInUIDelegate {
    
    var handle: FIRAuthStateDidChangeListenerHandle?
    
    var emailPass : String?
    
    var passwordPass : String?

    @IBOutlet weak var EmailInput: UITextField!
    
    @IBOutlet weak var PasswordInput: UITextField!
    
    @IBAction func LoginButton(_ sender: Any) {
        if self.EmailInput.text == "" || self.PasswordInput.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.EmailInput.text!, password: self.PasswordInput.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    self.performSegue(withIdentifier: "loginToDash", sender: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        performSegue(withIdentifier: "loginToSignUp", sender: nil)
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if emailPass != nil && passwordPass != nil {
            PasswordInput.text = passwordPass!
            EmailInput.text = emailPass!
        } else {
            PasswordInput.text = ""
            EmailInput.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        PasswordInput.isSecureTextEntry = true
        PasswordInput.autocorrectionType = .no
        EmailInput.autocorrectionType = .no
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if user != nil {
                //self.performSegue(withIdentifier: "loginToDash", sender: nil)
            }
        }
        self.hideKeyboard()
        
        
    }
    
    //more Firebase
    deinit {
        if let handle = handle {
            FIRAuth.auth()?.removeStateDidChangeListener(handle)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
