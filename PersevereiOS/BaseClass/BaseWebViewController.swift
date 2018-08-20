//
//  BaseWebViewController.swift
//  HYFinanceApp
//
//  Created by zhaoyunyi on 16/3/30.
//  Copyright © 2016年 zhaoyunyi. All rights reserved.
//

import Foundation
import WebKit
import UIKit
import SnapKit

open class BaseWebViewController: BaseBackItemViewController, WKNavigationDelegate, WKUIDelegate, UIAlertViewProtocol {
    open var titleName: String?
    open var webView = WKWebView()
    open var progress = UIProgressView()
    open let webKey = "estimatedProgress"
//    var htmlUrl: String? = "http://wapbaike.baidu.com/?adapt=1&"
    open var htmlUrl: String? = nil
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        webView.addObserver(self, forKeyPath: webKey, options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        if let title = titleName {
//            self.navigationItem.title = title
            self.navTitleLabel.text = title
        }
    }
    
    private func setupWebView() {
//        setupUserAgent()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.bottom.left.right.equalTo(view)
        }
        
        setupProgressView()

    }
    
    private func setupUserAgent() {
        if #available(iOS 9.0, *) {
            webView.customUserAgent = "zhongguoyidiandoubunengshao"
        } else {
            // Fallback on earlier versions
            UserDefaults.standard.register(defaults: ["UserAgent": "zhongguoyidiandoubunengshao"])
        }
    }
    
    private func setupProgressView() {
        progress.trackTintColor = UIColor.white
        progress.tintColor = UIColor.blue
        self.view.addSubview(progress)
        progress.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let webView = object as? WKWebView, let key = keyPath, let dictChange = change {
            if webView == self.webView && key == self.webKey {
                if let newProgressValue = dictChange[NSKeyValueChangeKey.newKey] as? Float {
                    //                    if newProgressValue == 1 {
                    //                        progress.hidden = true
                    //
                    //                    } else {
                    //                        progress.hidden = false
                    //                        progress.setProgress(1.0 - newProgressValue, animated: true)
                    //                    }
                    progress.setProgress(newProgressValue, animated: true)
                    if newProgressValue == 1 {
                        UIView.animate(withDuration: 0.3, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {[weak self] () -> Void in
                            self?.progress.alpha = 0.0
                        }) {[weak self] (Bool) -> Void in
                            self?.progress.setProgress(0.0, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    open func removeWebViewDelegate() {
        // 去除一开始初始化的webView
        self.webView.uiDelegate = nil
        self.webView.navigationDelegate = nil
        self.webView.removeObserver(self, forKeyPath: webKey)
    }
    
    open func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void) {
        
        self.alertViewConfirmOperation(viewController: self, title: message, message: nil) { 
            completionHandler()
        }
    }
    
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progress.alpha = 1.0
    }
    
    @nonobjc func webView(_ webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        progress.setProgress(1, animated: true)
    
    }
    
    @nonobjc func webView(_ webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: Error) {
    }
    
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: webKey)
    }
}
