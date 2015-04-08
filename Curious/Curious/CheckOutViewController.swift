//
//  CheckOutViewController.swift
//  Curious
//
//  Created by viramesh on 4/5/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit
import CoreLocation
import Spring

class CheckOutViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    @IBOutlet weak var currentLocationCheckboxImageView: UIImageView!
    @IBOutlet weak var sendToMeButton: SpringButton!
    @IBOutlet weak var checkoutBagButton: UIButton!
    
    var usingCurrentLocationAsShippingAddress:Bool = false
    
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendToMeButton.alpha = 0
        
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
        
        
        if firstNameField.text.isEmpty {
            println("is empty")
        } else {
            println("is not empty")
            lastNameField.text = "Hi"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentLocation() {
        //getting current location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        //println("Updating location...")
        //--- CLGeocode to get address of current location ---//
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0
            {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            }
            else
            {
                println("Problem with the data received from geocoder")
            }
        })
        
    }
    
    
    func displayLocationInfo(placemark: CLPlacemark?)
    {
        if let containsPlacemark = placemark
        {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let street = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""
            let city = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let zipcode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let state = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""

            streetAddressField.text = street
            cityField.text = city
            stateField.text = state
            zipcodeField.text = zipcode
        }
        
    }
    @IBAction func didTapScreen(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        println("Error while updating location " + error.localizedDescription)
    }

    @IBAction func useCurrentLocationAsShippingAddress(sender: UITapGestureRecognizer) {
        if(!usingCurrentLocationAsShippingAddress) {
            getCurrentLocation()
            currentLocationCheckboxImageView.image = UIImage(named: "currentlocation-filled")
            usingCurrentLocationAsShippingAddress = true
        }
        else {
            currentLocationCheckboxImageView.image = UIImage(named: "currentlocation")
            usingCurrentLocationAsShippingAddress = false
        }
        
    }
    @IBAction func didStartEditing(sender: AnyObject) {
        if  firstNameField.text.isEmpty ||
            lastNameField.text.isEmpty ||
            streetAddressField.text.isEmpty ||
            cityField.text.isEmpty ||
            stateField.text.isEmpty ||
            zipcodeField.text.isEmpty {
            println("Is empty")
        } else {
            println("Is not empty")
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.sendToMeButton.alpha = 1
                self.checkoutBagButton.imageView?.image = UIImage(named: "Check out bag-filled")

            })
        }
        
    }

}
