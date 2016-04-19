//
//  M2API.swift
//  PhotoRama
//
//  Created by Ashok on 4/18/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import Foundation


struct m2API {
    
    static func handShakeURL() -> NSURL{
        let url = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2.3/christineh/handshake")
        return url!
    }
    
    static func getReportsURL() -> NSURL {
        let url = NSURL(string:"http://msi-vmintgasca1/metricstream/m2/2.2/christineh/reports")
        return url!
    }
    
    static func inputDataURL() -> NSURL {
        let url = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2/christineh/reports/R-100802/inputdata")
        return url!
    }
    
    static func actionItemsDataUrl() -> NSURL {
        let url = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2/christineh/reports/R-100802/data")
        return url!
    }
    
    static func actionDetailsDataUrl(id:String) -> NSURL {
        var stringUrl = "http://msi-vmintgasca1/metricstream/m2/2.2/christineh/tasks/";
        stringUrl = stringUrl.stringByAppendingString(id);
        stringUrl = stringUrl.stringByAppendingString("/form");
        let url = NSURL(string: stringUrl)
        return url!
    }
    
    
    
}

