
import UIKit

class ImplementActionVC: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    let loader = LoadingScreen.init();
    var actionElement: ActionElement?
    var jsonDict:NSMutableDictionary?
    
    @IBOutlet weak var actionApprovalBY: UITextField!
    @IBOutlet weak var actionOwner: UITextField!
    @IBOutlet weak var actionStartDate: UITextField!
    @IBOutlet weak var actionDueDate: UITextField!
    @IBOutlet weak var originalActionDueDate: UITextField!
    @IBOutlet weak var priority: UITextField!
    
    @IBOutlet weak var actionDescriptionTextView: UITextView!
    @IBOutlet weak var workDoneTextView: UITextView!
    @IBOutlet weak var results: UITextView!
    @IBOutlet weak var commentsTextView: UITextView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var sendForApproval: UILabel!
    @IBOutlet weak var sendForReview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        customizeTextField(actionApprovalBY, canEdit: false)
        customizeTextField(actionOwner, canEdit: false)
        customizeTextField(actionStartDate, canEdit: false)
        customizeTextField(actionDueDate, canEdit: false)
        customizeTextField(originalActionDueDate, canEdit: false)
        customizeTextField(priority, canEdit: false)

        //TextView Customization
        customizeTextView(actionDescriptionTextView, canEdit: true, tag: 1000)
        customizeTextView(workDoneTextView, canEdit: true, tag: 1001)
        customizeTextView(results, canEdit: true, tag: 1002)
        customizeTextView(commentsTextView, canEdit: true, tag: 1003)
        
        
        
       //TabBar Customization
        let sendForApprovalTapGesture = UITapGestureRecognizer(target: self, action: "didSelectActionItem:")
        addTapGestureForTabBar(sendForApprovalTapGesture, label: sendForApproval, tag: 32)
        
        let sendForReviewTapGesture = UITapGestureRecognizer(target: self, action: "didSelectActionItem:")
        addTapGestureForTabBar(sendForReviewTapGesture, label: sendForReview, tag: 31)
        
        //ScrollView
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        
        let dismissKeyBoard = UITapGestureRecognizer(target: self, action: "dismissKeyBoardOnTapofView:")
        self.view.addGestureRecognizer(dismissKeyBoard)
        
        getForm();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Implement Action"
    }
    
    //TextField Customization
    func customizeTextField(textField: UITextField, canEdit: Bool){
        textField.placeholder = ""
        textField.userInteractionEnabled = canEdit
    }
    
    //TextView Customization
    func customizeTextView(textView: UITextView, canEdit: Bool, tag: Int){
        textView.delegate = self
        textView.layer.borderWidth = CGFloat(1.0)
        textView.layer.borderColor = UIColor.grayColor().CGColor
        textView.layer.cornerRadius = CGFloat(5.0)
        textView.editable = canEdit
        textView.tag = tag
    }
    
    //TabBar Customization
    func addTapGestureForTabBar(tap: UITapGestureRecognizer, label: UILabel, tag: Int) {
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        label.userInteractionEnabled = true
        label.font = UIFont(name: "Lato-Bold", size: 16)
        label.tag = tag
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyBoardOnTapofView(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    //UITextViewDelegate
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.tag == 1003 {
            animateViewMoving(true, moveValue: 100)
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.tag == 1003 {
            animateViewMoving(false, moveValue: 100)
        }
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
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
        }else
        {
            var object = [String:String]();
            let val = self.commentsTextView.text;
            object.updateValue(val, forKey: "value")
            content?.setObject(object, forKey: "ACTION_COMMENTS");
            
        }
        
        if let Obj = content!["ACTION_RESULTS"] as? NSMutableDictionary
        {
            let object = Obj.mutableCopy();
            let val = self.results.text;
            object.setObject(val, forKey: "value")
            content?.setObject(object, forKey: "ACTION_RESULTS");
        }else
        {
            var object = [String:String]();
            let val = self.results.text;
            object.updateValue(val, forKey: "value")
            content?.setObject(object, forKey: "ACTION_RESULTS");
            
        }
        
        if let Obj = content!["ACTION_WORK_DONE"] as? NSMutableDictionary
        {
            let object = Obj.mutableCopy();
            let val = self.workDoneTextView.text;
            object.setObject(val, forKey: "value")
            content?.setObject(object, forKey: "ACTION_WORK_DONE");
        }else
        {
            var object = [String:String]();
            let val = self.workDoneTextView.text;
            object.updateValue(val, forKey: "value")
            content?.setObject(object, forKey: "ACTION_WORK_DONE");
            
        }
        
        if let Obj = content!["ACTION_DETAILS"] as? NSMutableDictionary
        {
            let object = Obj.mutableCopy();
            let val = self.actionDescriptionTextView.text;
            object.setObject(val, forKey: "value")
            content?.setObject(object, forKey: "ACTION_DETAILS");
        }
        
        if let Obj = content!["CUSTOM_FIELD1"] as? NSMutableDictionary
        {
            let object = Obj.mutableCopy();
            object.setObject("1", forKey: "value")
            content?.setObject(object, forKey: "CUSTOM_FIELD1");
        }
        if let Obj = content!["PREVIOUS_STAGE"] as? NSMutableDictionary
        {
            let object = Obj.mutableCopy();
            object.setObject("20", forKey: "value")
            content?.setObject(object, forKey: "PREVIOUS_STAGE");
        }
        if let Obj = content!["DD_PROCESS_CODE"] as? NSMutableDictionary
        {
            let object = Obj.mutableCopy();
            object.setObject("ISM", forKey: "value")
            content?.setObject(object, forKey: "DD_PROCESS_CODE");
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
            
            let string1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(string1)
            
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
                
                
//                self.actionTitle.text = self.actionElement?.title;
//                
//                if let Obj = content!["ISSUE_TITLE"] as? NSDictionary
//                {
//                    self.issueTitle.text = Obj["value"] as? String;
//                    
//                }
                
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
                
                if let obj = content!["ACTION_APPROVER2"] as? NSDictionary
                {
                    let user = obj["value"] as? String;
                    
                    if let users = resources!["MS_ISM_Users_All_12"] as? NSDictionary
                    {
                        if let valObj = users[user!] as? NSDictionary
                        {
                            self.actionApprovalBY.text = valObj["value"] as? String;
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
                
                if let Obj = content!["ORIG_ACTION_DUE_DT"] as? NSDictionary
                {
                    if let date:String = Obj["value"] as? String
                    {
                        self.originalActionDueDate.text = date;
                    }
                   
                }
                
                if let Obj = content!["ACTION_PRIORITY"] as? NSDictionary
                {
                    
                    let user = Obj["value"] as? String;
                    
                    if let users = resources!["MS 001 ISM Common LOV Infolet_19"] as? NSDictionary
                    {
                        if let valObj = users[user!] as? NSDictionary
                        {
                            self.priority.text = valObj["value"] as? String;
                        }
                    }
                    
                }
                
                if let Obj = content!["ACTION_RESULTS"] as? NSDictionary
                {
                    self.results.text = Obj["value"] as? String;
                    
                }
                
                if let Obj = content!["ACTION_COMMENTS"] as? NSDictionary
                {
                    self.commentsTextView.text = Obj["value"] as? String;
                    
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
