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
    
    var actionItems: ActionItems!
    
    @IBOutlet weak var approveActionTitle: UINavigationItem!
    
    let navTitleFont = UIFont(name: "Lato-black", size: 18)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionItems = ActionItems()
        
        actionItems.fetchReport()
        

        let navBarColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        let navTitleColor = UIColor(red: 0.078, green: 0.451, blue: 0.749, alpha: 1.00)

        self.navigationController?.navigationBar.barTintColor = navBarColor

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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return approveActionItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath)

        let approveActionItem = approveActionItems[indexPath.row] as ApproveAction
        
        cell.textLabel?.text = approveActionItem.title
        cell.detailTextLabel?.text = approveActionItem.subTitle
//        cell.detailTextLabel?.frame.size.height = (cell.textLabel?.frame.size.height)! + 175
//        cell.detailTextLabel?.backgroundColor = UIColor.brownColor()

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

}
