//
//  QuantityViewController.swift
//  Curious
//
//  Created by Anuj Verma on 3/31/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit
import Spring

protocol QuantityNumberDelegate{
    
    func quantityAmount(info:NSString)
    
}

class QuantityViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }

    @IBOutlet weak var backgroundBlackView: UIView!
    @IBOutlet weak var quantityOneButton: SpringButton!
    @IBOutlet weak var quantityTwoButton: SpringButton!
    @IBOutlet weak var quantityThreeButton: SpringButton!
    @IBOutlet weak var quantityFourButton: SpringButton!
    @IBOutlet weak var quantityFiveButton: SpringButton!
    @IBOutlet weak var quantitySixButton: SpringButton!
    
    var delegate:QuantityNumberDelegate? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundBlackView.alpha = 0.8
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
    
    
    @IBAction func quantityButtonPressed(sender: AnyObject) {
        
        var btn = sender as SpringButton
        
        if (delegate != nil) {
            
            if btn.tag == 2 {
                let information: NSString = quantityTwoButton.titleLabel!.text!
                delegate!.quantityAmount(information)
                //            dismissViewControllerAnimated(true, completion: nil)
            } else if btn.tag == 3 {
                let information: NSString = quantityThreeButton.titleLabel!.text!
                delegate!.quantityAmount(information)
                //                dismissViewControllerAnimated(true, completion: nil)
            } else if btn.tag == 1 {
                let information: NSString = quantityOneButton.titleLabel!.text!
                delegate!.quantityAmount(information)
                //                dismissViewControllerAnimated(true, completion: nil)
            } else if btn.tag == 4 {
                let information: NSString = quantityFourButton.titleLabel!.text!
                delegate!.quantityAmount(information)
            } else if btn.tag == 5 {
                let information: NSString = quantityFiveButton.titleLabel!.text!
                delegate!.quantityAmount(information)
            } else if btn.tag == 6 {
                let information: NSString = quantitySixButton.titleLabel!.text!
                delegate!.quantityAmount(information)
            }
            
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    

    @IBAction func backgroundBlackViewTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
