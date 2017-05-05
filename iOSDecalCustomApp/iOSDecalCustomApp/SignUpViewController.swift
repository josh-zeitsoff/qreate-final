//
//  SignUpViewController.swift
//  iOSDecalCustomApp
//
//  Created by Cathy Pham Le on 4/4/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var EmailInput: UITextField!
    
    @IBOutlet weak var UserNameSignUpInput: UITextField!
    
    @IBOutlet weak var PasswordSignUpInput: UITextField!

    @IBOutlet weak var FirstNameInput: UITextField!
    
    @IBOutlet weak var LastNameInput: UITextField!
    

    @IBAction func BackButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        if EmailInput.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.createUser(withEmail: (EmailInput.text!), password: (PasswordSignUpInput?.text!)!) { (user, error) in
                if error == nil {
                    addUser(userid: (user?.uid)!, username: self.UserNameSignUpInput!.text!, email: self.EmailInput!.text!, password: self.PasswordSignUpInput!.text!)
                    let changeRequest = user!.profileChangeRequest()
                    changeRequest.displayName = self.UserNameSignUpInput?.text
                    changeRequest.commitChanges(completion: {
                    (err) in
                        if let err = err {
                        print(err)}
                        else {
                         self.performSegue(withIdentifier: "unwindToLogin", sender: self)
                        }
                    })
                    
                    //print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UserNameSignUpInput?.autocorrectionType = .no
        PasswordSignUpInput?.autocorrectionType = .no
        PasswordSignUpInput?.isSecureTextEntry = true
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
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
