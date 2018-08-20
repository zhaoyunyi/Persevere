//
//  RequstProtocol.swift
//  NetWork
//
//  Created by zhaoyunyi on 2017/9/27.
//  Copyright © 2017年 fragment. All rights reserved.
//

import Foundation
import Moya

public protocol RequstProtocol {
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: Moya.Method { get }
    
    /// Provides stub data for use in testing.
    var sampleData: Data { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool { get }
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    func overloadFlag() -> Bool 
}
extension RequstProtocol {
    func overloadFlag() -> Bool {
        return false
    }
    
}
