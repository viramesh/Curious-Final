//
//  LoginViewController.swift
//  Curious
//
//  Created by viramesh on 3/27/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputUsername: UITextField!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        inputUsername.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)])
        
        inputPassword.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginBtnDidPress(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(inputUsername.text, password: inputPassword.text) { (user:PFUser!, error: NSError!) -> Void in
            //
            println("logged in")
            if user != nil {
            self.performSegueWithIdentifier("signInUpCompleteSegue", sender: self)
            } else {
                println(error.description)
            }
        }
    }
    
    
    @IBAction func signUpBtnDidPress(sender: AnyObject) {
        
        var user = PFUser()
        user.username = inputUsername.text
        user.password = inputPassword.text
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            
            if success {
                self.performSegueWithIdentifier("signInUpCompleteSegue", sender: self)
            } else {
                var alertView = UIAlertView(title: "Oops", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
        
    }
    
    @IBAction func forgotPasswordBtnDidPress(sender: AnyObject) {
    }
    
    
}
