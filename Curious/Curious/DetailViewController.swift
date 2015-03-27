//
//  DetailViewController.swift
//  Curious
//
//  Created by viramesh on 3/26/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit
//import PNChart

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var carouselImageView: UIImageView!
    @IBOutlet weak var details: UIView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var instructionsScrollView: UIScrollView!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var detailsBottom: NSLayoutConstraint!
    
    //for scrubbing
    var imageNamePrefix:String = ""
    var imageNameMIN:Int = 0
    var imageNameMAX:Int = 0
    var imageNameMAXs: [String: Int!] = ["candles":32, "coaster":30, "plant":10, "string":22, "wood":16]
    var imageSpeed:CGFloat = 0.1
    var currentImage:Int!
    var initialImage:Int!
    
    //for progress bar
    @IBOutlet weak var progressView: UIView!
    var progressBar: UIView!
    var progressBlock: CGFloat!
    
    //for auto scrubbing back to 1st step
    var rewindDuration:Double = 5
    var scrollBackSpeed:NSTimeInterval!
    var rewindLabel:UILabel!
    
    // passing project information
    var carouselImage: String!
    var detailTitle: String!
    var detailSubLabel: String!
    
    //for scrolling instructions
    var scrollPos:CGFloat! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        currentImage = imageNameMIN
        
        carouselImageView.image = UIImage(named: carouselImage)
        carouselImageView.userInteractionEnabled = true
        
        projectTitle.text = detailTitle
        projectDescription.text = detailSubLabel
        
        imageNamePrefix=carouselImage.componentsSeparatedByString("-") [0]
        imageNameMAX = imageNameMAXs[imageNamePrefix] as Int!
        scrollBackSpeed = NSTimeInterval( rewindDuration / Double(imageNameMAX) )
        
        //set up instructions
        setupInstructions()
        
        //setup progress bar for rewind
        self.progressView.alpha = 0
        setupRewindLabel()
        
        //give everything time to load and then rewind back to first step
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "resetToFirstStep", userInfo: nil, repeats: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupRewindLabel() {
        var rewindLabelFrame:CGRect = CGRectMake(0, 360, self.view.frame.width, 40)
        rewindLabel = UILabel(frame: rewindLabelFrame)
        rewindLabel.text = "Taking you back to how it all started..."
        rewindLabel.textColor = UIColor.blackColor()
        rewindLabel.textAlignment = NSTextAlignment.Center
        rewindLabel.alpha = 0
        self.view.addSubview(rewindLabel)
    }
    
    func resetToFirstStep() {
        
        setupProgressBar()
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.progressView.alpha = 1
            self.rewindLabel.alpha = 1
        })
        
        animateProgressBar()
        animateImageBackToFirstStep(imageNameMAX)
    }
    
    func setupProgressBar() {
        progressBar = UIView(frame: CGRectMake(0,0,progressView.frame.width, progressView.frame.height))
        progressBar.backgroundColor = UIColor(red: 26/255, green: 205/255, blue: 192/255, alpha: 1)
        progressView.addSubview(progressBar)
        progressBlock = progressView.frame.width / CGFloat(imageNameMAX+1)
    }
    
    func updateProgressBar() {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.progressBar.frame.origin.x = (CGFloat(self.currentImage - self.imageNameMAX) / CGFloat(self.imageNameMAX)) * self.progressView.frame.width
            }) { (Bool) -> Void in
                //
        }
    }
    
    func animateProgressBar() {
        UIView.animateWithDuration(rewindDuration+0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.progressBar.frame.origin.x = self.progressBar.frame.origin.x - self.progressView.frame.width

        }) { (Bool) -> Void in
            //
        }

    }

    func animateImageBackToFirstStep(current: Int) {
        
        var newImage: Int = current - 1
        let toImage = UIImage(named: self.imageNamePrefix + "-" + String(newImage) + ".jpg")
        self.currentImage = newImage
        
        UIView.transitionWithView(self.carouselImageView, duration: self.scrollBackSpeed, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.carouselImageView.image = toImage
            
        }) { (Bool) -> Void in
            if(current > 1) {
                self.animateImageBackToFirstStep(current-1)
            }
                
            else {
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.rewindLabel.alpha = 0
                    self.instructionsScrollView.alpha = 1
                    self.showInstructions()
                    }, completion: { (Bool) -> Void in
                        self.rewindLabel.removeFromSuperview()
                })
                
            }
        }
        
        
    }
    
    
    func setupInstructions() {
        
        instructionsScrollView.alpha = 0
        
        //for each image, create an instruction view and add it to the scrollview
        for var i=0; i<=imageNameMAX; i++ {
            var vframe:CGRect = CGRectMake(instructionsScrollView.frame.width * CGFloat(i), 0.0, instructionsScrollView.frame.width, instructionsScrollView.frame.height)
            var instructionView:UIView = UIView(frame: vframe)
            instructionView.userInteractionEnabled = true
            
            var stepNumFrame:CGRect = CGRectMake(10, 20, 40, 30)
            var stepNum:UILabel = UILabel(frame: stepNumFrame)
            var num = i+1
            if (num < 10) {
                stepNum.text = "0" + String(num)
            }
            else {
                stepNum.text = String(num)
            }
            stepNum.textAlignment = NSTextAlignment.Right
            stepNum.font = UIFont(name: "Edmondsans-Regular", size: 30.0)!
            instructionView.addSubview(stepNum)
            
            var stepDescFrame:CGRect = CGRectMake(60, 20, 240, instructionsScrollView.frame.height-40.0)
            var stepDesc:UILabel = UILabel(frame: stepDescFrame)
            stepDesc.text = Lorem.sentences(2)
            stepDesc.font = UIFont(name: "Edmondsans-Regular", size: 18.0)!
            stepDesc.numberOfLines = 0
            stepDesc.sizeToFit()
            instructionView.addSubview(stepDesc)
            
            instructionsScrollView.addSubview(instructionView)
        }
        
        instructionsScrollView.delegate = self
        instructionsScrollView.contentSize = CGSize(width: CGFloat(imageNameMAX+1)*instructionsScrollView.frame.width, height: instructionsScrollView.frame.height)
        //println(instructionsScrollView.contentSize)
    }
    
    func showInstructions() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.instructionsScrollView.alpha = 1
        })
    }

    
    @IBAction func backButtonDidTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func imageDidPan(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            initialImage = currentImage
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            currentImage = initialImage + Int(translation.x * imageSpeed)
            if(currentImage < imageNameMIN) {
                currentImage = imageNameMIN
            }
            else if(currentImage > imageNameMAX) {
                currentImage = imageNameMAX
            }
            
            let toImage = UIImage(named: self.imageNamePrefix + "-" + String(currentImage) + ".jpg")
            UIView.transitionWithView(self.carouselImageView, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                self.carouselImageView.image = toImage
            }, completion: nil)
            updateProgressBar()
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            
            instructionsScrollView.contentOffset.x = CGFloat(currentImage) * instructionsScrollView.frame.width
            
        }
    }
    
    @IBAction func buyButtonWasTapped(sender: AnyObject) {
        performSegueWithIdentifier("cartSegue", sender: self)
    }
    
    @IBAction func instructionsDidPan(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(self.view)
        var velocity = sender.velocityInView(self.view)
        
        if sender.state == UIGestureRecognizerState.Began {
            scrollPos = instructionsScrollView.contentOffset.x
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            var newPos = scrollPos - translation.x
            if(newPos < 0) {
                instructionsScrollView.contentOffset.x = 0
            }
                
            else if(newPos > instructionsScrollView.contentSize.width-instructionsScrollView.frame.width) {
                instructionsScrollView.contentOffset.x = instructionsScrollView.contentSize.width-instructionsScrollView.frame.width
            }
                
            else {
                instructionsScrollView.contentOffset.x = newPos
            }
            
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            var stepNum = Int(instructionsScrollView.contentOffset.x / instructionsScrollView.frame.width)
            
            if(velocity.x > 0) {
                //go to next step
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.instructionsScrollView.contentOffset.x = CGFloat(stepNum) * self.instructionsScrollView.frame.width
                })
                
                let toImage = UIImage(named: self.imageNamePrefix + "-" + String(stepNum) + ".jpg")
                UIView.transitionWithView(self.carouselImageView, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                    self.carouselImageView.image = toImage
                    }, completion: nil)
                currentImage = stepNum
                updateProgressBar()
            }
            else {
                //go to previous step
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.instructionsScrollView.contentOffset.x = CGFloat(stepNum+1) * self.instructionsScrollView.frame.width
                })
                let toImage = UIImage(named: self.imageNamePrefix + "-" + String(stepNum+1) + ".jpg")
                UIView.transitionWithView(self.carouselImageView, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                    self.carouselImageView.image = toImage
                    }, completion: nil)
                currentImage = stepNum+1
                updateProgressBar()
                
            }
        }
    }
    
}

