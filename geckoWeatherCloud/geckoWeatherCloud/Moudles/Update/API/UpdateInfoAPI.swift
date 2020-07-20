//
//  UpdateInfoAPI.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/7/13.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

fileprivate var basedURL: String {
    return "https://charsblogs.leanapp.cn"
}

enum UpdateInfoAPI {
    
    /// 获取更新信息
    case update
}

extension UpdateInfoAPI: TargetType {

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
            case .update:
                return "/1.1/classes/userupdate/5f0c665829898400061dca8c"
        }
    }
    
    /// 设置请求方式
    public var method: Moya.Method {
        switch self {
            case .update:
                return .get
        }
    }
    
    /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
           
            case .update:
                return nil
        }
    }
    
    /// Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        switch self {
            case .update:
                return ["1":"1"].jsonData()!
        }
    }
    
    // Represents an HTTP task.
    public var task: Task {
        switch self {
            case .update:
                return .requestPlain
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        // Select type of parameter encoding based on requirements.Usually we use 'URLEncoding.default'.
        switch self {
            case .update:
                return URLEncoding.queryString
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
}
