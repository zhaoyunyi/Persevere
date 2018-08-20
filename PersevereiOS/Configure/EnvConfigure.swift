//
//  EnvConfigure.swift
//  Club
//
//  Created by Wonderland on 2018/3/19.
//  Copyright © 2018年 tomorning. All rights reserved.
//

import Foundation
import XCGLogger
public let http_port = 17080
public let room_socket_host = "120.26.204.58"
public let room_socket_port: UInt16 = 33000

public let TencentKey: String = "1106812837"
public let WeChatKey: String = "wx9fda14bd36eee907"
public let WeChatSecret: String = "010421ce09538d686e08a481d31b0f5b"
public let WeiBoKey: String = "185701850"
public let WeiBoSecret: String = "37978d276dd01e5b8aed6efc019d9d71"


public let preHttp = "/w/club/v1"

#if Debug               // 开发环境 调试模式
public let currentEnvironment = "开发环境 调试模式"
public let logLevel           = XCGLogger.Level.debug
public let baseApiUrl = "http://120.26.204.58:\(http_port)/w/club/v1"

#elseif Release         // 开发环境 发布模式
public let currentEnvironment = "开发环境 发布模式"
public let logLevel           = XCGLogger.Level.debug
public let baseApiUrl = "http://120.26.204.58:\(http_port)/w/club/v1"

#elseif TestDebug       // 测试环境 调试模式
public let currentEnvironment = "测试环境 调试模式"
public let logLevel           = XCGLogger.Level.warning
public let baseApiUrl = "https://test.tomorning.me/w/club/v1"

#elseif TestRelease     // 测试环境 发布模式
public let currentEnvironment = "测试环境 发布模式"
public let logLevel           = XCGLogger.Level.warning
public let baseApiUrl = "https://test.tomorning.me/w/club/v1"

#elseif ProductDebug    // 生产环境 调试模式
public let currentEnvironment = "生产环境 调试模式"
public let logLevel           = XCGLogger.Level.severe
public let baseApiUrl = "https://club.tomorning.com.cn:17080/w/club/v1"

#elseif ProductRelease  // 生产环境 发布模式
public let currentEnvironment = "生产环境 发布模式"
public let logLevel           = XCGLogger.Level.error
public let baseApiUrl = "https://club.tomorning.com.cn:17080/w/club/v1"

#else
public let currentEnvironment = "其他环境"
public let logLevel           = XCGLogger.Level.debug
public let baseApiUrl = "http://120.26.204.58:\(http_port)/w/club/v1"

#endif

// 数据库的目录
public let userDataDirectory: String = NSHomeDirectory() + "/Documents/UserData/"
