//
//  actionTabBarController.swift
//  CustomerApp
//
//  Created by Ashok on 5/10/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class HomeScreenTBC: UITabBarController {
    
    
    @IBOutlet weak var actionTabBar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBarFont = UIFont(name: "Lato-black", size: 14)
        let tabBarItemPostionAdjustmentOffset = UIOffset(horizontal: 4, vertical: -14)
        
        let appearance = UITabBarItem.appearance()
        let attributes: [String: AnyObject] = [NSFontAttributeName:tabBarFont!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        appearance.setTitleTextAttributes(attributes, forState: .Normal)
        
        for tabBarItem in self.tabBar.items!
        {
            tabBarItem.titlePositionAdjustment = tabBarItemPostionAdjustmentOffset
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
