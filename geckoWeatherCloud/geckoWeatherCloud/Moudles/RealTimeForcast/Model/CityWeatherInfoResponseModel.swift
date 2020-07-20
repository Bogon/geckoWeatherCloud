//
//  CityWeatherInfoResponseModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper

class CityWeatherInfoResponseModel: NSObject, Mappable {
    var code: Int?
    var msg: String?
    var data: [String: [String: Any]]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code        <- map["code"]
        msg         <- map["msg"]
        data        <- map["data"]
    }
    
    override init() {
        super.init()
    }

    /**********************************|  构造数据类型：实时天气模型  |******************************/
    /** 将天气详情Json字符串转成Json */
    var weatherContentValue: [String: Any]?  {
        
        guard let realtimedata = data?["realTime"] else {
            return [:]
        }
        guard let realtimeContent = realtimedata["content"]  else {
            return [:]
        }

        if ((realtimedata["content"] as Any) as AnyObject).isKind(of: NSArray.self) {
            return [:]
        }

        /** 1、将数据进行base64解码 2、使用gzip进行解码，获取解码后的数据 3、将二进制数据数据转成字符串 */
        let decodeWeatherContent: Data = GTMBase64.decode((realtimeContent as! String))!
        let uncompressWeatherData: Data = decodeWeatherContent.gzipUncompress()
        let weatherContentStr =  String(data: uncompressWeatherData, encoding: String.Encoding.utf8)
        let weatherList:[String: Any] = weatherContentStr?.getDictionaryFromJSONString() as! [String : Any]

        return weatherList
    }

    /** 构建实时天气模型 */
    var realTimeInfoModel: RealtimeWeatherInfoModel? {
        guard let realtimeInfo = weatherContentValue else {
            return RealtimeWeatherInfoModel()
        }
        return RealtimeWeatherInfoModel.init(JSON: realtimeInfo)
    }


    /**********************************|  构造数据类型：72小时天气模型  |******************************/
    /** 将天气详情Json字符串转成Json */
    var senventyTwoWeatherContentValue: [String: Any]?  {
        guard let seventyTwodata = data?["seventyTwoHours"] else {
            return [:]
        }

        if ((seventyTwodata["content"] as Any) as AnyObject).isKind(of: NSArray.self) {
            return [:]
        }

        if (seventyTwodata["content"] as! String).length == 0 {
            return [:]
        }

        let seventyTwoContent: String = seventyTwodata["content"] as! String
        /** 1、将数据进行base64解码 2、使用gzip进行解码，获取解码后的数据 3、将二进制数据数据转成字符串 */
        let decodeWeatherContent: Data = GTMBase64.decode(seventyTwoContent)!
        let uncompressWeatherData: Data = decodeWeatherContent.gzipUncompress()
        let weatherContentStr =  String(data: uncompressWeatherData, encoding: String.Encoding.utf8)
        let weatherList:[String: Any] = weatherContentStr?.getDictionaryFromJSONString() as! [String : Any]

        return weatherList
    }

    /** 构建实时天气模型 */
    var senventyTwoInfoModel: SeventyTwoWeatherInfoModel? {
        guard let seventyTwoInfo = senventyTwoWeatherContentValue else {
            return SeventyTwoWeatherInfoModel()
        }
        return SeventyTwoWeatherInfoModel.init(JSON: seventyTwoInfo)
    }

    /**********************************|  构造数据类型：15日天气模型  |******************************/
    /** 将天气详情Json字符串转成Json */
    var fifteenWeatherContentValue: [String: Any]?  {
        guard let fifteendata = data?["sixteenDay"] else {
            return [:]
        }

        if ((fifteendata["content"] as Any) as AnyObject).isKind(of: NSArray.self) {
            return [:]
        }

        let fifteenContent: String = fifteendata["content"] as! String

        if fifteenContent.length == 0 {
            return [:]
        }

        /** 1、将数据进行base64解码 2、使用gzip进行解码，获取解码后的数据 3、将二进制数据数据转成字符串 */
        let decodeWeatherContent: Data = GTMBase64.decode(fifteenContent)!
        let uncompressWeatherData: Data = decodeWeatherContent.gzipUncompress()
        let weatherContentStr =  String(data: uncompressWeatherData, encoding: String.Encoding.utf8)
        let weatherList:[String: Any] = weatherContentStr?.getDictionaryFromJSONString() as! [String : Any]

        return weatherList
        
    }

    /** 将天气详情Json字符串转成Json 生活指数 */
    var livingContentValue: [String: Any]?  {
        guard let fifteendata = data?["sixteenDay"] else {
            return [:]
        }

        if ((fifteendata["living"] as Any) as AnyObject).isKind(of: NSArray.self) {
            return [:]
        }

        let fifteenContent: String = fifteendata["living"] as! String
        if fifteenContent.length == 0 {
            return [:]
        }
        /** 1、将数据进行base64解码 2、使用gzip进行解码，获取解码后的数据 3、将二进制数据数据转成字符串 */
        let decodeWeatherContent: Data = GTMBase64.decode(fifteenContent)!
        let uncompressWeatherData: Data = decodeWeatherContent.gzipUncompress()
        let weatherContentStr =  String(data: uncompressWeatherData, encoding: String.Encoding.utf8)
        let weatherList:[String: Any] = weatherContentStr?.getDictionaryFromJSONString() as! [String : Any]

        return weatherList
    }

    /** 构建实时天气模型 */
    var fifteenInfoModel: FifteenDayWeatherInfoModel? {
        guard let fifteenInfo = fifteenWeatherContentValue else {
            return FifteenDayWeatherInfoModel()
        }
        return FifteenDayWeatherInfoModel.init(JSON: fifteenInfo)
    }


}
