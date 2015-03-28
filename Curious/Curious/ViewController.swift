//
//  ViewController.swift
//  Curious
//
//  Created by viramesh on 3/26/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var bottomYellowC: UIImageView!
//    @IBOutlet weak var bottomPinkC: UIImageView!
//    @IBOutlet weak var bottomGreenC: UIImageView!
//    @IBOutlet weak var topPinkC: UIImageView!
//    @IBOutlet weak var topGreenC: UIImageView!
    
    @IBOutlet weak var topGreenC: UIImageView!
    @IBOutlet weak var topPinkC: UIImageView!
    @IBOutlet weak var bottomGreenC: UIImageView!
    @IBOutlet weak var bottomPinkC: UIImageView!
    @IBOutlet weak var bottomYellowC: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animateLaunchScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func animateLaunchScreen() {
        
        var dist = view.frame.height * 0.6
        var dist2 = view.frame.height * 0.75
        var dur = 1.2
        
        
        UIView.animateKeyframesWithDuration(dur, delay: 0.1, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.bottomYellowC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(-200), CGAffineTransformMakeTranslation(0, dist))
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(dur, delay: 0.3, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            //
            self.bottomPinkC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(200), CGAffineTransformMakeTranslation(0, dist))
            
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(dur, delay: 0.2, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            //
            self.bottomGreenC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(-300), CGAffineTransformMakeTranslation(0, dist))
            
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(dur, delay: 0.4, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            //
            self.topPinkC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(300), CGAffineTransformMakeTranslation(0, dist2))
            
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(dur, delay: 0.2, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            //
            self.topGreenC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(-400), CGAffineTransformMakeTranslation(0, dist2))
            
            }) { (Bool) -> Void in
                //
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "loadHomeView", userInfo: nil, repeats: false)

    }
    
    func loadHomeView() {
        performSegueWithIdentifier("loadHomeView", sender: self)
    }
    
}

