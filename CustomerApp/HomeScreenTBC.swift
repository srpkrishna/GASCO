//
//  actionTabBarController.swift
//  CustomerApp
//
//  Created by Ashok on 5/10/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class HomeScreenTBC: UITabBarController {
    
    let loader = LoadingScreen.init();
    
    @IBOutlet weak var actionTabBar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBarFont = UIFont(name: "Lato-black", size: 14)
        let tabBarItemPostionAdjustmentOffset = UIOffset(horizontal: 4, vertical: -14)
        
        
        let appearance = UITabBarItem.appearance()
        let unSelectedAttributes: [String: AnyObject] = [NSFontAttributeName:tabBarFont!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        let selectedAttributes:[String: AnyObject] = [NSFontAttributeName: tabBarFont!, NSForegroundColorAttributeName:UIColor.orangeColor()]
        appearance.setTitleTextAttributes(unSelectedAttributes, forState: .Normal)
        appearance.setTitleTextAttributes(selectedAttributes, forState: .Selected)
        
        for tabBarItem in self.tabBar.items!
        {
            tabBarItem.titlePositionAdjustment = tabBarItemPostionAdjustmentOffset
        }
        
        let navBarColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        let navTitleColor = UIColor(red: 0.078, green: 0.451, blue: 0.749, alpha: 1.00)
        
        let navTitleFont = UIFont(name: "Lato-black", size: 18)
        self.navigationController?.navigationBar.barTintColor = navBarColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navTitleFont!, NSForegroundColorAttributeName: navTitleColor]
        
        let refresh:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "fetchReport");
        let logout:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "logOut");
        
        self.navigationItem.rightBarButtonItem = refresh;
        self.navigationItem.leftBarButtonItem = logout;
        
        self.fetchReport();
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func logOut()
    {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            appDelegate.restartApp();
        }
    }
    
    func fetchReport() {
        
        loader.showLoading();
        var pendingApprovalItems:[ActionElement] = [ActionElement]()
        var openItems:[ActionElement] = [ActionElement]()
        let reportURL = m2API.actionItemsDataUrl()
        let request = NSMutableURLRequest(URL: reportURL)
        request.HTTPMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do
        {
            if let path = NSBundle.mainBundle().pathForResource("input", ofType: "json")
            {
                if let jsonData = NSData(contentsOfFile: path)
                {
                    let jsonDict = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
                    request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonDict!,options:NSJSONWritingOptions.init(rawValue: 0))
                }
            }
            
        }catch let error as NSError {
            // error handling
            NSLog("error %@", error.description);
        }
        
        let serverCall = HttpCall.init();
        serverCall.getData(request){(data,error) -> Void in
            
            var content:NSMutableDictionary?
            
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
            
//            let string1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(string1)
            
            do
            {
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? NSMutableDictionary
                
                if let contents = jsonDict!["content"] as? NSDictionary
                {
                    content = NSMutableDictionary.init(dictionary: contents);
                }
                
            }
            catch let error as NSError {
                // error handling
                NSLog("error %@", error.description);
            }
            
            //            var actionItems:[ActionElement] = [ActionElement]()
            if let rows:NSArray = content!["rows"]as? NSArray
            {
                for obj : AnyObject in rows {
                    
                    if let rowObject = obj as? NSDictionary
                    {
                        var cell = [String:String]()
                        if let cells = rowObject["cells"] as? NSArray {
                            
                            for colObj : AnyObject in cells {
                                if let cellObj = colObj as? NSDictionary {
                                    
                                    if let id:String = cellObj["id"] as? String
                                    {
                                        if let value:String = cellObj["value"] as? String
                                        {
                                            cell[id] = value;
                                            
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        let act:ActionElement = ActionElement.init(id: cell["ACTION_ID"]!, title: cell["ACTION_TITLE"]!, taskId: cell["TASK_ID"]!, props: cell);
                        
                        if(cell["ACTION_STATUS"]!.caseInsensitiveCompare("Pending Approval") == NSComparisonResult.OrderedSame)
                        {
                            pendingApprovalItems.append(act);
                            
                        }else if(cell["ACTION_STATUS"]!.caseInsensitiveCompare("Open") == NSComparisonResult.OrderedSame)
                        {
                            
                            
                            openItems.append(act);
                            
                        }
                        
                        
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.loader.hideLoading();
                
                if let approveActionTVC = self.childViewControllers[0] as? ApproveActionTVC
                {
                    approveActionTVC.pendingApprovalItems = pendingApprovalItems;
                    approveActionTVC.tableView.reloadData();
                }
                
                if let openActionTVC = self.childViewControllers[1] as? ImplementActionTVC
                {
                    openActionTVC.openItems = openItems;
                    openActionTVC.tableView.reloadData();
                }
                
            })
        }
        
        
    }
}
