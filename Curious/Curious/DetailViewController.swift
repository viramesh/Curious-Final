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
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var instructionsTop: NSLayoutConstraint!
    @IBOutlet weak var detailsTop: NSLayoutConstraint!
    @IBOutlet weak var rewindBtnTop: NSLayoutConstraint!
    
    var btnHeight:CGFloat! = 100
    var spacer:CGFloat! = 20
    
    //for scrubbing
    var imageNamePrefix:String = ""
    var imageNameMIN:Int = 0
    var imageNameMAX:Int = 0
    var imageNameMAXs: [String: Int!] = ["candles":32, "coaster":30, "plant":10, "string":22, "wood":16, "tablecloth":37, "magnet":10]
    var imageSpeed:CGFloat = 0.1
    var currentImage:Int!
    var initialImage:Int!
    
    //for progress bar
    @IBOutlet weak var progressView: UIView!
    var progressBar: UIView!
    var progressBlock: CGFloat!
    
    //for auto scrubbing back to 1st step
    var rewindDuration:Double = 3
    var scrollBackSpeed:NSTimeInterval!
    var rewindLabel:UILabel!
    var rewindCompleted:Bool! = false
    
    // passing project information
    var carouselImage: String!
    var detailTitle: String!
    var detailSubLabel: String!
    
    //for scrolling instructions
    var scrollWidthRatio:CGFloat! = 0.9
    var scrollPos:CGFloat! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageHeight.constant = self.view.frame.height * 0.4
        instructionsTop.constant = imageHeight.constant - instructionsScrollView.frame.height
        instructionsScrollView.layoutIfNeeded()
        detailsTop.constant = imageHeight.constant + btnHeight
        details.layoutIfNeeded()
        rewindBtnTop.constant = imageHeight.constant + spacer
        rewindButton.layoutIfNeeded()
        
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
//        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "resetToFirstStep", userInfo: nil, repeats: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rewindBtnDidPress(sender: AnyObject) {
        rewindButton.userInteractionEnabled = false
        rewindButton.alpha = 0.3
        resetToFirstStep()
    }

    func setupRewindLabel() {
        var rewindLabelFrame:CGRect = CGRectMake(0, imageHeight.constant-40, self.view.frame.width, 40)
        rewindLabel = UILabel(frame: rewindLabelFrame)
        rewindLabel.text = "Let's go back to the first step..."
        rewindLabel.textColor = UIColor.whiteColor()
        rewindLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
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
                    self.rewindCompleted = true
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
            var vframe:CGRect = CGRectMake(instructionsScrollView.frame.width * CGFloat(i) * scrollWidthRatio, 0.0, instructionsScrollView.frame.width * scrollWidthRatio, instructionsScrollView.frame.height)
            var instructionView:UIView = UIView(frame: vframe)
            instructionView.userInteractionEnabled = true
            
            //step number
            var stepNumFrame:CGRect = CGRectMake(instructionsScrollView.center.x * scrollWidthRatio - 20, 20, 40, 40)
            var stepNum:UILabel = UILabel(frame: stepNumFrame)
            var num = i+1
            stepNum.text = String(num)
            stepNum.layer.borderColor = UIColor.blackColor().CGColor
            stepNum.layer.borderWidth = 1
            stepNum.layer.cornerRadius = 20
            stepNum.textAlignment = NSTextAlignment.Center
            stepNum.font = UIFont(name: "Edmondsans-Regular", size: 20.0)!
            instructionView.addSubview(stepNum)
            
            //step description
            var stepDescFrame:CGRect = CGRectMake(25, 70, instructionsScrollView.frame.width * scrollWidthRatio - 50, instructionsScrollView.frame.height-90.0)
            
            var stepDesc:UITextView = UITextView(frame: stepDescFrame)
            stepDesc.userInteractionEnabled = false
            
            let font = UIFont(name: "Edmondsans-Regular", size: 16.0)!
            let textFont = [NSFontAttributeName:font]
            
            let para = NSMutableAttributedString()
            let attrString = NSAttributedString(string: Lorem.sentences(2), attributes:textFont)
            para.appendAttributedString(attrString)
            
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.lineSpacing = 5.0
            para.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0,length: para.length))
            stepDesc.attributedText = para
            instructionView.addSubview(stepDesc)
            
            instructionsScrollView.addSubview(instructionView)
        }
        
        instructionsScrollView.delegate = self
        instructionsScrollView.contentSize = CGSize(width: CGFloat(imageNameMAX+1)*instructionsScrollView.frame.width, height: instructionsScrollView.frame.height)
        
    }
    
    func showInstructions() {
        
        detailsTop.constant = self.view.frame.height - details.frame.height
        instructionsTop.constant = imageHeight.constant + spacer
        
        UIView.animateWithDuration(2.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.details.layoutIfNeeded()
                self.instructionsScrollView.layoutIfNeeded()
                self.instructionsScrollView.alpha = 1
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.rewindButton.alpha = 0
        }, completion: nil)
    }

    
    @IBAction func backButtonDidTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func imageDidPan(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if(rewindCompleted == true) {
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
                var prevStepBuffer:CGFloat! = 0
                if(stepNum>0) {
                    prevStepBuffer = -1 * self.instructionsScrollView.frame.width * ((1-self.scrollWidthRatio)/2)
                }
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.instructionsScrollView.contentOffset.x = prevStepBuffer + CGFloat(stepNum) * self.instructionsScrollView.frame.width * self.scrollWidthRatio
                    
                })
                
                let toImage = UIImage(named: self.imageNamePrefix + "-" + String(stepNum) + ".jpg")
                UIView.transitionWithView(self.carouselImageView, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                    self.carouselImageView.image = toImage
                    }, completion: nil)
                currentImage = stepNum
                updateProgressBar()
            }
            else {
                var prevStepBuffer:CGFloat = -1 * self.instructionsScrollView.frame.width * ((1-self.scrollWidthRatio)/2)
                //go to previous step
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.instructionsScrollView.contentOffset.x = prevStepBuffer + CGFloat(stepNum+1) * self.instructionsScrollView.frame.width * self.scrollWidthRatio
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

