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
        let url = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2.3/pfadmin/handshake")
        return url!
    }
    
    static func getReportsURL() -> NSURL {
        let url = NSURL(string:"http://msi-vmintgasca1/metricstream/m2/2.2/ISM_Admin/reports")
        return url!
    }
    
    static func inputDataURL() -> NSURL {
        let url = NSURL(string: "http://msi-vmintgasca1/metricstream/m2/2.2/ISM_Admin/reports/R-100382/inputdata")
        return url!
    }
    
}

