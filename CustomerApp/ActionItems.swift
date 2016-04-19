//
//  ActionItems.swift
//  PhotoRama
//
//  Created by Ashok on 4/18/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import Foundation


class ActionItems {
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Authorization":"M2"]
        return NSURLSession(configuration: config)
    }()
    
    func handShake() {
        let handShakeURL = m2API.handShakeURL()
        let request = NSURLRequest(URL: handShakeURL)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding){
                    print(jsonString)
                }
            }
            else if let requestError = error {
                print(" Request Error While HandShaking = \(requestError)")
            }
            else {
                print("UnExpected Error While HandShaking")
            }
            
        }
        task.resume()
    }
    
    func fetchReport() {
        let reportURL = m2API.getReportsURL()
        let request = NSURLRequest(URL: reportURL)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if let jsonData = data {
                
                if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding){
                    
                    let internalURL = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2/ISM_Admin/reports/R-100382/inputdata")
                    let internalRequest = NSURLRequest(URL: internalURL!)
                    
                    let internalTask = self.session.dataTaskWithRequest(internalRequest) { (data, response, error) -> Void in
                        
                        if let jsonData = data {
                            if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding){
                                print(jsonString)
                            }
                        }
                        else if let requestError = error {
                            print(" InternalTask Request Error While HandShaking = \(requestError)")
                        }
                        else {
                            print("InternalTask UnExpected Error While HandShaking")
                        }
                        
                    }
                    internalTask.resume()
                    
                    
                }
            }
            else if let requestError = error {
                print("Request Error While Fetching Reports = \(requestError)")
            }
            else {
                print("UnExpected While Fetching Reports")
            }
            
        }
        task.resume()

    }
    
}