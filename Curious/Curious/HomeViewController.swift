//
//  HomeViewController.swift
//  Curious
//
//  Created by viramesh on 3/26/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning  {
    
    @IBOutlet weak var projectsTableView: UITableView!

    //Login Screen stuff
    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var loginContents: UIView!
    @IBOutlet weak var loginButtons: UIView!
    @IBOutlet weak var loginContainerTop: NSLayoutConstraint!
    @IBOutlet weak var loginHideBtn: UIButton!
    var loginHeight:CGFloat! = 50
    var loginViewShown:Bool! = false
    var loginView:LoginViewController!
    var originalConstant:CGFloat!
    
    //Passing info over
    var movingImageView: UIImageView!
    var isPresenting: Bool = true
    var selectedImage: NSIndexPath!
    
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
        
        TOP_height = self.view.frame.height * 0.4
        newHeight = TOP_height
        newAlpha = TOP_alpha
        newScale = TOP_scale
        newLabelAlpha = TOP_label_alpha
        
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
        
        titles = ["OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT","OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT"]
        
        subLabels = ["Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use","Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light"]
        
        images = ["string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg"]
        
        selectedImage = NSIndexPath(forRow: 0, inSection: 0)
        
        //init login stuff
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        loginView = storyboard.instantiateViewControllerWithIdentifier("loginViewController") as LoginViewController
        
        loginHideBtn.alpha = 0
        loginButtons.alpha = 0
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "revealTable", userInfo: nil, repeats: false)

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func displayLoginViewController(content: UIViewController) {
        addChildViewController(content)
        self.loginContents.addSubview(content.view)
        self.loginContainer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        content.didMoveToParentViewController(self)
    }
    
    func hideLoginViewController(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    func revealTable() {
        loginContainerTop.constant = self.view.frame.height - loginHeight
        
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.loginContainer.layoutIfNeeded()
        }) { (Bool) -> Void in
            //
        }
        
        UIView.animateWithDuration(0.4, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.loginContainer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            self.loginButtons.alpha = 1
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
    
    @IBAction func loginBtnDidPress(sender: AnyObject) {
        showLogin()
    }
    
    @IBAction func loginHideBtnDidPress(sender: AnyObject) {
        hideLogin()
    }
    
    @IBAction func loginDidPan(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)

        if sender.state == UIGestureRecognizerState.Began {
            if (loginViewShown == true) {
                originalConstant = 0
            }
            else {
                originalConstant = self.view.frame.height - loginHeight
                displayLoginViewController(loginView)
            }
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            
            var newConstant:CGFloat = originalConstant + translation.y
            loginContainerTop.constant = newConstant
            loginContainer.layoutIfNeeded()
            
            var newScale = convertValue(Float(newConstant), 0, Float(self.view.frame.height - loginHeight), 0.9, 1.0)
            projectsTableView.transform = CGAffineTransformMakeScale(CGFloat(newScale), CGFloat(newScale))
            
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            if(velocity.y > 0) {
                hideLogin()
            }
            else {
                showLogin()
            }
        }
    }
    
    func showLogin() {
        displayLoginViewController(loginView)
        loginContainerTop.constant = 0
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.loginContainer.layoutIfNeeded()
            self.loginHideBtn.alpha = 1
            self.projectsTableView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }) { (Bool) -> Void in
                self.loginViewShown = true
        }
    }
    
    func hideLogin() {
        loginContainerTop.constant = self.view.frame.height - loginHeight
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.loginContainer.layoutIfNeeded()
            self.loginHideBtn.alpha = 0
            self.projectsTableView.transform = CGAffineTransformMakeScale(1.0,1.0)
            }) { (Bool) -> Void in
                self.loginViewShown = false
                self.hideLoginViewController(self.loginView)
        }
    }
}
