//
//  ToastProtocol.swift
//  Club
//
//  Created by Wonderland on 2018/3/28.
//  Copyright © 2018年 tomorning. All rights reserved.
//

import Foundation
import Toast_Swift
import MBProgressHUD

protocol ToastProtocol {
    
}



extension ToastProtocol {
    
    func showSuccessToast(text: String) {
//        ToastManager.shared.isTapToDismissEnabled = false
        if let view = UIApplication.shared.keyWindow {
            view.makeToast(text, position: .center)
        }
        ToastManager.shared.duration = 2
        ToastManager.shared.style.messageAlignment = .center
    }
    
    func showFailedToast(text: String?) {
        //        ToastManager.shared.isTapToDismissEnabled = false
        if let view = UIApplication.shared.keyWindow {
            view.makeToast(text, position: .center)
        }
        
    }
    
    func showLoadingToast(view: UIView) {
        
//        if let view = UIApplication.shared.keyWindow {
        
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(12) {
            MBProgressHUD.hide(for: view, animated: true)
        }
//        view.makeToastActivity(.center)
        
//        }
    }
    
    func hideLoadingToast(view: UIView) {
//        view.hideToastActivity()
        MBProgressHUD.hide(for: view, animated: true)
    }
}

