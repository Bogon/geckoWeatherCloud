//
//  JobInfoAPI.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

fileprivate var basedURL: String {
    return "https://app.58.com"
}

enum JobInfoAPI {
    
    /// 获取兼职信息
    case jobInfo(url: String, value: [String: Any]?)
}

extension JobInfoAPI: TargetType {

    /// 网络请求头设置
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type" : "application/json; charset=utf-8"]
        }
    }
    
    /// 网络请求基地址
    public var baseURL: URL {
        return URL(string: basedURL)!
    }
    
    /// 网络请求路径
    public var path: String {
        switch self {
            case .jobInfo(let url, _):
                return "/api/detail/\(url)"
        }
    }
    
    /// 设置请求方式
    public var method: Moya.Method {
        switch self {
            case .jobInfo:
                return .get
        }
    }
    
    /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
           
        case .jobInfo(_, let value):
                return value
        }
    }
    
    /// Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        switch self {
            case .jobInfo(_, let value):
                return value!.jsonData()!
        }
    }
    
    // Represents an HTTP task.
    public var task: Task {
        switch self {
            case .jobInfo:
                return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        // Select type of parameter encoding based on requirements.Usually we use 'URLEncoding.default'.
        switch self {
            case .jobInfo:
                return URLEncoding.queryString
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
}
