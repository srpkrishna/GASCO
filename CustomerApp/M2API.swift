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
        let url = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2.3/christineb/handshake")
        return url!
    }
    
    static func getReportsURL() -> NSURL {
        let url = NSURL(string:"http://msi-vmintgasca1/metricstream/m2/2.2/christineb/reports")
        return url!
    }
    
    static func inputDataURL() -> NSURL {
        let url = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2/christineb/reports/R-100802/inputdata")
        return url!
    }
    
    static func actionItemsDataUrl() -> NSURL {
        let url = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2/christineb/reports/R-100802/data")
        return url!
    }
    
    
    
}

