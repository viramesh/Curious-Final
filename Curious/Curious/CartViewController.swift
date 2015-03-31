//
//  CartViewController.swift
//  Curious
//
//  Created by Anuj Verma on 3/29/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }

    
    @IBOutlet weak var backgroundGreenView: UIView!
    @IBOutlet weak var cartMainImage: UIImageView!
    @IBOutlet weak var cartTitleLabel: UILabel!
    @IBOutlet weak var cartPriceLabel: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageHeight.constant = self.view.frame.height * 0.4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(0.4, animations: { () -> Void in
//            self.backgroundGreenView.frame = CGRect(x: 0, y: self.view.frame.height - self.cartMainImage.frame.height, width: self.view.frame.width, height: self.view.frame.height - self.cartMainImage.frame.height)
//            
//            }) { (Bool) -> Void in
//                //
//        }
//    }
    
    
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
            self.backgroundGreenView.frame = buttonFromDetail.frame
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
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
