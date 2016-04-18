//
//  ApproveRequest.swift
//  CustomerApp
//
//  Created by Ashok on 4/6/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

//http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color

import UIKit

class ApproveRequest: UIViewController, UITabBarDelegate {
    
    
    @IBOutlet weak var navApproveRequestTitle: UINavigationItem!

    @IBOutlet weak var ApproveRequestTabBar: UITabBar!
    @IBOutlet weak var approveAction: UITabBarItem!
    @IBOutlet weak var requestClarification: UITabBarItem!
        @IBOutlet weak var dashBoard: UITabBarItem!
   
    @IBOutlet weak var actionIssueSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var issueView: UIView!


    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var commentTextView: UITextView!
    
    let navTitleFont = UIFont(name: "Lato-black", size: 18)
    let tabBarItemColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        let navTitleColor = UIColor(red: 0.078, green: 0.451, blue: 0.749, alpha: 1.00)
        
        self.navigationController?.navigationBar.barTintColor = navBarColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navTitleFont!, NSForegroundColorAttributeName: navTitleColor]
        
        self.navigationController?.navigationBar.tintColor = navTitleColor
        
        requestClarification.titlePositionAdjustment = UIOffsetMake(0.0, -10.0)
        approveAction.titlePositionAdjustment = UIOffsetMake(0.0, -10.0)
        dashBoard.titlePositionAdjustment = UIOffsetMake(0.0, -10.0)
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSFontAttributeName: UIFont(name:"Lato-black", size:16)!,
                NSForegroundColorAttributeName: tabBarItemColor],
            forState: .Normal)
        
        let attr = NSDictionary(object: UIFont(name: "Lato-black", size: 16.0)!, forKey: NSFontAttributeName)
//        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , forState: .Normal)
        
        actionIssueSegmentedControl.setTitleTextAttributes(attr as [NSObject: AnyObject], forState: .Normal)
        
        self.scrollView.frame = self.issueView.frame
        self.scrollView.contentSize = CGSize(width: self.issueView.frame.width, height: self.view.frame.height + self.view.frame.height / 2.5)
//        self.scrollView.backgroundColor = UIColor.blueColor()
        self.scrollView.scrollEnabled = true
        self.scrollView.pagingEnabled = true
        print(self.scrollView)
        
//        commentTextView.contentInset = defaultContentInset
//        
//        NSNotificationCenter.defaultCenter().addObserver( self,
//            selector: "handleKeyboardDidShow:",
//            name: UIKeyboardDidShowNotification,
//            object: nil)
//        
//        NSNotificationCenter.defaultCenter().addObserver( self,
//                selector: "handleKeyboardWillHide:",
//                name: UIKeyboardWillHideNotification,
//                object: nil)
//        
     ApproveRequestTabBar.delegate = self
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    @IBAction func selectedSegment(sender: UISegmentedControl) {
        
        let selectedSeg = sender.selectedSegmentIndex
        
        if (selectedSeg == 0) {
            issueView.hidden = true
            scrollView.hidden = false
        }
        else{
            issueView.hidden = false
            scrollView.hidden = true
        }
    }
    
//    let defaultContentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    
//    func handleKeyboardDidShow(notification: NSNotification) {
//        /* Get the frame of the keyBoard */
//        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
//        
//        /*Place it in a CGRect */
//        var keyboardRect = CGRectZero
//        
//        keyboardRectAsObject.getValue(&keyboardRect)
//        
//        commentTextView.contentInset = UIEdgeInsets(top: defaultContentInset.top, left: 0, bottom: keyboardRect.height, right: 0)
// 
//    }
//    
//    func handleKeyboardWillHide(notification: NSNotification){
//        commentTextView.contentInset = defaultContentInset
//    }
    
    
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.title! == "Dashboard" {
            self.performSegueWithIdentifier("DashBoardSBID", sender: self)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
