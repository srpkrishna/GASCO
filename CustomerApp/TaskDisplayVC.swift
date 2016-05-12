//
//  TaskDisplayVC.swift
//  CustomerApp
//
//  Created by Ashok on 5/10/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class TaskDisplayVC: UIViewController, UITabBarDelegate, UITextViewDelegate, UIScrollViewDelegate {
    
    var actionElement: ActionElement?
    var jsonDict:NSMutableDictionary?
    let loader = LoadingScreen.init();
    
    @IBOutlet weak var actionTitle: UITextField!
    @IBOutlet weak var issueTitle: UITextField!
    @IBOutlet weak var actionOwner: UITextField!
    @IBOutlet weak var actionApprover: UITextField!
    @IBOutlet weak var actionStartDate: UITextField!
    @IBOutlet weak var actionDueDate: UITextField!
    
    @IBOutlet weak var actionDescriptionTextView: UITextView!
    @IBOutlet weak var workDoneTextView: UITextView!
    @IBOutlet weak var commentsTextView: UITextView!
    
    @IBOutlet weak var approveActionLabel: UILabel!
    @IBOutlet weak var requestClarificationUILabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var IssueStackView: UIStackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        
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
        
        let dismissKeyBoard = UITapGestureRecognizer(target: self, action: "dismissKeyBoardOnTapofView:")
        self.view.addGestureRecognizer(dismissKeyBoard)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "navigateToIssueVC:")
        self.IssueStackView.addGestureRecognizer(tapGesture)
        
    
        customizeTextView(actionDescriptionTextView, canEdit: false)
        customizeTextView(workDoneTextView, canEdit: false)
        customizeTextView(commentsTextView, canEdit: true)
        
        actionTitle.placeholder = ""
        issueTitle.placeholder = ""
        actionOwner.placeholder = ""
        actionApprover.placeholder = ""
        actionStartDate.placeholder = ""
        actionDueDate.placeholder = ""
        
        
        getForm();
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
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
    
    func customizeTextView(textView: UITextView, canEdit: Bool){
        textView.delegate = self
        textView.layer.borderWidth = CGFloat(1.0)
        textView.layer.borderColor = UIColor.grayColor().CGColor
        textView.layer.cornerRadius = CGFloat(5.0)
        textView.editable = canEdit
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
    
}

























