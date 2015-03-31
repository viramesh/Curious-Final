//
//  CartViewController.swift
//  Curious
//
//  Created by Anuj Verma on 3/29/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit
import Spring

class CartViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }

    
    var backgroundGreenView: UIView!
    @IBOutlet weak var cartMainImage: UIImageView!
    @IBOutlet weak var cartTitleLabel: SpringLabel!
    @IBOutlet weak var cartQuantityButton: SpringButton!
    @IBOutlet weak var cartPriceLabel: SpringLabel!
    @IBOutlet weak var cartItemsTextView: UITextView!
    @IBOutlet weak var addCartButton: SpringButton!

    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageHeight.constant = self.view.frame.height * 0.4
        cartTitleLabel.alpha = 0
        cartPriceLabel.alpha = 0
        cartQuantityButton.alpha = 0
        addCartButton.alpha = 0
        cartItemsTextView.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.backgroundGreenView.frame = CGRect(x: 0, y: self.cartMainImage.frame.height, width: self.view.frame.width, height: self.view.frame.height - self.cartMainImage.frame.height)
            
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(1.0, delay: 0.4, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.cartTitleLabel.alpha = 1
            self.cartTitleLabel.textColor = UIColor.whiteColor()
           
            self.cartPriceLabel.alpha = 1
            self.cartQuantityButton.alpha = 1
            self.cartItemsTextView.alpha = 1
            self.cartItemsTextView.textColor = UIColor.whiteColor()


        }, completion: nil)
        
        
        self.cartPriceLabel.textColor = UIColor.whiteColor()
        self.cartPriceLabel.animation = "pop"
        self.cartPriceLabel.delay = 0.5
        self.cartPriceLabel.force = 2.0
        self.cartPriceLabel.duration = 1.0
        self.cartPriceLabel.curve = "linear"
        self.cartPriceLabel.animate()
        
        self.cartQuantityButton.animation = "pop"
        self.cartQuantityButton.delay = 0.5
        self.cartQuantityButton.force = 2.0
        self.cartQuantityButton.duration = 1.0
        self.cartQuantityButton.curve = "linear"
        self.cartQuantityButton.animate()
        
        self.addCartButton.alpha = 1
        self.addCartButton.animation = "fadeInUp"
        self.addCartButton.delay = 0.2
        self.addCartButton.duration = 0.7
        self.addCartButton.damping = 0.5
        self.addCartButton.curve = "easeOut"
        self.addCartButton.animate()
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
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            
            var detailVC = fromViewController as DetailViewController
            var imageFromDetail = detailVC.carouselImageView
            self.cartMainImage.image = imageFromDetail.image

            var titleFromDetail = detailVC.detailTitle
            self.cartTitleLabel.text = titleFromDetail
            
            var buttonFromDetail = detailVC.buyButton
            self.backgroundGreenView = UIView()
            self.backgroundGreenView.frame = detailVC.details.convertRect(buttonFromDetail.frame, toView: detailVC.details.superview)
            self.backgroundGreenView.backgroundColor = UIColor(red: 26/255, green: 205/255, blue: 192/255, alpha: 1)
            self.view.insertSubview(backgroundGreenView, atIndex: 0)
            

            println("Frame of new green view \(self.backgroundGreenView.frame)")
            println("Frame of detail button \(detailVC.buyButton.frame)")
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
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
    

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
