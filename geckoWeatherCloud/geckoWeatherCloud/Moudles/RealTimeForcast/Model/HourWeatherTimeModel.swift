//
//  HourWeatherTimeModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper

/// 小时的天气数据结构model
class HourWeatherTimeModel: NSObject, Mappable {
    var dateStr: String?  = "现在"                     /** 时间 */
    var timeStr: String?  = "现在"                     /** 时间 */
    var weatherStr: String? = "多云转晴"                /** 天气描述 */
    var currentMax: CGFloat? = 0.0                     /** 当前天的最大值 */
    var currentMin: CGFloat? = 0.0                     /** 当前天的最小值 */
    var currentValue: CGFloat? = 0.0                   /** 当前天的最小值 */
    var isAlpha: Bool? = false                         /** 是否加上遮罩 */
    var isCurrent: Bool? = false                       /** 是否当前时间 */
    var weatherQualityStr: String? = ""                /** 天气图标 */
    var skycon: String? = ""                           /** 天气图标 */
    var aqiColor: String? = ""                         /** 空气颜色 */
    var aqi: String? = ""                               /** 空气颜色 */
    var windLevel: String? = ""                         /** 风力等级 */
    var maxPoint: CGPoint? = CGPoint.zero              /** 计算后的当日最大点 */
    var index: NSInteger?           = 0                /** 序号 */
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dateStr          <- map["dateStr"]
        weatherStr       <- map["weatherStr"]
        currentValue     <- map["currentValue"]
        currentMin       <- map["currentMin"]
        currentMax       <- map["currentMax"]
        
    }
    
    override init() {
        super.init()
    }
    
    /** 当前的详情页展示信息 */
    init(_ hourWeatherInfo: [String: Any]?, skyconInfo: [String: Any]?) {
        super.init()
        self.dateStr = Date().week()
        let itemTime: NSString = hourWeatherInfo!["datetime"] as! NSString
        let dateStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
        let currentHour: String = Date().getFullTime() as String
        if dateStr as String == currentHour {
            self.dateStr = "现在"
            self.isCurrent = true
        } else {
            self.dateStr = dateStr.substring(from: 10)
            self.isCurrent = false
        }
        /// 获取温度
        let tempValue: CGFloat = hourWeatherInfo?["value"] as! CGFloat
        self.currentValue = tempValue
        
        /// 获取到当前天气图标
        let skycon: String = skyconInfo?["value"] as! String
        self.weatherStr = skycon
        
    }
    
    init(_ hourWeatherInfo: [String: Any]?, skyconInfo: [String: Any]?, aqiInfo: [String: Any]?) {
        super.init()
        self.dateStr = Date().week()
        let itemTime: NSString = hourWeatherInfo!["datetime"] as! NSString
        let dateStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
        let currentHour: String = Date().getFullTime() as String
        if dateStr as String == currentHour {
            self.dateStr = "现在"
            self.isCurrent = true
        } else {
            self.dateStr = dateStr.substring(from: 10)
            self.isCurrent = false
        }
        /// 获取温度
        let tempValue: CGFloat = hourWeatherInfo?["value"] as! CGFloat
        self.currentValue = tempValue
        
        /// 获取到当前天气图标
        let skycon: String = skyconInfo?["value"] as! String
        self.skycon  = skycon
        let AQIValue: [String: Any]  = aqiInfo!["value"] as! [String: Any]
        let AQI: CGFloat  = AQIValue["chn"] as! CGFloat
        self.weatherQualityStr = AQI2AirQuiltyDescription.shared.getAQITitle(NSInteger(AQI))
        self.aqiColor = AQI2AirQuiltyDescription.shared.getAQIColor(NSInteger(AQI))
        self.aqi = "\(NSInteger(AQI))"
        self.weatherStr = "\(Skycon2WeatherDescription.shared.weatherDescription(self.skycon!))"
        
    }
    
    init(_ hourWeatherInfo: [String: Any]?, skyconInfo: [String: Any]?, aqiInfo: [String: Any]?, currentValue: CGFloat) {
        super.init()
        self.dateStr = Date().week()
        let itemTime: NSString = hourWeatherInfo!["datetime"] as! NSString
        let dateStr22: String = itemTime.timeToyyyy_MM_ddHHMM() as String
        let currentHour: String = Date().getFullTime() as String
        if dateStr22 as String == currentHour {
            self.dateStr = "现在"
            self.isCurrent = true
            self.currentValue = currentValue
        } else {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let date = dateFormatter.date(from: dateStr22)
            dateFormatter.dateFormat = "h:mm a"
            self.dateStr = dateFormatter.string(from: date!)
            
            //self.dateStr = "\(dateStr22.substring(from: 10, to: 12))点"
            self.isCurrent = false
            /// 获取温度
            let tempValue: CGFloat = hourWeatherInfo?["value"] as! CGFloat
            self.currentValue = tempValue
        }
        
        
        /// 获取到当前天气图标
        let skycon: String = skyconInfo?["value"] as! String
        self.skycon  = skycon
        let AQIValue: [String: Any]  = aqiInfo!["value"] as! [String: Any]
        let AQI: CGFloat  = AQIValue["chn"] as! CGFloat
        self.weatherQualityStr = AQI2AirQuiltyDescription.shared.getAQITitle(NSInteger(AQI))
        self.aqiColor = AQI2AirQuiltyDescription.shared.getAQIColor(NSInteger(AQI))
        self.weatherStr = "\(Skycon2WeatherDescription.shared.weatherDescription(self.skycon!))"
        
    }
    
}
