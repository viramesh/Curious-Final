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

    var kits: [PFObject]! = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        // Do any additional setup after loading the view.
        getKits()
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
            parentVC.hideOverlay()
            parentVC.setupUserLoggedOut()
            println("logged out")
            
        }
    }
    
    @IBAction func didPressCheckout(sender: AnyObject) {
        var parentVC = self.parentViewController as HomeViewController
        parentVC.showCheckout()
    }
    
    func getKits(){
        var query = PFQuery(className: "Kit")
        query.whereKey("user", equalTo: PFUser.currentUser().username)
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            //
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        var quantityAmount: AnyObject! = object.objectForKey("quantity")
                        println(quantityAmount)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
    }
    

    
}
