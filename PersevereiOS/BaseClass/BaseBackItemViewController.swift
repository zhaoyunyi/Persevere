//
//  BaseBackItemViewController.swift
//  UIExtend
//
//  Created by zhaoyunyi on 2017/9/25.
//  Copyright © 2017年 tomorning. All rights reserved.
//

import Foundation
import UIKit

open class BaseBackItemViewController: BaseViewController {
    
    // present push 之后的页面业务需要直接dissmiss 进行设置
    open var backItemDismiss: Bool = false
    
    // 返回按钮
    open let backButton = UIButton()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupUI()
        UIApplication.shared.keyWindow?.backgroundColor = .white
    }
    
    @objc
    open func backItemClicked(button: UIButton) {
        
        if backItemDismiss {
            self.dismiss(animated: true, completion: nil)
            return
        }
        if self.navigationController?.viewControllers.count == 1 {
            self.dismiss(animated: true, completion: nil)
        } else {
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            }
        }
    }
    
//    open func hideNavbar() {
//
//        self.navBarBgAlpha = 0
//        self.navBarTintColor = .white
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//    }
//
//    open func setupNavbarColor() {
//    self.navigationController?.navigationBar.setBackgroundImage(R.image.navbar_backColor(), for: UIBarMetrics.default)
//    }
    
    open func setupUI() {
       
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
//        backButton.setImage(R.image.return(), for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(backItemClicked(button:)), for: UIControlEvents.touchUpInside)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        let spaceItem = UIBarButtonItem(customView: UIView())
        spaceItem.width = 16
        let backItem  = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItems = [spaceItem, backItem]
    }
    
    // 只有在iOS11以上的情况
    open override func viewDidLayoutSubviews() {
        let item = self.navigationItem
        if let array = item.leftBarButtonItems, array.count != 0 {
            //这里需要注意,你设置的第一个leftBarButtonItem的customeView不能是空的,也就是不要设置UIBarButtonSystemItemFixedSpace这种风格的item
            let buttonItem = array[0]
            
            if let mineView = buttonItem.customView?.superview?.superview?.superview  {
                let arrayConstraint = mineView.constraints
                //在plus上这个值为20
                for constant in arrayConstraint {
                    let con = fabs(constant.constant) // 去掉右边间距 就不要取绝对值
                    if con == 20 || con == 16 {
                        constant.constant = 0
                    }
                }
            }
        }
    }
}

let bundle = Bundle(for: BaseBackItemViewController.self)

public extension UIImage {
    
    class func myUIImage(name: String) -> UIImage? {
    
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}

//public extension Bundle {
//
//    public class func myBundle(for aClass: Swift.AnyClass) -> Bundle? {
//        Bundle(for: BaseBackItemViewController.self)
//    }
//}

