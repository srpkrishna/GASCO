//
//  ApproveActionTVC.swift
//  CustomerApp
//
//  Created by Ashok on 4/5/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class ApproveActionTVC: UITableViewController {
    
    var approveActionItems:[ApproveAction] = approveActionData
    
    var tempActionItems:[ActionElement] = [ActionElement]()
    
    @IBOutlet weak var approveActionTitle: UINavigationItem!
    
    let navTitleFont = UIFont(name: "Lato-black", size: 18)
    
    let loader = LoadingScreen.init();

    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        let navBarColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        let navTitleColor = UIColor(red: 0.078, green: 0.451, blue: 0.749, alpha: 1.00)

        self.navigationController?.navigationBar.barTintColor = navBarColor
        self.navigationController?.title = "Approve Action"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navTitleFont!, NSForegroundColorAttributeName: navTitleColor]
            // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        self.tempActionItems.removeAll()
        self.fetchReport()
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tempActionItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print(self.tempActionItems)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath)

        let item = tempActionItems[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.id
        
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        
        return 66
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myController:ActionViewVC   = storyboard.instantiateViewControllerWithIdentifier("ActionViewVC") as! ActionViewVC
        myController.actionElement = self.tempActionItems[indexPath.row];
        self.navigationController?.pushViewController(myController, animated: true);
    }
    
    func fetchReport() {
        
        loader.showLoading();
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
                        self.tempActionItems.append(act);
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.loader.hideLoading();
            })
        }
        
        
    }

}
