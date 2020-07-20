//
//  RealTimeWeatherInfoAPI.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

fileprivate var basedURL: String {
    return "http://weatapi.hellogeek.com"
}

enum RealTimeWeatherInfoAPI {
    
    /// 获取全部的天气信息
    case weatherInfo(value: [String: Any]?)
}

extension RealTimeWeatherInfoAPI: TargetType {

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
            case .weatherInfo:
                return "/weatapi/data/base"
        }
    }
    
    /// 设置请求方式
    public var method: Moya.Method {
        switch self {
            case .weatherInfo:
                return .get
        }
    }
    
    /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
           
            case .weatherInfo(let value):
                return value
        }
    }
    
    /// Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        switch self {
            case .weatherInfo(let value):
                return value!.jsonData()!
        }
    }
    
    // Represents an HTTP task.
    public var task: Task {
        switch self {
            case .weatherInfo:
                return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        // Select type of parameter encoding based on requirements.Usually we use 'URLEncoding.default'.
        switch self {
            case .weatherInfo:
                return URLEncoding.queryString
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
}
