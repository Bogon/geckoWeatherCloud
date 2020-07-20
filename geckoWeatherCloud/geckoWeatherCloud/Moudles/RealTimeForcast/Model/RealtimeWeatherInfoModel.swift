//
//  RealtimeWeatherInfoModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import ObjectMapper
import RxSwift
import RxCocoa

/** 实时天气返回的主要数据 */
class RealtimeWeatherInfoModel: NSObject, Mappable {
    /// 紫外线指数及其自然语言描述
    var life_index: [String: Any]? = ["ultraviolet": ["index": 4, "desc": "-"], "comfort": ["index": 6, "desc": "-"]]
    /// 温度
    var temperature: CGFloat? = 0
    /// 体感温度
    var apparent_temperature: CGFloat? = 0
    /// 主要天气现象
    var skycon: String? = "CLEAR_DAY"
    /// AQI（国标）
    var air_quality: [String: Any]? = [ "no2": 0, "proposal": "-", "pm25": 22, "o3": 0, "so2": 0, "pm10": 0, "aqi": ["usa": 0, "chn": 0], "description": ["usa": "", "chn": ""], "co": 0]
    /// 相对湿度
    var humidity: CGFloat? = 0
    /// 实况模块返回状态
    var status: String? = "ok"
    /// 风向，单位是度。正北方向为0度，顺时针增加到360度。风速，米制下是公里每小时
    var wind: [String: Double]? = ["speed": 0, "direction": 0]
    
    /// AQI
    var aqi: NSInteger? {
        let aqiList: [String: Any] = air_quality!["aqi"] as! [String : Any]
        let aqiValue: Int = aqiList["chn"] as! NSInteger
        return aqiValue
    }
    
    /// AQI description
    var aqi_description: String? {
        let aqiList: [String: Any] = air_quality!["description"] as! [String : Any]
        let aqiValue: String = aqiList["chn"] as! String
        return aqiValue
    }
    
    /// AQI proposal
    var proposal: String? {
        let _proposal: String = air_quality!["proposal"] == nil ? "" : (air_quality!["proposal"] as! String)
        return _proposal
    }
    
    /// 紫外线强度
    var ultraviolet: String? {
        let ultravioletList: [String: Any] = life_index!["ultraviolet"] as! [String : Any]
        let ultravioletValue: String = ultravioletList["desc"]! as! String
        return ultravioletValue
    }
    
    /// 发布时间
    var releaseTime: String? = "--"
    
    /// 能见度
    var visibility: CGFloat? = 0.0
    
    /// 气压
    var pressure: Int? = 0
    
    /// 提醒
    var remindContent: String? = "--"
    
    /// 最大温度
    var tempMax: CGFloat? = 0
    
    /// 日出时间
    var astro: [String: Any]? = [ "date": "", "sunrise": ["time":""], "sunset": ["time":""]]
    
    /// 日落时间
    var sunsetValue: String {
        let sunset: [String: String] = astro!["sunset"] as! [String : String]
        return sunset["time"]!
        
    }
    
    /// 最低温度
    var tempMin: CGFloat? = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        life_index                 <- map["life_index"]
        temperature                <- map["temperature"]
        skycon                     <- map["skycon"]
        air_quality                <- map["air_quality"]
        humidity                   <- map["humidity"]
        status                     <- map["status"]
        wind                       <- map["wind"]
        apparent_temperature       <- map["apparent_temperature"]
        releaseTime                <- map["releaseTime"]
        visibility                 <- map["visibility"]
        pressure                   <- map["pressure"]
        remindContent              <- map["remindContent"]
        tempMax                    <- map["tempMax"]
        astro                      <- map["astro"]
        tempMin                    <- map["tempMin"]
    }
    
    override init() {
        super.init()
    }

}

