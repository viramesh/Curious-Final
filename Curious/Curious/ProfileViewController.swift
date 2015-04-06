//
//  ProfileViewController.swift
//  Curious
//
//  Created by viramesh on 4/3/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var kits: [PFObject]! = []

    @IBOutlet weak var noKitsMessageView: UIView!
    @IBOutlet weak var kitsCheckoutContainerView: UIView!
    @IBOutlet weak var kitsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background to transparent so the blur effect is visible
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        //init nokits message to alpha 0
        noKitsMessageView.alpha = 0
        
        //init table view
        kitsTableView.dataSource = self
        kitsTableView.delegate = self
        
        //get kits and initialize table
        getKits()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(kits.count == 0) {
            noKitsMessageView.alpha = 1
            kitsCheckoutContainerView.alpha = 0
        }
        else {
            noKitsMessageView.alpha = 0
            kitsCheckoutContainerView.alpha = 1
        }
        println("kits count \(kits.count)")
        
        return kits.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("KitsTableViewCell") as KitsTableViewCell
        
        cell.kitImage.image = UIImage(named: "string-22")
        cell.kitNameLabel.text = "OK String"
        cell.kitQtyLabel.text = "1"
        cell.kitPriceLabel.text = "$8.99"
        
        println("cell created")
        
        return cell
    }


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
                    self.kits = objects
                    for object in objects {
                        var quantityAmount: AnyObject! = object.objectForKey("quantity")
                        println(quantityAmount)
                    }
                self.kitsTableView.reloadData()
                }
                
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
    }
    

    
}
