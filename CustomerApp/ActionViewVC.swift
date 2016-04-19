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
    
    var actionElement: ActionElement?
    var content:NSMutableDictionary?
    var jsonDict:NSMutableDictionary?
    
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
        
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ActionViewVC.navigateToIssueVC(_:)))
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
        
        getForm();
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func navigateToIssueVC(sender:UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myController:IssueViewVC = storyboard.instantiateViewControllerWithIdentifier("IssueViewVC") as! IssueViewVC
        myController.content = self.content;
        self.navigationController?.pushViewController(myController, animated: true);

        
    }
    
    func getForm(){
        let reportURL = m2API.actionDetailsDataUrl(actionElement!.taskId)
        let request = NSMutableURLRequest(URL: reportURL)
        request.HTTPMethod = "GET";
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let serverCall = HttpCall.init();
        serverCall.getData(request){(data) -> Void in
        
            
            do
            {
                 self.jsonDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? NSMutableDictionary
                
                if let contents = self.jsonDict!["content"] as? NSDictionary
                {
                    self.content = NSMutableDictionary.init(dictionary: contents);
                }
                
            }
            catch let error as NSError {
                // error handling
                NSLog("error %@", error.description);
            }
        
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //self.tableView.reloadData()
                ACTION_TITLE
                ISSUE_TITLE
                
                ACTION_OWNER
                ACTION_APPROVER1
                ACTION_DETAILS
                ACTION_START_DATE
                ACTION_DUE_DATE
                ACTION_WORK_DONE
            })
            
        }
        
        
    }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

