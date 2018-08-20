//
//  PopProtocol.swift
//  HYFinanceApp
//
//  Created by zhaoyunyi on 16/3/27.
//  Copyright © 2016年 zhaoyunyi. All rights reserved.
//

import Foundation
import pop

protocol PopProtocol {
    
}

extension PopProtocol {
    
    /**
     从上方到屏幕中心
     
     - parameter view: 需要移动的视图
     */
    func topToCenterViewPop(view: UIView) {
        let backView = UIApplication.shared.keyWindow!
        backView.addSubview(view)
        view.snp.makeConstraints({ (make) -> Void in
            make.size.equalTo(view.bounds.size)
            make.centerX.equalTo(backView)
            make.bottom.equalTo(backView.snp.top)
        })
        
        if let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY) {
            springAnimation.toValue = backView.center.y
            springAnimation.springBounciness = 3.0
            springAnimation.springSpeed = 3.0
            view.pop_add(springAnimation, forKey: "positionY")
            

            
            springAnimation.completionBlock = {(anima: POPAnimation?, finished: Bool) -> Void in
                if finished {
                    view.snp.removeConstraints()
                    view.snp.makeConstraints({ (make) -> Void in
                        make.size.equalTo(view.bounds.size)
                        make.centerY.equalTo(backView)
                        make.centerX.equalTo(backView)
                        
                    })
                }
            }
        }

    }
    /**
     隐藏视图，从下往上
     
     - parameter view:     需要隐藏的视图
     - parameter maskView: 遮罩视图
     */
    func topToCenterViewHide(view: UIView, maskView: UIView) {
        let backView = UIApplication.shared.keyWindow!
        if let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY) {
            springAnimation.toValue = backView.center.y - backView.height
            springAnimation.springBounciness = 3.0
            springAnimation.springSpeed = 3.0
            
            springAnimation.completionBlock = {(anima: POPAnimation?, finished: Bool) -> Void in
                if finished {
                    view.snp.removeConstraints()
                    view.snp.makeConstraints({ (make) -> Void in
                        make.size.equalTo(view.bounds.size)
                        make.centerX.equalTo(backView)
                        make.bottom.equalTo(backView.snp.top)
                    })
                    maskView.removeFromSuperview()
                }
            }
            
            view.pop_add(springAnimation, forKey: "positionY")
        }
    }
    
    /**
     从右方到屏幕中心
     
     - parameter view: 需要移动的视图
     */
    func rightToCenterViewShow(view: UIView) {
        let backView = UIApplication.shared.keyWindow!
        backView.addSubview(view)
        view.snp.makeConstraints({ (make) -> Void in
            make.height.equalTo(view.height)
            make.width.equalTo(backView.height - 24)
            make.centerY.equalTo(backView).offset(-75)
            make.left.equalTo(backView.snp.right)
        })
        if let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionX) {
            springAnimation.toValue = backView.center.x
            springAnimation.springBounciness = 3.0
            springAnimation.springSpeed = 3.0
            springAnimation.completionBlock = {(anima: POPAnimation?, finished: Bool) -> Void in
                if finished {
                    view.snp.removeConstraints()
                    view.snp.updateConstraints({ (make) -> Void in
                        make.height.equalTo(view.height)
                        make.width.equalTo(backView.height - 24)
                        make.centerY.equalTo(backView).offset(-75)
                        make.centerX.equalTo(backView)
                        
                    })
                }
            }
            view.pop_add(springAnimation, forKey: "positionX")
        }
    }
    
    /**
     隐藏视图，从左往右
     
     - parameter view:     需要隐藏的视图
     - parameter maskView: 遮罩视图
     */
    func rightToCenterViewHide(view: UIView, maskView: UIView) {
        let backView = UIApplication.shared.keyWindow!
        if let backAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionX) {
            backAnimation.toValue = backView.center.x + backView.height
            backAnimation.springBounciness = 3.0
            backAnimation.springSpeed = 3.0
            view.pop_add(backAnimation, forKey: "positionX")
            backAnimation.completionBlock = {(anima: POPAnimation?, finished: Bool) -> Void in
                if finished {
                    view.snp.removeConstraints()
                    view.snp.makeConstraints({ (make) -> Void in
                        make.height.equalTo(view.height)
                        make.width.equalTo(backView.height - 24)
                        make.centerY.equalTo(backView).offset(-75)
                        make.left.equalTo(backView.snp.right)
                    })
                    maskView.removeFromSuperview()
                }
            }
        }
    }
    
    /// 从底部到中心
    func bottomToCenterViewShow(view: UIView) {
        let backView = UIApplication.shared.keyWindow!
        backView.addSubview(view)
        view.frame = CGRect(x: 0, y: backView.frame.maxY, width: backView.frame.width, height: view.height)
        // 使用snp 会有一定异步延迟，导致从最上面滑动到下面
//        view.snp.makeConstraints({ (make) -> Void in
//            make.top.equalTo(backView.snp.bottom)
//            make.left.right.equalTo(backView)
//            make.height.equalTo(view.heightOfFrame)
//        })
        
        if let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY) {
            springAnimation.toValue = backView.height - view.height / 2
            springAnimation.springBounciness = 3.0
            springAnimation.springSpeed = 3.0
            view.pop_add(springAnimation, forKey: "positionY")
            
            springAnimation.completionBlock = {(anima: POPAnimation?, finished: Bool) -> Void in
                if finished {

                }
            }
        }
    }
    
    /// 从底部到中心 - 隐藏
    func bottomToCenterViewHide(view: UIView, maskView: UIView) {
        let backView = UIApplication.shared.keyWindow!
        if let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY) {
            springAnimation.toValue = backView.height + view.height / 2
            springAnimation.springBounciness = 3.0
            springAnimation.springSpeed = 3.0
            
            springAnimation.completionBlock = { (anima: POPAnimation?, finished: Bool) -> Void in
                if finished {

                    maskView.removeFromSuperview()
                }
            }
            view.pop_add(springAnimation, forKey: "positionY")
        }
    }
    
    /// 从屏幕外到底部
    func outToBotttomViewShow(view: UIView) {
        let backView = UIApplication.shared.keyWindow!
        backView.addSubview(view)
        view.frame = CGRect(x: 0, y: backView.frame.maxY, width: backView.frame.width, height: view.height)
//        view.snp.makeConstraints({ (make) -> Void in
//            make.top.equalTo(backView.snp.bottom)
//            make.left.right.equalTo(backView)
//            make.height.equalTo(view.heightOfFrame)
//        })
        
        if let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY) {
            springAnimation.toValue = backView.height - view.height / 2 + 5
            springAnimation.springBounciness = 0
            springAnimation.springSpeed = 2.0
            view.pop_add(springAnimation, forKey: "positionY")
            
            springAnimation.completionBlock = {(anima: POPAnimation?, finished: Bool) -> Void in
                if finished {
                }
            }
        }
    }
    
    func outToBotttomViewHide(view: UIView, maskView: UIView) {
        let backView = UIApplication.shared.keyWindow!
        if let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY) {
            springAnimation.toValue = backView.height + view.height / 2
            springAnimation.springBounciness = 0.5
            springAnimation.springSpeed = 4.0
            
            springAnimation.completionBlock = { (anima: POPAnimation?, finished: Bool) -> Void in
                if finished {
                    view.removeFromSuperview()
                }
            }
            view.pop_add(springAnimation, forKey: "positionY")
        }
    }
}

protocol MaskViewProtocol {

}

extension MaskViewProtocol {
    
    func maskViewShowNoneColor(maskView: UIView) {
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            maskView.alpha = 0.3
        })
    }
    
    func maskViewShow(maskView: UIView) {
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            maskView.alpha = 0.4
        })
    }
    
    func maskViewHide(maskView: UIView) {
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            maskView.alpha = 0
        })
    }
}
