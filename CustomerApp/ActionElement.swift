//
//  ActionElement.swift
//  CustomerApp
//
//  Created by Phani on 19/04/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class ActionElement : NSObject {
    
    let id:String,title:String,taskId:String,props:[String:String];
    
    init(id:String,title:String,taskId:String,props:[String:String])
    {
        self.id = id;
        self.title = title;
        self.taskId = taskId;
        self.props = props;
        
        super.init()
    }
}