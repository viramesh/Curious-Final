//
//  HomeViewController.swift
//  Curious
//
//  Created by viramesh on 3/26/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning  {
    
    @IBOutlet weak var projectsTableView: UITableView!

    //overlay view setup stuff
    @IBOutlet weak var overlayContainerView: UIVisualEffectView!
    @IBOutlet weak var overlayContainerViewTop: NSLayoutConstraint!
    @IBOutlet weak var overlayHeaderView: UIView!
    @IBOutlet weak var overlayContentsView: UIView!
    @IBOutlet weak var overlayHideButton: UIButton!
    @IBOutlet weak var overlayHeaderLabel: UILabel!
    
    //variables used to maintain current state
    var overlayHeaderHeight:CGFloat! = 50
    var overlayShown:Bool! = false
    var initialOverlayConstant:CGFloat! = 0
    var currentUser: PFUser!
    
    //overlay VC's stuff
    var loginVC:LoginViewController!
    var profileVC: ProfileViewController!
    var checkOutVC: CheckOutViewController!
    
    //Passing info over
    var movingImageView: UIImageView!
    var isPresenting: Bool = true
    var selectedImage: NSIndexPath!
    
    
    //table view stuff
    var titles = [String]()
    var subLabels = [String]()
    var images = [String]()
    var projectCell: ProjectCell!
    
    var topPhotoIndexRow:Int = 0
    
    var newHeight:CGFloat!
    var newAlpha:CGFloat!
    var newLabelAlpha:CGFloat!
    var newScale:CGFloat!
    
    var TOP_height:CGFloat! = 320
    var BOTTOM_height:CGFloat! = 120
    var TOP_alpha:CGFloat! = 0.2
    var BOTTOM_alpha:CGFloat! = 0.7
    var TOP_label_alpha:CGFloat! = 1.0
    var BOTTOM_label_alpha:CGFloat! = 0.4
    var TOP_scale:CGFloat! = 1.0
    var BOTTOM_scale:CGFloat! = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init user
        currentUser = PFUser()
        
        //init table view
        TOP_height = self.view.frame.height * 0.4
        newHeight = TOP_height
        newAlpha = TOP_alpha
        newScale = TOP_scale
        newLabelAlpha = TOP_label_alpha
        
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
        
        titles = ["OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "DYED TABLECLOTH", "TANGRAM MAGNETS", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT","OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT"]
        
        subLabels = ["Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Awesome custom tablecloth", "Easy and fun puzzle magnets", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use","Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light"]
        
        images = ["string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "tablecloth-37.jpg", "magnet-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg"]
        
        selectedImage = NSIndexPath(forRow: 0, inSection: 0)
        
        //init login stuff
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        loginVC = storyboard.instantiateViewControllerWithIdentifier("loginViewController") as LoginViewController
        
        checkOutVC = storyboard.instantiateViewControllerWithIdentifier("checkOutViewController") as CheckOutViewController
        
        profileVC = storyboard.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController
        
        overlayHideButton.alpha = 0
        overlayHeaderView.alpha = 0
        
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "revealTable", userInfo: nil, repeats: false)
        
        getKits()


    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func displayViewController(content: UIViewController) {
        addChildViewController(content)
        self.overlayContentsView.addSubview(content.view)
        self.overlayContainerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        content.didMoveToParentViewController(self)
    }
    
    func hideViewController(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    func revealTable() {
        //check if logged in and accordingly change label in overlay header
        if(isUserLoggedIn()) {
            setupUserLoggedIn()
        }
        
        overlayContainerViewTop.constant = self.view.frame.height - overlayHeaderHeight
        
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.overlayContainerView.layoutIfNeeded()
        }) { (Bool) -> Void in
            //
        }
        
        UIView.animateWithDuration(0.4, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.overlayContainerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            self.overlayHeaderView.alpha = 1
        }, completion: nil)
    }
    
    
    //Custom Transition
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as DetailViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        destinationVC.carouselImage = images[selectedImage.row]
        destinationVC.detailTitle = titles[selectedImage.row]
        destinationVC.detailSubLabel = subLabels[selectedImage.row]
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        movingImageView = UIImageView()
        movingImageView.image = UIImage(named: images[selectedImage.row])
        
        
        var rectInTableView: CGRect = projectsTableView.rectForRowAtIndexPath(selectedImage)
        var rectInSuperview: CGRect = projectsTableView.convertRect(rectInTableView, toView: projectsTableView.superview)
        movingImageView.frame = rectInSuperview
        movingImageView.contentMode = UIViewContentMode.ScaleAspectFill
        movingImageView.clipsToBounds = true
        
        var window = UIApplication.sharedApplication().keyWindow!
        
        if (isPresenting) {
            var destinationVC = toViewController as DetailViewController
            containerView.addSubview(toViewController.view)
            window.addSubview(movingImageView)
            toViewController.view.alpha = 0
            //println(images[selectedImage.row])
            var newFrame:CGRect = CGRectMake(destinationVC.carouselImageView.frame.origin.x, destinationVC.carouselImageView.frame.origin.y, self.view.frame.width, TOP_height)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                self.movingImageView.frame = newFrame

                }) { (finished: Bool) -> Void in
                    self.movingImageView.removeFromSuperview()
                    self.projectsTableView.reloadData()
                    transitionContext.completeTransition(true)
            }
            
            
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //println("\(indexPath.row)")
        selectedImage = indexPath
        
        performSegueWithIdentifier("detailSegue", sender: self)
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //println(indexPath.row)
        projectCell = tableView.dequeueReusableCellWithIdentifier("projectCellId") as ProjectCell
        //projectCell.projectImageView.frame = CGRectMake(0, 0, self.view.frame.width, TOP_height)
        projectCell.projectLabel.text = titles[indexPath.row]
        projectCell.projectSubLabel.text = subLabels[indexPath.row]
        var image = UIImage(named: images[indexPath.row])
        
        projectCell.projectImageView.image = image
        
        
        if(indexPath.row < topPhotoIndexRow) {
            projectCell.mask.alpha = TOP_alpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(TOP_scale, TOP_scale)
            projectCell.projectLabel.alpha = TOP_label_alpha
            projectCell.projectSubLabel.alpha = 1
            
        }
        else if(indexPath.row == topPhotoIndexRow) {
            projectCell.mask.alpha = newAlpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(newScale, newScale)
            projectCell.projectLabel.alpha = newLabelAlpha
            projectCell.projectSubLabel.alpha = (newHeight - BOTTOM_height) / (TOP_height - BOTTOM_height)
        }
        else {
            projectCell.mask.alpha = BOTTOM_alpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(BOTTOM_scale, BOTTOM_scale)
            projectCell.projectLabel.alpha = BOTTOM_label_alpha
            projectCell.projectSubLabel.alpha = 0
        }

        return projectCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return images.count
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var visiblePhotos = projectsTableView.indexPathsForVisibleRows() as [NSIndexPath]
        var rectInTableView: CGRect = projectsTableView.rectForRowAtIndexPath(visiblePhotos[1])
        var rectInSuperview: CGRect = projectsTableView.convertRect(rectInTableView, toView: projectsTableView.superview)
        
        newHeight = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, Float(TOP_height), Float(TOP_height), Float(BOTTOM_height)))
        newAlpha = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, Float(TOP_height), Float(self.TOP_alpha), Float(self.BOTTOM_alpha)))
        newLabelAlpha = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, Float(TOP_height), Float(self.TOP_label_alpha), Float(self.BOTTOM_label_alpha)))
        newScale = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, Float(TOP_height), Float(self.TOP_scale), Float(self.BOTTOM_scale)))
        topPhotoIndexRow = visiblePhotos[1].row
        
        projectsTableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row < topPhotoIndexRow) { return TOP_height }
        else if(indexPath.row == topPhotoIndexRow) { return newHeight }
        else { return BOTTOM_height }
    }
    
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var visiblePhotos = projectsTableView.indexPathsForVisibleRows() as [NSIndexPath]
        
        if(velocity.y <= 0) {
            var rectInTableView: CGRect = projectsTableView.rectForRowAtIndexPath(visiblePhotos[0])
            targetContentOffset.memory.y = rectInTableView.origin.y
            
        }
        else {
            var rectInTableView: CGRect = projectsTableView.rectForRowAtIndexPath(visiblePhotos[1])
            targetContentOffset.memory.y = rectInTableView.origin.y
            
        }
        
    }
    
    
    @IBAction func overlayHeaderDidTap(sender: AnyObject) {
        attachVCtoOverlay()
        showOverlay()
    }
    
    @IBAction func overlayHideButtonDidPress(sender: AnyObject) {
        if(!isUserLoggedIn()) {
            loginVC.inputUsername.resignFirstResponder()
            loginVC.inputPassword.resignFirstResponder()
        }
        hideOverlay()
    }
    
    
    @IBAction func overlayHeaderDidPan(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)

        if sender.state == UIGestureRecognizerState.Began {
            if (overlayShown == true) {
                initialOverlayConstant = 0
                if(!isUserLoggedIn()) {
                    loginVC.inputUsername.resignFirstResponder()
                    loginVC.inputPassword.resignFirstResponder()
                }
            }
            else {
                initialOverlayConstant = self.view.frame.height - overlayHeaderHeight
                attachVCtoOverlay()
            }
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            
            var newConstant:CGFloat = initialOverlayConstant + translation.y
            overlayContainerViewTop.constant = newConstant
            overlayContainerView.layoutIfNeeded()
            
            var newScale = convertValue(Float(newConstant), 0, Float(self.view.frame.height - overlayHeaderHeight), 0.9, 1.0)
            projectsTableView.transform = CGAffineTransformMakeScale(CGFloat(newScale), CGFloat(newScale))
            
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            if(velocity.y > 0) {
                hideOverlay()
            }
            else {
                showOverlay()
            }
        }
    }
    
    func attachVCtoOverlay() {
        if (isUserLoggedIn()) {
            // user is logged in
            displayViewController(profileVC)
            
        } else {
            //user is not logged in
            displayViewController(loginVC)
        }
    }
    
    func detachVCfromOverlay() {
        self.hideViewController(self.loginVC)
        self.hideViewController(self.profileVC)
        self.hideViewController(self.checkOutVC)
    }
    
    func showOverlay() {
        overlayContainerViewTop.constant = 0
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.overlayContainerView.layoutIfNeeded()
            self.overlayHideButton.alpha = 1
            self.overlayHeaderLabel.alpha = 0
            self.projectsTableView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }) { (Bool) -> Void in
                self.overlayShown = true
                if(!self.isUserLoggedIn()) {
                    self.loginVC.inputUsername.becomeFirstResponder()
                }
        }
    }
    
    func hideOverlay() {
        overlayContainerViewTop.constant = self.view.frame.height - overlayHeaderHeight
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.overlayContainerView.layoutIfNeeded()
            self.overlayHideButton.alpha = 0
            self.overlayHeaderLabel.alpha = 1
            self.projectsTableView.transform = CGAffineTransformMakeScale(1.0,1.0)
            }) { (Bool) -> Void in
                self.overlayShown = false
                self.detachVCfromOverlay()
        }
    }
    
    func setupUserLoggedIn() {
        overlayHeaderLabel.text = "Hello, \(PFUser.currentUser().username)"
        println("Hello, \(PFUser.currentUser().username)")
    }
    
    func setupUserLoggedOut() {
        overlayHeaderLabel.text = "Login"
    }
    
    
    func isUserLoggedIn() -> Bool {
        currentUser = PFUser.currentUser()
        if currentUser != nil {
            // user is logged in
            return true
        }
        
        else {
            //user is not logged in
            return false
        }
    }
    
    func showCheckout() {
        self.hideViewController(self.profileVC)
        self.displayViewController(self.checkOutVC)
        checkOutVC.getCurrentLocation()
    }
    
    
    func getKits(){
        if isUserLoggedIn() {
            var query = PFQuery(className: "Kit")
            query.whereKey("user", equalTo: PFUser.currentUser().username)
            query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
                //
                if error == nil {
                    // The find succeeded.
                    println("Successfully retrieved \(objects.count) scores.")
                    // Do something with the found objects
                
                    //use a local var to accumalate the total
                    var total: Int! = 0

                    if let objects = objects as? [PFObject] {
                        for object in objects {
                        
                            var quantityAmount: AnyObject! = object.objectForKey("quantity")
                            self.overlayHeaderLabel.text = "You have \(objects.count) items in your cart"
                        
                            //add to the total
                            total = total + String(quantityAmount as NSString).toInt()!
                        
                            println(quantityAmount)
                        
                        }
                    }
                
                    //now you have the final total to do what you want with it
                    println(total)
                
                }   else {
                // Log details of the failure
                    println("Error: \(error) \(error.userInfo!)")
                }
            }
        }
    }
}
