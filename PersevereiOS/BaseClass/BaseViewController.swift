//
//  BaseViewController.swift
//  Club
//
//  Created by zhaoyunyi on 2018/3/18.
//  Copyright © 2018年 tomorning. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
#endif

open class BaseViewController: UIViewController {
    
    // 中间title标题
    public var navTitleLabel = UILabel()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 165, height: 35)
        navTitleLabel.frame = CGRect(x: 0, y: 0, width: 165, height: 35)
        navTitleLabel.textAlignment = .center
        titleView.addSubview(navTitleLabel)
        navTitleLabel.textColor = UIColor.white
        navTitleLabel.font = UIFont.systemFont(ofSize: 18)
        self.navigationItem.titleView = titleView
        
        
    }
}
