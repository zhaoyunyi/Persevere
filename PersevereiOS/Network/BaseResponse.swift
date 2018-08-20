//
//  BaseResponse.swift
//  NetWork
//
//  Created by zhaoyunyi on 2017/9/27.
//  Copyright © 2017年 fragment. All rights reserved.
//

import Foundation
import ObjectMapper

public struct BaseResponse<T: Mappable>: Mappable, ResultProcol {
    public var msg: String?
    public var ret: Int?
    public var result: T?
    
    public var requestState: APICodeType {
        get {
            return self.requestState(code: self.ret)
        }
    }
    
    public init?(map: Map) {
        
    }

    
    // Mappable
    mutating public func mapping(map: Map) {
        msg         <- map["msg"]
        ret         <- map["ret"]
        result      <- map["result"]
    }
}

public struct ListResult<T: Mappable>: Mappable {
    
    public var content: [T]?
    
    public init?(map: Map) {

    }
    
    public mutating func mapping(map: Map) {
        content                 <- map["templates"]
        content                 <- map["banner"]
        
        content                 <- map["messages"]
        content                 <- map["rooms"]
        content                 <- map["users"]
        content                 <- map["checkIns"]
        
        content                 <- map["wishCommentVoList"]
        
    }

}

public struct ResponseArray<T: Mappable>: Mappable, ResultProcol {
    public var msg: String?
    public var ret: Int?
    public var result: [T]?
    
    public var requestState: APICodeType {
        get {
            return self.requestState(code: self.ret)
        }
    }
    
    public init?(map: Map) {
        
    }
    
    
    // Mappable
    mutating public func mapping(map: Map) {
        msg         <- map["msg"]
        ret         <- map["ret"]
        result      <- map["result"]
    }
}

public struct ResponseString: Mappable, ResultProcol {
    public var msg: String?
    public var ret: Int?
    public var result: String?
    
    public var requestState: APICodeType {
        get {
            return self.requestState(code: self.ret)
        }
    }
    
    public init?(map: Map) {
        
    }
    
    // Mappable
    mutating public func mapping(map: Map) {
        msg         <- map["msg"]
        ret         <- map["ret"]
        result      <- map["result"]
    }
}

public protocol ResultProcol {
    
}

extension ResultProcol {
    
    func requestState(code: Int?) -> APICodeType {
        if let codeState = code {
            switch codeState {
            case 0:
                return APICodeType.success
            case 0x00000002: // 用户Session 验证不合法
                let imp = UserInfoImp()
                imp.userSessionOverTime()
            default:
                break
            }
        }
        return APICodeType.failed
    }
}

public enum APICodeType {
    case success    // 业务处理成功
    case failed     // 业务处理失败
}

// 返回错误码列表
public enum ErrorCode: String {
    case noRefund = "C1003"
}


public struct TokenResult<T: Mappable>: Mappable, ResultProcol {
    public var msg: String?
    public var code: Int?
    public var errorCode: String?
    public var data: T?
    public var token: String?
    public var refresh_token: String?
    
    public var requestState: APICodeType {
        get {
            return self.requestState(code: self.code)
        }
    }
    
    public init?(map: Map) {
        
    }
    
    // Mappable
    public mutating  func mapping(map: Map) {
        msg                  <- map["msg"]
        code                 <- map["code"]
        errorCode            <- map["errorCode"]
        data                 <- map["data"]
        token                <- map["token"]
        refresh_token        <- map["refresh_token"]
    }
}

public enum ObserverError: Error {
    case noneUUID
    case noneUid
    case jsonErrorUserTags
    case noneEarlistTime
    // 不是200
    case requesFailure
}

