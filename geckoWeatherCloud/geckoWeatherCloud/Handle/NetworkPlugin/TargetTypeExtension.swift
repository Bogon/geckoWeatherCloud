//
//  TargetType+Extension.swift
//  EsNet
//
//  Created by mengqingzheng on 2017/6/5.
//  Copyright © 2017年 es. All rights reserved.
//

import UIKit
import Moya

///app build版本号
fileprivate let appBuildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
///app 版本号
fileprivate let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

/// key
public extension TargetType {

    var cacheKey: String {
        
        let urlStr = baseURL.appendingPathComponent(path).absoluteString
        var sortParams = ""
        var parameter: [String: Any]?
        do{
            let json = try JSONSerialization.jsonObject(with: sampleData, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            parameter = dic
        } catch _ { return urlStr }
        
        guard let params = parameter else {
            return urlStr
        }
        /// sort
        let sortArr = params.keys.sorted { (str1, str2) -> Bool in
            return str1 < str2
        }
        for str1 in sortArr {
            
            if let value = params[str1] {
                if str1 == "longitude" ||  str1 == "latitude" {
                    sortParams = sortParams.appending("\(str1)=")
                } else {
                    sortParams = sortParams.appending("\(str1)=\(value)")
                }
            } else {
                
            }
        }
        return urlStr.appending("?\(sortParams)/\(appVersion!)/\(appBuildVersion!)")
    }
}
