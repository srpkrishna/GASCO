//
//  HttpCall.swift
//  CustomerApp
//
//  Created by Phani on 18/04/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import Foundation

class HttpCall
{
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration();
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    
    typealias funType = ( (NSData?,String) -> Void)
    
    
    func getData(urlRequest:NSMutableURLRequest,completion: funType){
        config.timeoutIntervalForRequest = 30.0;
        config.timeoutIntervalForResource = 30.0;
        config.HTTPAdditionalHeaders = ["Authorization" : "M2"];
        let datatask = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print(error?.localizedDescription)
                completion(nil,(error?.localizedDescription)!);
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                print("server call failed with status code ",(response as? NSHTTPURLResponse)?.statusCode)
                
                if((response as? NSHTTPURLResponse)?.statusCode == 404)
                {
                    completion(nil,"No Actions found");
                }else
                {
                    completion(nil,"Internal server error occured");
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                return
            }
            
            completion(data,"")
            
        }
        
        datatask.resume()
        
    }
    
}