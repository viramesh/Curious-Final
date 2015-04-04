//
//  ProfileViewController.swift
//  Curious
//
//  Created by viramesh on 4/3/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didPressLogout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error:NSError!) -> Void in
            var parentVC = self.parentViewController as HomeViewController
            parentVC.hideLogin()
            println("User logged out")
            
        }
    }
    
}
