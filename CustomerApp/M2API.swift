//
//  M2API.swift
//  PhotoRama
//
//  Created by Ashok on 4/18/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import Foundation


struct m2API {
    
    static let baseURL = "https://gasco.sandbox.metricstream.com/metricstream/m2/2.2/";
    static var userID = "";
    
    static func getURL(uri:String) -> String
    {
        var stringUrl = baseURL.stringByAppendingString(userID);
        stringUrl = stringUrl.stringByAppendingString(uri);
        
        return stringUrl;
    }
    
    static func handShakeURL(id:String) -> NSURL{
        userID = id;
        let url = NSURL(string: getURL("/handshake"))
        return url!
    }
    
    static func getReportsURL() -> NSURL {
        let url = NSURL(string:getURL("/reports"))
        return url!
    }
    
    static func inputDataURL() -> NSURL {
        let url = NSURL(string: getURL("/reports/R-100908/inputdata"))
        return url!
    }
    
    static func actionItemsDataUrl() -> NSURL {
        let url = NSURL(string: getURL("/reports/R-100908/data"))
        return url!
    }
    
    static func actionDetailsDataUrl(id:String) -> NSURL {
        var stringUrl = getURL("/tasks/");
        stringUrl = stringUrl.stringByAppendingString(id);
        stringUrl = stringUrl.stringByAppendingString("/form");
        let url = NSURL(string: stringUrl)
        return url!
    }
    
    static func actionSubmitUrl(id:String,queryparams:String) -> NSURL {
        var stringUrl =  getURL("/tasks/");
        stringUrl = stringUrl.stringByAppendingString(id);
        stringUrl = stringUrl.stringByAppendingString("/form");
        stringUrl = stringUrl.stringByAppendingString(queryparams);
        let url = NSURL(string: stringUrl)
        return url!
    }
    
    
    
}

