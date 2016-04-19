//
//  ActionItems.swift
//  PhotoRama
//
//  Created by Ashok on 4/18/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import Foundation


class ActionItems {
    
    var actionItems:[ActionElement] = [ActionElement]()
    
    //    let session: NSURLSession = {
    //        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    //        config.HTTPAdditionalHeaders = ["Authorization":"M2"]
    //        return NSURLSession(configuration: config)
    //    }()
    //
    //    func handShake() {
    //        let handShakeURL = m2API.handShakeURL()
    //        let request = NSURLRequest(URL: handShakeURL)
    //
    //        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
    //
    //            if let jsonData = data {
    //                if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding){
    //                    print(jsonString)
    //                }
    //            }
    //            else if let requestError = error {
    //                print(" Request Error While HandShaking = \(requestError)")
    //            }
    //            else {
    //                print("UnExpected Error While HandShaking")
    //            }
    //
    //        }
    //        task.resume()
    //    }
    
    func fetchReport() {
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
        serverCall.getData(request){(data) -> Void in
            
            var content:NSMutableDictionary?
            
            do
            {
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? NSMutableDictionary
                
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
                        self.actionItems.append(act);
                    }
                }
            }
            
        }
        
        
    }
    
}