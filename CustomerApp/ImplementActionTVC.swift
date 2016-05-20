//
//  improveActionTVC.swift
//  CustomerApp
//
//  Created by Ashok on 5/11/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class ImplementActionTVC: UITableViewController {
    
    var openItems:[ActionElement] = [ActionElement]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Implement Action"
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
        return self.openItems.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath)
        
        let item = openItems[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.id
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myController:ImplementActionVC   = storyboard.instantiateViewControllerWithIdentifier("ImplementActionVCID") as! ImplementActionVC
        myController.actionElement = self.openItems[indexPath.row];
        self.navigationController?.pushViewController(myController, animated: true);
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
