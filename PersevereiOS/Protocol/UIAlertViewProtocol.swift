//
//  UIAlertViewProtocol.swift
//  HYFinanceApp
//
//  Created by zhaoyunyi on 16/4/6.
//  Copyright © 2016年 zhaoyunyi. All rights reserved.
//

import Foundation
import UIKit

public protocol UIAlertViewProtocol {

}

extension UIAlertViewProtocol {
    public func alertViewConfirm(viewController: UIViewController, title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public func alertViewConfirmOperation(viewController: UIViewController, title: String?, message: String?, confirmOperation: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
            confirmOperation()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public func alertViewForceConfirm(viewController: UIViewController, title: String?, message: String?, confirmMsg: String?, confirmOperation: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: confirmMsg, style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
            confirmOperation()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public func alertViewConfirmAndCancel(viewController: UIViewController, title: String?, message: String?, confirmOperation: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
        }))
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            confirmOperation()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public func alertViewConfirmText(viewController: UIViewController, title: String?, message: String?, confirmText: String, confirmOperation: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
        }))
        alert.addAction(UIAlertAction(title: confirmText, style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            confirmOperation()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public func alertViewCancelAndConfirmText(viewController: UIViewController, title: String?, message: String?, cancel: String, confirmText: String, confirmOperation: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
        }))
        alert.addAction(UIAlertAction(title: confirmText, style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            confirmOperation()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public func alertViewCancelAndConfirmOperation(viewController: UIViewController, title: String?, message: String?, cancel: String, confirmText: String, cancelOperation: @escaping () -> Void, confirmOperation: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
            cancelOperation()
        }))
        alert.addAction(UIAlertAction(title: confirmText, style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            confirmOperation()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
