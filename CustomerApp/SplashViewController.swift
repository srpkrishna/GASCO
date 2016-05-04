//
//  SplashViewController.swift
//  Dashboards
//
//  Created by Phani on 15/03/16.
//  Copyright © 2016 MetricStream. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController
{
    var companyFirstName: UILabel!
    var companyLastName: UILabel!
    var dashBoardLabel : UILabel!
    var comapnyLogo: UIImageView!
    
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.mainScreen().bounds
        let companyOrignX = (screenSize.size.width*30)/100
        let companyOrignY = ((screenSize.size.height*30)/100)
        
        let companyNameColorElement = UIColor(red: 0.000, green: 0.353, blue: 0.667, alpha: 1.00)
        let companySubtitleColorElement = UIColor(red: 0.000, green: 0.424, blue: 0.706, alpha: 1.00)
        let companyTitleFont = UIFont(name: "Lato-black", size: 30)
        let companySubTitleFont = UIFont(name: "Lato-black", size: 11)
        
        companyFirstName = UILabel(frame: CGRect(x: companyOrignX, y: companyOrignY, width: 105, height: 50))
        companyFirstName.text  = "GASCO"
        companyFirstName.font = companyTitleFont
        companyFirstName.numberOfLines = 0
        companyFirstName.adjustsFontSizeToFitWidth = false
        companyFirstName.textColor = companyNameColorElement
        self.view .addSubview(companyFirstName)
        
      /*  let xPositonForSecondLabel = companyFirstName.frame.origin.x + companyFirstName.frame.width
        
        companyLastName = UILabel(frame: CGRect(x: xPositonForSecondLabel , y: screenSize.size.height-50, width: 45, height: 50))
        companyLastName.text  = "CO"
        companyLastName.font = companyTitleFont
        companyLastName.numberOfLines = 0
        companyLastName.adjustsFontSizeToFitWidth = false
        companyLastName.textColor = companyNameColorElement
        self.view.addSubview(companyLastName) */
        
        //DashBoard Label
        let dashBoardOriginX = (screenSize.size.width*30)/100
        let dashBoardOriginY = ((screenSize.size.height*35)/100)
        
        dashBoardLabel = UILabel(frame: CGRect(x: dashBoardOriginX , y: dashBoardOriginY, width: 183, height: 50))
        dashBoardLabel.text  = ""
        dashBoardLabel.font = companySubTitleFont
        dashBoardLabel.textColor = self.view.tintColor
        dashBoardLabel.numberOfLines = 0
        dashBoardLabel.adjustsFontSizeToFitWidth = true
        dashBoardLabel.textColor = companySubtitleColorElement
        self.view.addSubview(dashBoardLabel)
        
        
        //Animating Company Label
     /*  UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations:
            {
                self.companyFirstName.frame = CGRect(x: companyOrignX, y: companyOrignY, width: 105, height: 50)
               /* self.companyLastName.frame = CGRect(x: xPositonForSecondLabel , y: companyOrignY, width: 45, height: 50) */
            }, completion: nil) */

        //Animating DashBoard Label
        UIView.animateWithDuration(0.0, delay: 0.0, options:    UIViewAnimationOptions.CurveEaseOut, animations: {
            self.dashBoardLabel.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                //Once the label is completely invisible, set the text and fade it back in
                self.dashBoardLabel.text  = "Abu Dhabi Gas Industries Ltd."
                
                // Fade in
                UIView.animateWithDuration(2.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.dashBoardLabel.alpha = 1.0
                    }, completion: nil)
                
        })
        
        //Company Logo
        let companyLogoOrginX = companyFirstName.frame.origin.x + companyFirstName.frame.size.width + 5
        let companyLogoOriginY = companyFirstName.frame.origin.y + companyFirstName.frame.size.height - 5
        
        self.comapnyLogo = UIImageView(frame: CGRect(x: companyLogoOrginX, y: companyLogoOriginY - 80, width: 42, height: 80))
        self.comapnyLogo.image = UIImage(named: "gascoLogo.png")
        
        self.view.addSubview(self.comapnyLogo)

        timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("loadIntialViewOfTheApp"), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadIntialViewOfTheApp()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myController   = storyboard.instantiateViewControllerWithIdentifier("EntryNavigationBar")
        self.presentViewController(myController, animated: true, completion: nil)
    }
}
