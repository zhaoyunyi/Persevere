//
//  UIConstant.swift
//  UIExtend
//
//  Created by zhaoyunyi on 2017/9/26.
//  Copyright © 2017年 fragment. All rights reserved.
//

import Foundation
import UIKit
import DeviceCheck

public let ScreenHeight: CGFloat = UIScreen.main.bounds.height
public let ScreenWidth: CGFloat = UIScreen.main.bounds.width
public let ScreenSize: CGSize = UIScreen.main.bounds.size
public let ScreenBounds = UIScreen.main.bounds
public let keyWindow = UIApplication.shared.keyWindow

public let topLayoutHeight: CGFloat = 64
public let bottomTabbarHeight: CGFloat = 49

public let mainYellow = UIColor.RGB(red: 244, green: 191, blue: 6)
public let disabYellow = UIColor.colorWithHex(hex: 0xffe493)

public let grayb3 = UIColor.colorWithHex(hex: 0xb3b3b3)

/// 主蓝紫色
public let mainBluePurple = UIColor.colorWithHex(hex: 0xA1AEF8)
/// 浅蓝紫色
public let weakBluePurple = UIColor.colorWithHex(hex: 0xD9B7ff)
public let black333 = UIColor.colorWithHex(hex: 0x333333)

/// 红色
public let redFF12 = UIColor.colorWithHex(hex: 0xFF1212)
public let redFD898f = UIColor.colorWithHex(hex: 0xFD898f)
public let redF5AB86 = UIColor.colorWithHex(hex: 0xF5AB86)

/// 灰色
public let grayd5 = UIColor.colorWithHex(hex: 0xD5D5D3)
public let gray99 = UIColor.colorWithHex(hex: 0x999999)
public let grayeb = UIColor.colorWithHex(hex: 0xfebebeb)
public let grayf4 = UIColor.colorWithHex(hex: 0xf4f4f4)
public let gray77 = UIColor.colorWithHex(hex: 0x777777)
public let grayff = UIColor.colorWithHex(hex: 0xffffff)

func mainColor(width: CGFloat, height: CGFloat) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    
    gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    gradientLayer.colors = [mainBluePurple.cgColor, weakBluePurple.cgColor]
    gradientLayer.locations = [0, 1]
    
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.7, y: 1)
    
    return gradientLayer
}

enum DeviceType {
    case iPhoneX
    case none
}
 
func getDeviceModel() -> DeviceType {
    let device = UIDevice()
    log.debug("设备类型\(device.model)")
    if device.model == "iPhone10,3" || device.model == "iPhone10,6" {
        return DeviceType.iPhoneX
    } else {
        return DeviceType.none
    }
}

func delay(_ delay: Double, closure: @escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

public extension UIButton {
    func mainYellowButton() {
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.RGB(red: 244, green: 191, blue: 6)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.setTitleColor(UIColor.colorWithHex(hex: 0x3333333), for: UIControlState.normal)
    }
    
    func whiteYellowButton(fontSize: CGFloat = 15) {
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = UIColor.RGB(red: 244, green: 191, blue: 6).cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setTitleColor(UIColor.colorWithHex(hex: 0x3333333), for: UIControlState.normal)
    }
    
    func confirmButtonStyle() {
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.setTitleColor(UIColor.colorWithHex(hex: 0x3333333), for: UIControlState.normal)
        self.setBackgroundImage(UIImage.createImage(mainYellow, size: self.size), for: UIControlState.normal)
        self.setBackgroundImage(UIImage.createImage(disabYellow, size: self.size), for: UIControlState.disabled)
    
    }
    
    func confirmButtonStyle(size: CGSize) {
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.setTitleColor(UIColor.colorWithHex(hex: 0x3333333), for: UIControlState.normal)
        self.setBackgroundImage(UIImage.createImage(mainYellow, size: size), for: UIControlState.normal)
        self.setBackgroundImage(UIImage.createImage(disabYellow, size: size), for: UIControlState.disabled)
        
    }
}

public extension UIImage {
    
    public class func createImage(_ color: UIColor, size: CGSize) -> UIImage? {
        
        var rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    public class func generateImageWith(_ color: UIColor, andFrame frame: CGRect) -> UIImage? {
        // 开始绘图
        UIGraphicsBeginImageContext(frame.size)
        
        // 获取绘图上下文
        let context = UIGraphicsGetCurrentContext()
        // 设置填充颜色
        context?.setFillColor(color.cgColor)
        // 使用填充颜色填充区域
        context?.fill(frame)
        
        // 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 结束绘图
        UIGraphicsEndImageContext()
        return image
    }
}
