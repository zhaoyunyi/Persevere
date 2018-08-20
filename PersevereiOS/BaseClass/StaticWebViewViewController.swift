//
//  StaticWebViewViewController.swift
//  HYFinanceApp
//
//  Created by zhaoyunyi on 16/4/22.
//  Copyright © 2016年 zhaoyunyi. All rights reserved.
//

import Foundation

public class StaticWebViewViewController: BaseWebViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let htmlStr = htmlUrl {
            if let url = URL(string: htmlStr) {
                webView.load(URLRequest(url: url))
                webView.allowsBackForwardNavigationGestures = true
                webView.reload()
            }
        }
    }
    
}
