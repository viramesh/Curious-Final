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
                var parentVC = self.parentViewController as HomeViewController
                parentVC.hideOverlay()
                parentVC.isUserLoggedIn()
            } else if error.code == 101 {
                println(error.description)
                var alertView = UIAlertView(title: "Try again!", message: "Username or password is incorrect.", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
    }
    
    
    @IBAction func signUpBtnDidPress(sender: AnyObject) {
        
        var user = PFUser()
        user.username = inputUsername.text
        user.password = inputPassword.text
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            
            if success {
                var parentVC = self.parentViewController as HomeViewController
                parentVC.hideOverlay()
                println("finished hiding")
            } else if error.code == 202 {
                var alertView = UIAlertView(title: "Username taken!", message: "Please try another one", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            } else if error.code == 200 {
                var alertView = UIAlertView(title: "No Username", message: "Please enter in a username", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
        
    }
    
    @IBAction func forgotPasswordBtnDidPress(sender: AnyObject) {
    }
    
    
}
