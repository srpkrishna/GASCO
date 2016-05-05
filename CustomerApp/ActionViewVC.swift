    //
//  ApproveRequest.swift
//  CustomerApp
//
//  Created by Ashok on 4/6/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class ActionViewVC: UIViewController, UITabBarDelegate, UITextViewDelegate {
    
    var actionElement: ActionElement?
    var jsonDict:NSMutableDictionary?
    let loader = LoadingScreen.init();
    
    @IBOutlet weak var navApproveRequestTitle: UINavigationItem!
    
    /* Start: TabBar and TabBar Items */
    @IBOutlet weak var ApproveRequestTabBar: UITabBar!
    @IBOutlet weak var approveAction: UITabBarItem!
    @IBOutlet weak var requestClarification: UITabBarItem!
    /* End: TabBar and TabBar Items */

    @IBOutlet weak var scrollView: UIScrollView! //ScrollView
    
    let navTitleFont = UIFont(name: "Lato-black", size: 18)
    let navigationBarColor =  UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    let navigationBarTitleColor = UIColor(red: 0.078, green: 0.451, blue: 0.749, alpha: 1.00)
    
    
    let highLightedLabelFont = UIFont(name: "Lato-Bold", size: 16)
    
    @IBOutlet weak var approveActionLabel: UILabel!
    @IBOutlet weak var requestClarificationUILabel: UILabel!
    
    @IBOutlet weak var actionImplementationUIUnderLineLabel: UnderLineUILabel!
    @IBOutlet weak var attachments: UILabel!

    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var IssueStackView: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBOutlet weak var nextViewNavigationSymbol: UILabel!
    
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var actionOwnerOrganization: UILabel!
    @IBOutlet weak var actionOwner: UILabel!
    @IBOutlet weak var actionApprover: UILabel!
    
    
    @IBOutlet weak var actionDescriptionTextView: UITextView!
    @IBOutlet weak var actionStartDate: UILabel!
    @IBOutlet weak var actionDueDate: UILabel!
    @IBOutlet weak var workDoneTextView: UITextView!
    @IBOutlet weak var commentsTextView: UITextView!
    
    
    
    @IBOutlet weak var downloadAllButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        nextViewNavigationSymbol.layer.borderColor = UIColor(red: 0.953, green: 0.502, blue: 0.094, alpha: 1.00).CGColor
        nextViewNavigationSymbol.layer.borderWidth = 1.0
        
        let viewMaskframe = CGRectMake(0.0, 0.0, nextViewNavigationSymbol.frame.size.width, nextViewNavigationSymbol.frame.size.height - 1.0)
        let viewMask = UIView(frame: viewMaskframe)
        viewMask.backgroundColor = UIColor.blackColor()
        nextViewNavigationSymbol.layer.mask = viewMask.layer
        
        self.approveActionLabel.font = highLightedLabelFont
        self.requestClarificationUILabel.font = highLightedLabelFont
        
        let approveActionTap = UITapGestureRecognizer(target: self, action: "didSelectActionItem:")
        approveActionTap.numberOfTapsRequired = 1
        self.approveActionLabel.addGestureRecognizer(approveActionTap)
        self.approveActionLabel.userInteractionEnabled = true
        self.approveActionLabel.tag = 39
        
        
        let requestClarificationTap = UITapGestureRecognizer(target: self, action: "didSelectActionItem:")
        requestClarificationTap.numberOfTapsRequired = 1
        self.requestClarificationUILabel.addGestureRecognizer(requestClarificationTap)
        self.requestClarificationUILabel.userInteractionEnabled = true
        self.requestClarificationUILabel.tag = 40
        
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navTitleFont!, NSForegroundColorAttributeName: navigationBarTitleColor]
        self.navigationController?.navigationBar.tintColor = navigationBarTitleColor
        
      
        
        self.scrollView.scrollEnabled = true
        self.scrollView.pagingEnabled = true
        
        let dismissKeyBoard = UITapGestureRecognizer(target: self, action: "dismissKeyBoardOnTapofView:")
        self.view.addGestureRecognizer(dismissKeyBoard)
        
       let tapGesture = UITapGestureRecognizer(target: self, action: "navigateToIssueVC:")
        
        /*self.stackView.layer.cornerRadius = 10.0
        
        self.stackView.layer.borderWidth = 1.0
        self.stackView.layer.borderColor = UIColor.blackColor().CGColor
        
        self.stackView.layer.shadowColor = UIColor.blackColor().CGColor
        self.stackView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.stackView.layer.shadowOpacity = 0.7
        self.stackView.layer.shadowRadius = 4.0
        */
        
        self.IssueStackView.addGestureRecognizer(tapGesture)
        
    
        
        self.actionDescriptionTextView.delegate = self
        self.actionDescriptionTextView.layer.borderWidth = CGFloat(1.0)
        self.actionDescriptionTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.actionDescriptionTextView.layer.cornerRadius = CGFloat(5.0)
        
        self.actionDescriptionTextView.editable = false
        
        self.workDoneTextView.delegate = self
        self.workDoneTextView.layer.borderWidth = CGFloat(1.0)
        self.workDoneTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.workDoneTextView.layer.cornerRadius = CGFloat(5.0)
        self.workDoneTextView.editable = false
        
        self.commentsTextView.delegate = self
        self.commentsTextView.layer.borderWidth = CGFloat(1.0)
        self.commentsTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.commentsTextView.layer.cornerRadius = CGFloat(5.0)
        
        
        self.actionImplementationUIUnderLineLabel.font = highLightedLabelFont
        self.actionImplementationUIUnderLineLabel.text = self.actionImplementationUIUnderLineLabel.text
        self.issueLabel.font = highLightedLabelFont
        
        getForm();
        
    }
    
    func didSelectActionItem(sender: UIGestureRecognizer) {
 
        let putData = self.jsonDict!.mutableCopy()
        let contents = putData["content"] as? NSMutableDictionary
        
        let dict = putData as! NSMutableDictionary;
        let content = contents?.mutableCopy();
        
        
        
        if let Obj = content!["ACTION_COMMENTS"] as? NSMutableDictionary
        {
            let object = Obj.mutableCopy();
            let val = self.commentsTextView.text;
            object.setObject(val, forKey: "value")
            content?.setObject(object, forKey: "ACTION_COMMENTS");
        }
        
        let itemTag = (sender.view as! UILabel).tag
        let actionValue:String = String(itemTag)
        
        /*
        var actionValue = "39";
        
        if(item == requestClarification)
        {
            actionValue = "40";
        }
        */
        
        
        if let Obj = content!["ACT_ACTION"] as? NSMutableDictionary
        {
            let object = Obj.mutableCopy();
            object.setObject(actionValue, forKey: "value")
            content?.setObject(object, forKey: "ACT_ACTION");
        }
        
        
        dict.setObject(content!, forKey: "content");
        
        let reportURL = m2API.actionSubmitUrl(actionElement!.taskId,queryparams: "?action=submit&offline=no")
        let request = NSMutableURLRequest(URL: reportURL)
        request.HTTPMethod = "PUT";
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(dict,options:NSJSONWritingOptions.init(rawValue: 0))
            let string1 = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
            print(string1)
            
        }catch let error as NSError {
            // error handling
            NSLog("error %@", error.description);
        }
        
        loader.showLoading();
        
        let serverCall = HttpCall.init();
        serverCall.getData(request){(data,error) -> Void in
            
            if(error != "")
            {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.loader.hideLoading()
                    self.presentViewController(alert, animated: true, completion: nil)
                })
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let alert = UIAlertController(title: "Alert", message: "Action submitted successfully ", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default){
                    action in
                    self.loader.hideLoading();
                    self.navigationController?.popToRootViewControllerAnimated(true);
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            })
        }

    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func navigateToIssueVC(sender:UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myController:IssueViewVC = storyboard.instantiateViewControllerWithIdentifier("IssueViewVC") as! IssueViewVC
        myController.jsonDict = self.jsonDict;
        self.navigationController?.pushViewController(myController, animated: true);

        
    }
    
    func dismissKeyBoardOnTapofView(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func getForm(){
        let reportURL = m2API.actionDetailsDataUrl(actionElement!.taskId)
        let request = NSMutableURLRequest(URL: reportURL)
        request.HTTPMethod = "GET";
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let serverCall = HttpCall.init();
        loader.showLoading();
        serverCall.getData(request){(data,error) -> Void in
        
            
            if(error != "")
            {
                
                 dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                        self.loader.hideLoading()
                    })
                return
            }
            
            var content:NSMutableDictionary?
            var resources:NSMutableDictionary?
            
            do
            {
                 self.jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? NSMutableDictionary
                
                if let contents = self.jsonDict!["content"] as? NSDictionary
                {
                    content = NSMutableDictionary.init(dictionary: contents);
                }
                if let resource  = self.jsonDict!["resources"] as? NSDictionary
                {
                    resources = NSMutableDictionary.init(dictionary: resource);
                }
                
            }
            catch let error as NSError {
                // error handling
                NSLog("error %@", error.description);
            }
        
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //self.tableView.reloadData()
                

                self.actionTitle.text = self.actionElement?.title;
                
                if let Obj = content!["ISSUE_TITLE"] as? NSDictionary
                {
                    self.issueTitle.text = Obj["value"] as? String;
    
                }
                
                if let obj = content!["ACTION_OWNER"] as? NSDictionary
                {
                    let user = obj["value"] as? String;
                    
                    if let users = resources!["MS_ISM_Users_All_12"] as? NSDictionary
                    {
                        if let valObj = users[user!] as? NSDictionary
                        {
                            self.actionOwner.text = valObj["value"] as? String;
                        }
                    }
                    
                    
                }
                
                if let obj = content!["ACTION_APPROVER1"] as? NSDictionary
                {
                    let user = obj["value"] as? String;
                    
                    if let users = resources!["MS_ISM_Users_All_13"] as? NSDictionary
                    {
                        if let valObj = users[user!] as? NSDictionary
                        {
                            self.actionApprover.text = valObj["value"] as? String;
                        }
                    }
                    
                    
                }
                
                if let obj = content!["ACTION_DETAILS"] as? NSDictionary
                {
                    
                    if let actDetails:String = obj["value"] as? String
                    {
                        self.actionDescriptionTextView.text = actDetails;
                    }
                    
                }
                
                if let Obj = content!["ACTION_START_DATE"] as? NSDictionary
                {
                    if let date:String = Obj["value"] as? String
                    {
                        self.actionStartDate.text = date;
                    }
                    
                }
                
                if let Obj = content!["ACTION_DUE_DATE"] as? NSDictionary
                {
                    self.actionDueDate.text = Obj["value"] as? String;
                    
                }
                
                if let Obj = content!["ACTION_WORK_DONE"] as? NSDictionary
                {
                    self.workDoneTextView.text = Obj["value"] as? String;
                    
                }
                self.loader.hideLoading();
                
//                ACTION_OWNER
//                ACTION_APPROVER1
//                ACTION_DETAILS
//                ACTION_START_DATE
//                ACTION_DUE_DATE
//                ACTION_WORK_DONE
            })
            
        }
        
        
    }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

