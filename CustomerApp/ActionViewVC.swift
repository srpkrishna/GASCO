//
//  ApproveRequest.swift
//  CustomerApp
//
//  Created by Ashok on 4/6/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

//http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color

import UIKit

class ActionViewVC: UIViewController, UITabBarDelegate {
    
    
    @IBOutlet weak var navApproveRequestTitle: UINavigationItem!
    
    /* Start: TabBar and TabBar Items */
    @IBOutlet weak var ApproveRequestTabBar: UITabBar!
    @IBOutlet weak var approveAction: UITabBarItem!
    @IBOutlet weak var requestClarification: UITabBarItem!
    /* End: TabBar and TabBar Items */
    
    
    @IBOutlet weak var actionDescriptionTextView: UITextView!
    @IBOutlet weak var workDoneTextView: UITextView!
    @IBOutlet weak var commentsTextView: UITextView!

    @IBOutlet weak var scrollView: UIScrollView! //ScrollView
    
    let navTitleFont = UIFont(name: "Lato-black", size: 18)
    let navigationBarColor =  UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    let navigationBarTitleColor = UIColor(red: 0.078, green: 0.451, blue: 0.749, alpha: 1.00)
    
    let tabBarItemColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    
    let highLightedLabelFont = UIFont(name: "Lato-Bold", size: 16)
    
    
    @IBOutlet weak var actionImplementation: UILabel!
    @IBOutlet weak var attachments: UILabel!

    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var IssueStackView: UIStackView!
    
    
    @IBOutlet weak var downloadAllButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navTitleFont!, NSForegroundColorAttributeName: navigationBarTitleColor]
        self.navigationController?.navigationBar.tintColor = navigationBarTitleColor
        
        requestClarification.titlePositionAdjustment = UIOffsetMake(0.0, -10.0)
        approveAction.titlePositionAdjustment = UIOffsetMake(0.0, -10.0)
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSFontAttributeName: UIFont(name:"Lato-black", size:16)!,
                NSForegroundColorAttributeName: tabBarItemColor],
            forState: .Normal)
        
        /* Scroll View Setting*/
        self.scrollView.contentSize = CGSize(width: self.view.frame.width - 20, height: (self.view.frame.height * 2))
        self.scrollView.scrollEnabled = true
        self.scrollView.pagingEnabled = true
        
       let tapGesture = UITapGestureRecognizer(target: self, action: "navigateToIssueVC:")
        self.IssueStackView.addGestureRecognizer(tapGesture)
        ApproveRequestTabBar.delegate = self
        
        self.actionDescriptionTextView.layer.borderWidth = CGFloat(1.0)
        self.actionDescriptionTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.actionDescriptionTextView.layer.cornerRadius = CGFloat(5.0)
        
        self.workDoneTextView.layer.borderWidth = CGFloat(1.0)
        self.workDoneTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.workDoneTextView.layer.cornerRadius = CGFloat(5.0)
        
        self.commentsTextView.layer.borderWidth = CGFloat(1.0)
        self.commentsTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.commentsTextView.layer.cornerRadius = CGFloat(5.0)
        
        self.downloadAllButton.layer.cornerRadius = CGFloat(15.0)
        
        self.actionImplementation.font = highLightedLabelFont
        self.attachments.font = highLightedLabelFont
        self.issueLabel.font = highLightedLabelFont
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func navigateToIssueVC(sender:UITapGestureRecognizer){
        self.performSegueWithIdentifier("IssueVCSegue", sender: self)
    }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

