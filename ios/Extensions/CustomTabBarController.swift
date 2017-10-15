//
//  CustomTabBarController.swift
//  ios
//
//  Created by JO10X on 10/15/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items?.forEach({ (item) in
            item.imageInsets = UIEdgeInsets(top:6,left:0,bottom:-6,right:0)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 1000)
        })
    }
    
}
