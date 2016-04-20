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
    
    let navTitleFont = UIFont(name: "Lato-Black", size: 18)
    let navigationBarColor =  UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    let navigationBarTitleColor = UIColor(red: 0.078, green: 0.451, blue: 0.749, alpha: 1.00)
    let highLightedLabelFont = UIFont(name: "Lato-Bold", size: 16)
    
    var jsonDict:NSMutableDictionary?
    
    
    
    @IBOutlet weak var issueDueDate: UILabel!
    @IBOutlet weak var issueOwner: UILabel!
    @IBOutlet weak var issueDescriptionTextView: UITextView!
    @IBOutlet weak var sourceType: UILabel!
    @IBOutlet weak var IssueRiskRating: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
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

//        self.issueLabel.font = navTitleFont
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        var content:NSMutableDictionary?
        var structure:NSMutableDictionary?
        var resources:NSMutableDictionary?
        
        if let contents = self.jsonDict!["content"] as? NSDictionary
        {
            content = NSMutableDictionary.init(dictionary: contents);
        }
        
        if let structs  = self.jsonDict!["structure"] as? NSDictionary
        {
            structure = NSMutableDictionary.init(dictionary: structs);
        }
        
        if let resource  = self.jsonDict!["resources"] as? NSDictionary
        {
            resources = NSMutableDictionary.init(dictionary: resource);
        }
        
        
        if let Obj = content!["ISSUE_DUE_BY"] as? NSDictionary
        {
            self.issueDueDate.text = Obj["value"] as? String;
            
        }
        
        if let Obj = content!["ISSUE_DETAILS"] as? NSDictionary
        {
            self.issueDescriptionTextView.text = Obj["value"] as? String;
            
        }
        
        if let obj = content!["ISSUE_SOURCE_TYPE"] as? NSDictionary
        {
            let source = obj["value"] as? String;
            
            if let sourceTypes = resources!["MS 001 ISM Common LOV Infolet_26"] as? NSDictionary
            {
                self.sourceType.text = sourceTypes[source!] as? String;
            }
            
        }
        
        if let obj = content!["ISSUE_OWNER"] as? NSDictionary
        {
            let source = obj["value"] as? String;
            
            if let sourceTypes = resources!["MS_ISM_Users_All_12"] as? NSDictionary
            {
                self.issueOwner.text = sourceTypes[source!] as? String;
            }
            
        }
        
    
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

