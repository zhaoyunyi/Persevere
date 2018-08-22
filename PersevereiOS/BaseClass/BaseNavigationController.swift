//
//  BaseNavigationController.swift
//  UIExtend
//
//  Created by zhaoyunyi on 2017/9/25.
//  Copyright © 2017年 tomorning. All rights reserved.
//

import Foundation
import UIKit

open class BaseNavigationController: UINavigationController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = .white
        
        let attributes = [
//            NSForegroundColorAttributeName : blakMain,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19)
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
//        UINavigationBar.appearance().tintColor = black333
        
//        self.navigationBar.setBackgroundImage(R.image.navbar_backColor(), for: UIBarMetrics.default)
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count >= 1 {
            if viewController != self.viewControllers[0] {
                viewController.hidesBottomBarWhenPushed = true
            }
        }
        super.pushViewController(viewController, animated: true)
    }
    

}
