//
//  CheckOutViewController.swift
//  Curious
//
//  Created by viramesh on 4/5/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        firstNameField.attributedPlaceholder = NSAttributedString(string:"First name",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)])

        lastNameField.attributedPlaceholder = NSAttributedString(string:"Last name",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)])

        streetAddressField.attributedPlaceholder = NSAttributedString(string:"Shipping address",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)])

        cityField.attributedPlaceholder = NSAttributedString(string:"City",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)])

        stateField.attributedPlaceholder = NSAttributedString(string:"State",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)])

        zipcodeField.attributedPlaceholder = NSAttributedString(string:"Zip code",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)])

        
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

}
