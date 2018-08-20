//
//  RequestConfig.swift
//  CarBlueTooth
//
//  Created by 符小良 on 16/7/25.
//  Copyright © 2016年 zhaoyunyi. All rights reserved.
//

import Foundation
import UIKit
import Moya
//import RxMoya
import Result
import Alamofire
//import User
import enum Result.Result


#if !RX_NO_MODULE
    import RxSwift
#endif

public var tempToken: (flag: Bool, tokenStr: String, userId: String) = (false, "0", "0")

let provider: MoyaProvider<RequestAPI> = MoyaProvider<RequestAPI>(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: MoyaProvider.neverStub, manager: MoyaProvider<RequestAPI>.customAlmofireManager(), plugins: plugins)


public extension MoyaProvider {
    
}

public extension MoyaProvider {
    public final class func defaultEndpointMapping(for target: Target) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
//
//    public final class func defaultRequestMapping(for endpoint: Endpoint<Target>, closure: RequestResultClosure) {
//
//        do {
//            let urlRequest = try endpoint.urlRequest() as URLRequest
//            closure(.success(urlRequest))
//        } catch {
//            closure(.failure(MoyaError.requestMapping(endpoint.url)))
//        }
//    }
    
    public final class func defaultAlamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }
    
    public final class func defaultPlugins() -> [PluginType] {
        let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true), RequestPlugin()]
        return plugins
    }
}

let staticDisposeBag = DisposeBag()

#if ProductRelease
    let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: false), RequestPlugin()]
#else
    let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true), RequestPlugin()]
#endif
//let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)]

public let endpointClosure = { (target: RequestAPI) -> Endpoint in
    
    let session = SessionManager.shared.session
    // 此处拼接会带/ 导致下载 file 404
    var url = target.baseURL.appendingPathComponent(target.path).absoluteString + "?session=" + session
    
    switch target {
    case .allPath:
        url = target.baseURL.absoluteString + "?session=" + session
    default:
        break
    }
//    var loginToken = ""
//    var userId = ""
    
//    let requetHeadField = RequestHeadField()

//    if tempToken.flag {
//        loginToken = tempToken.tokenStr
//        userId = tempToken.userId
//    } else {
//        if let token = requetHeadField.currentUserToken() {
//            loginToken = token
//        }
//        userId = requetHeadField.currentUserId()
//    }
    var endpoint: Endpoint = Endpoint(url: url,
                         sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                         method: target.method, task: target.task,
                         httpHeaderFields: [
//                            "X-AuthToken": loginToken,
//                            "X-User": userId,
                            "Content-Type": "application/json"
                            ])
    
//    let requetHeadField = RequestHeadField()
//    switch target {
////    case .refreshUserToken:
////        // 获取用户
////        if let refreshTokenStr = requetHeadField.getUserTokenStorage()?.refresh_token {
////            endpoint = endpoint.adding(parameters: [:], httpHeaderFields: ["X-Refresh": refreshTokenStr])
////        }
//    default:
//        // 获取用户
//        if let session = requetHeadField.currentUserSession() {
//            endpoint = endpoint.adding(newHTTPHeaderFields: <#T##[String : String]#>)
//        }
//    }
    
    //    // 定义验签所需模型
    //    var httpHeadFieldModel = HttpHeadFieldModel(apiUrl: url, method: target.method, parameters: target.parameters)
    //    // 给其他参数赋值
    //    httpHeadFieldModel.initWithDefault()
    //    Log.ZLog(target.parameters)
    
    return endpoint
}


public final class RequestPlugin: PluginType {
    
    func willSend(request: RequestType, target: TargetType) {
        
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
    }
}



// 请求配置 可以在这里做请求之前的判断逻辑并取消该操作，如果不需要影响请求适合使用插件进行
public let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    
    do {
        let urlRequest = try endpoint.urlRequest() as URLRequest
        done(.success(urlRequest))
    } catch {
        done(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

extension MoyaProvider {
    /// 自定义almofire 配置
    public class func customAlmofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 20
        //        ServerTrustPolicyManager()
        //        Manager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
        
        //        let manager = Manager(configuration: configuration)
        //        manager.session.servertru
        
//        let policies: [String: ServerTrustPolicy] = [
//                        "https://api-port-1.mjtest.hy378.com": .pinCertificates(
//                            certificates: ServerTrustPolicy.certificates(in: Bundle.main),
//                            validateCertificateChain: false,
//                            validateHost: false
//                        )
//                        ,
//            //            "https://api-port-1.mjtest.hy378.com": .DisableEvaluation
//            //            ,
//            //            "https://api-port-1.mjtest.hy378.com": .PerformDefaultEvaluation(validateHost: true)
//            ]
        
        
        let manager = Manager(
            configuration: configuration,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )
        manager.startRequestsImmediately = false

        return manager
    }
}

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        
        return .disableEvaluation
    }
    
    public init() {
        super.init(policies: [
            
            "https://v270.ddprod.fragment.com.cn/rest/": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(in: Bundle.main),
                validateCertificateChain: false,
                validateHost: false
            )
//            "https://test.fragment.com.cn": .pinCertificates(
//                certificates: ServerTrustPolicy.certificates(),
//                validateCertificateChain: false,
//                validateHost: true)
            ])
    }
}

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: [])
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

// 自定义 http body 对应参数
typealias MyAPICallCustomEncoding = (URLRequestConvertible, [String:AnyObject]?) -> (NSMutableURLRequest, NSError?)

let MyAPICallCustomEncodingClosure: MyAPICallCustomEncoding = { request, data in
    let sort = URLQueryItem(name: "sort", value: "distance")
    var req = request as! NSMutableURLRequest
    
    guard var components = URLComponents(string: req.url!.absoluteString)
        else {
            // even though this is an error, Alamofire ignores the returned error.
            return (req, nil)
    }
    //Create our query string params
//    components.queryItems = [sort]
    req.url = components.url
    
    //Add our JSON body
    do {
        let json = try JSONSerialization.data(withJSONObject: data!, options: JSONSerialization.WritingOptions.prettyPrinted)
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.httpBody = json
        
        
    } catch {
        return (req, nil)
    }
    
    return (req, nil)
}

struct JsonArrayEncoding: Moya.ParameterEncoding {
    
    public static var `default`: JsonArrayEncoding { return JsonArrayEncoding() }
    
    
    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `AFError.parameterEncodingFailed` error if encoding fails.
    ///
    /// - returns: The encoded request.
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var req = try urlRequest.asURLRequest()
//        if let json = parameters!["model"] as? String {}
        
        if let json = parameters!["model"] as? String {
            let data = json.data(using: String.Encoding.utf8)
            req.httpBody = data
        }
//        let json = try JSONSerialization.data(withJSONObject: parameters!["model"]!, options: JSONSerialization.WritingOptions.prettyPrinted)
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        return req
    }
    
}


