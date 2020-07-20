//
//  RequestLoadingPlugin.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import Moya

/// show or hide the loading hud
public final class RequestLoadingPlugin: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
        /// show loading
            //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        // hide loading
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

// network logger
public final class NetworkLogger: PluginType {
    public func willSend(_ request: RequestType, target: TargetType) {}
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
//        log.info("\(target)")
    }
}

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    
    init (configuration: URLSessionConfiguration, inMemoryCapacity: Int, diskCapacity: Int, diskPath: String?) {
        configuration.urlCache = URLCache(memoryCapacity: inMemoryCapacity, diskCapacity: diskCapacity, diskPath: diskPath)
    }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        
        return request
    }
}
