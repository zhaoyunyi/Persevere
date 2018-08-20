//
//  RequestAPI.swift
//  HYFinanceApp
//
//  Created by zhaoyunyi on 16/3/15.
//  Copyright © 2016年 zhaoyunyi. All rights reserved.
//

import Foundation
import Moya
import Alamofire
#if !RX_NO_MODULE
    import RxSwift
#endif

public enum RequestAPI {
    case clubAPI(request: RequstProtocol)
    
    case uploadPicture(bucket: String, key: String, fileType: Int)
    
    case allPath(request: RequstProtocol)
}

extension RequestAPI: TargetType {

    
    public var headers: [String : String]? {
        switch self {
        case let .clubAPI(request):
            return request.headers
        case let .allPath(request):
            return request.headers
        default:
            return [:]
        }
    }

    public var baseURL: URL {
        switch self {
        case let .clubAPI(request):
            if request.overloadFlag() {
                return URL(string: wrapRoomRequest(path: baseApiUrl))!
            } else {
                return URL(string:  baseApiUrl)!
            }
        case let .allPath(request):
            
            return URL(string: request.path)!
        default:
            return URL(string: baseApiUrl)!
        }
        return URL(string: baseApiUrl)!
    }
    
    public var path: String {
        switch self {
        case let .clubAPI(request):
            return request.path
            
        case .uploadPicture:
            return "auth/signature/put_signed"
        case let .allPath(request):
            return ""
        }
    }
    

    public var method: Moya.Method {
        switch self {
        case let .clubAPI(request):
            return request.method
        case let .allPath(request):
            return request.method
        case .uploadPicture:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case let .clubAPI(request):
            return request.task
            
        case let .uploadPicture(bucket, key, fileType):
            return .requestParameters(parameters: ["bucket": bucket, "key": key, "fileType": fileType], encoding: Moya.URLEncoding.default)
            
        case let .allPath(request):
            return request.task
        }
    }

    //  单元测试用
    public var sampleData: Data {
        switch self {
            
        case let .clubAPI(request):
            return request.sampleData
        default:
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
}

extension RequestAPI: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType {
        return AuthorizationType.basic
    }

    public var shouldAuthorize: Bool {
        return false
    }

}

