//
//  ViewController.swift
//  CustomerApp
//
//  Created by Ashok on 4/5/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class IssueViewVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var issueVCNavigationItem: UINavigationItem!
    
    

    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var issueDescriptionTextView: UITextView!
    
    let navTitleFont = UIFont(name: "Lato-Black", size: 18)
    let navigationBarColor =  UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    let navigationBarTitleColor = UIColor(red: 0.078, green: 0.451, blue: 0.749, alpha: 1.00)
    let highLightedLabelFont = UIFont(name: "Lato-Bold", size: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
//        self.navigationController?.navigationBar.items?.first?.backBarButtonItem?.title = ""
        print(self.navigationController?.navigationBar.items?.first?.backBarButtonItem?.title)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navTitleFont!, NSForegroundColorAttributeName: navigationBarTitleColor]
        self.navigationController?.navigationBar.tintColor = navigationBarTitleColor
    
        self.scrollView.contentSize = CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 30 )
        self.scrollView.scrollEnabled = true
        self.scrollView.pagingEnabled = true
        
        self.commentTextView.layer.borderWidth = CGFloat(1.0)
        self.commentTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.commentTextView.layer.cornerRadius = CGFloat(5.0)
        
        self.issueDescriptionTextView.layer.borderWidth = CGFloat(1.0)
        self.issueDescriptionTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.issueDescriptionTextView.layer.cornerRadius = CGFloat(5.0)

        self.issueLabel.font = navTitleFont
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y -= keyboardSize.height
//        }
//        
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y += keyboardSize.height
//        }
//    }


}

