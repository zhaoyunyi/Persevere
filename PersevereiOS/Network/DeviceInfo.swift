//
//  DeviceInfo.swift
//  Club
//
//  Created by Wonderland on 2018/4/17.
//  Copyright © 2018年 tomorning. All rights reserved.
//

import Foundation
import DeviceKit

class DeviceInfo {
    
    // 设备信息
    public var info: Dictionary<String, Any> {
        get {
            return ["IDFA": self.IDFA,
                    "platform": self.platform,
                    "os": self.os,
                    "appVersion": self.appVersion]
        }
    }
    
    public var webInfo: Dictionary<String, Any> {
        get {
            return ["modelName": self.modelName,
                    "osVersion": self.os,
                    "appVersion": self.appVersion]
        }
    }
    
    // app版本号
    public let appVersion: String
    public let IDFA: String
    public let platform: String
    public let os: String
    public let modelName: String

    init() {
        
        appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "none appVersion"
        IDFA = ""
        platform = "iOS"
        os = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
        modelName = "\(UIDevice.current.model)"
    }
    
    
}
