//
//  SeventyTwoWeatherInfoModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper


/// 天气区间类型：昨天、当天、明天
enum TemperatureDayType: Int {
    case today       = 0     /// 今天
    case tomorrow    = 1     /// 明天
    case last        = 2     /// 后天
    case other       = 3     /// 其他
}

/** 72小时天气返回的主要数据 */
class SeventyTwoWeatherInfoModel: NSObject, Mappable {
    var temperature: [[String: Any]]?
    var skycon: [[String: Any]]?
    var aqi: [[String: Any]]?
    var windInfo: [[String: Any]]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        temperature        <- map["temperature"]
        skycon             <- map["skycon"]
        aqi                <- map["aqi"]
        windInfo           <- map["windInfo"]
    }
    
    override init() {
        super.init()
    }
    
    
    /** 返回带全量天气数据的某一天的天气详情 */
    func getFifteenInfoList(WithFifteen dayType: TemperatureDayType, realTimeModel: DayWeatherInfoModel?) -> [HourWeatherTimeModel] {
        /// 小时天气t容器List
        var currentHourInfoList: [HourWeatherTimeModel] = [HourWeatherTimeModel]()
        guard let temperatureList = temperature else {
            return currentHourInfoList
        }
        
        guard let skyconList = skycon else {
            return currentHourInfoList
        }
        
        guard let aqiList = aqi else {
            return currentHourInfoList
        }
        
        let currentDate: Date = Date()
        /// 存放当前日期字符串
        var dateStr: String = ""
        switch dayType {
        case .last:
            /// 后天天
            let lastDay: Date = NSDate.init(timeInterval: 24*60*60*2, since: currentDate) as Date
            dateStr = lastDay.getStartFullTime()
        case .today:
            /// 当天
            //dateStr = Date().getFullTime()
            dateStr = currentDate.getLastHourFullTime()
        case .tomorrow:
            /// 明天
            let tomorrowDay: Date = NSDate.init(timeInterval: 24*60*60, since: currentDate) as Date
            dateStr = tomorrowDay.getStartFullTime()
        case .other:
            dateStr = ""
        }
        print(dateStr)
        
        let currentHourIndex: NSInteger = 0
          
        var tempMax: CGFloat = temperatureList.first!["value"] as! CGFloat
        var tempMin: CGFloat = temperatureList.first!["value"] as! CGFloat
        var endIndex: NSInteger = currentHourIndex+24
        if endIndex > (temperatureList.count) {
            endIndex = temperatureList.count
        }
        /// 构建并保存数据，刷新小时模块数据
        for i in currentHourIndex..<endIndex {
            let tempItem: [String: Any] = temperatureList[i]
            let tempera: CGFloat = tempItem["value"] as! CGFloat
            if tempera > tempMax {
                tempMax = tempera
            }
            
            if tempera < tempMin {
                tempMin = tempera
            }
        }
        
        /// 构建并保存数据，刷新小时模块数据
        for i in currentHourIndex..<endIndex {
            
            var weatherTimeModel: HourWeatherTimeModel?
            if dayType == .today && i == (currentHourIndex + 1) {
                
                weatherTimeModel = HourWeatherTimeModel.init(temperatureList[i], skyconInfo: skyconList[i], aqiInfo: aqiList[i], currentValue: (realTimeModel?.currentValue!)!)
                weatherTimeModel?.skycon = realTimeModel?.skycon
                weatherTimeModel?.weatherStr = realTimeModel?.weatherStr
                weatherTimeModel?.weatherQualityStr = realTimeModel?.weatherQualityStr
                weatherTimeModel?.aqiColor = AQI2AirQuiltyDescription.shared.getAQIColor(NSInteger((realTimeModel?.aqi!)!)!)
            } else {
                weatherTimeModel = HourWeatherTimeModel.init(temperatureList[i], skyconInfo: skyconList[i], aqiInfo: aqiList[i])
            }
            weatherTimeModel?.currentMax = tempMax
            weatherTimeModel?.currentMin = tempMin
            weatherTimeModel?.index = i - currentHourIndex
            currentHourInfoList.append(weatherTimeModel!)
        }
        print(currentHourIndex)
        return currentHourInfoList
    }
    
    /** 返回带有天气数据的某一天的天气详情 */
    func getSeventyTwoHourlyInfoList(WithSeventyTwo dayType: TemperatureDayType, realTimeModel: HourWeatherTimeModel?) -> [HourWeatherTimeModel] {
        /// 小时天气t容器List
        var currentHourInfoList: [HourWeatherTimeModel] = [HourWeatherTimeModel]()
        guard let temperatureList = temperature else {
            return currentHourInfoList
        }
        
        guard let skyconList = skycon else {
            return currentHourInfoList
        }
        
        guard let aqiList = aqi else {
            return currentHourInfoList
        }
        
        let currentDate: Date = Date()
        /// 存放当前日期字符串
        var dateStr: String = ""
        switch dayType {
        case .last:
            /// 后天天
            let lastDay: Date = NSDate.init(timeInterval: 24*60*60*2, since: currentDate) as Date
            dateStr = lastDay.getStartFullTime()
        case .today:
            /// 当天
            //dateStr = Date().getFullTime()
            dateStr = currentDate.getLastHourFullTime()
        case .tomorrow:
            /// 明天
            let tomorrowDay: Date = NSDate.init(timeInterval: 24*60*60, since: currentDate) as Date
            dateStr = tomorrowDay.getStartFullTime()
        case .other:
            dateStr = ""
        }
        
        var currentHourIndex: NSInteger = 0
        for (i, item) in temperatureList.enumerated() {
            let itemTime: NSString = item["datetime"] as! NSString
            let itemTimeStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
            if dateStr == itemTimeStr as String {
                currentHourIndex = i
                break
            }
        }
        
        var tempMax: CGFloat = temperatureList.first!["value"] as! CGFloat
        var tempMin: CGFloat = temperatureList.first!["value"] as! CGFloat
        var endIndex: NSInteger = currentHourIndex+24
        if endIndex > (temperatureList.count) {
            endIndex = temperatureList.count
        }
        /// 构建并保存数据，刷新小时模块数据
        for i in currentHourIndex..<endIndex {
            let tempItem: [String: Any] = temperatureList[i]
            let tempera: CGFloat = tempItem["value"] as! CGFloat
            if tempera > tempMax {
                tempMax = tempera
            }
            
            if tempera < tempMin {
                tempMin = tempera
            }
        }
        
        /// 构建并保存数据，刷新小时模块数据
        for i in currentHourIndex..<endIndex {
            
            var weatherTimeModel: HourWeatherTimeModel?
            if dayType == .today && i == (currentHourIndex + 1) {
                weatherTimeModel = HourWeatherTimeModel.init(temperatureList[i], skyconInfo: skyconList[i], aqiInfo: aqiList[i], currentValue: (realTimeModel?.currentValue!)!)
                weatherTimeModel?.skycon = realTimeModel?.skycon
                weatherTimeModel?.weatherStr = realTimeModel?.weatherStr
                weatherTimeModel?.weatherQualityStr = realTimeModel?.weatherQualityStr
                weatherTimeModel?.aqiColor = AQI2AirQuiltyDescription.shared.getAQIColor(NSInteger((realTimeModel?.aqi!)!)!)
            } else {
                weatherTimeModel = HourWeatherTimeModel.init(temperatureList[i], skyconInfo: skyconList[i], aqiInfo: aqiList[i])
            }
            weatherTimeModel?.currentMax = tempMax
            weatherTimeModel?.currentMin = tempMin
            weatherTimeModel?.index = i - currentHourIndex
            currentHourInfoList.append(weatherTimeModel!)
        }
        
        return currentHourInfoList
    }
    
    /** 返回某一天的天气详情 */
    func getSomeDayHourlyInfoList(WithSomeDay dayType: TemperatureDayType) -> [HourWeatherTimeModel] {
        /// 小时天气t容器List
        var currentHourInfoList: [HourWeatherTimeModel] = [HourWeatherTimeModel]()
        guard let temperatureList = temperature else {
            return currentHourInfoList
        }
        
        guard let skyconList = skycon else {
            return currentHourInfoList
        }
        
        let currentDate: Date = Date()
        /// 存放当前日期字符串
        var dateStr: String = ""
        switch dayType {
        case .last:
            /// 后天天
            let lastDay: Date = NSDate.init(timeInterval: 24*60*60*2, since: currentDate) as Date
            dateStr = lastDay.getStartFullTime()
        case .today:
            /// 当天
            //dateStr = Date().getFullTime()
            dateStr = currentDate.getLastHourFullTime()
        case .tomorrow:
            /// 明天
            let tomorrowDay: Date = NSDate.init(timeInterval: 24*60*60, since: currentDate) as Date
            dateStr = tomorrowDay.getStartFullTime()
            
        case .other:
            dateStr = ""
        }
        
        var currentHourIndex: NSInteger = 0
        for (i, item) in temperatureList.enumerated() {
            let itemTime: NSString = item["datetime"] as! NSString
            let itemTimeStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
            //log.info("itemTime = \(itemTime)")
            if dateStr == itemTimeStr as String {
                currentHourIndex = i
                break
            }
        }
        
        var endIndex: NSInteger = currentHourIndex+24
        if endIndex > (temperatureList.count) {
            endIndex = temperatureList.count
        }
        
        /// 构建并保存数据，刷新小时模块数据
        for i in currentHourIndex..<endIndex {
            let weatherTimeModel: HourWeatherTimeModel = HourWeatherTimeModel.init(temperatureList[i], skyconInfo: skyconList[i])
            currentHourInfoList.append(weatherTimeModel)
        }
        
        return currentHourInfoList
    }
    
    /** 获取某天该小时天气数据 */
    func getSomeDayHourInfo(WithSomeDay dayType: TemperatureDayType) -> String {
        /// 小时天气容器List
        var currentTemperature: String = "--"
        guard let temperatureList = temperature else {
            return currentTemperature
        }
        /// 存放当前日期字符串
        var dateStr: String = ""
        switch dayType {
        case .last:
            /// 后天天
            let lastDay: Date = NSDate.init(timeInterval: 24*60*60*2, since: Date()) as Date
            dateStr = lastDay.getStartFullTime()
        case .today:
            /// 当天
            dateStr = Date().getFullTime()
        case .tomorrow:
            /// 明天
            let tomorrowDay: Date = NSDate.init(timeInterval: 24*60*60, since: Date()) as Date
            dateStr = tomorrowDay.getStartFullTime()
        case .other:
            dateStr = ""
        }
        for (_ , item) in temperatureList.enumerated() {
            let hour: String = item["datetime"] as! String
            let value: CGFloat = item["value"] as! CGFloat
            if dateStr == hour {
                currentTemperature = "\(Int(value))"
                break
            }
        }
        
        return currentTemperature
    }
    
    /** 构造当天小时区间的数据 */
    func getHourlyInfoList(WithRealTimeInfo weatherLineModel: HourWeatherTimeModel?) -> [HourWeatherTimeModel] {
        /// 小时天气t容器List
        var currentHourInfoList: [HourWeatherTimeModel] = [HourWeatherTimeModel]()
        guard let temperatureList = temperature else {
            return currentHourInfoList
        }
        
        guard let skyconList = skycon else {
            return currentHourInfoList
        }
        
        guard let aqiList = aqi else {
            return currentHourInfoList
        }
        
        guard let windInfoList = windInfo else {
            return currentHourInfoList
        }
        
        var currentHourIndex: NSInteger = 0
        let currentDate: Date = Date()
        let lastHour: String = currentDate.getLastHourFullTime()    /// 当前时刻的上一个时刻
        for (i, item) in temperatureList.enumerated() {
            let itemTime: NSString = item["datetime"] as! NSString
            let itemTimeStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
            if lastHour == itemTimeStr as String {
                currentHourIndex = i
                break
            }
        }
        
        let nowHour: String = currentDate.getFullTime()             /// 当前的时刻
        
        var endIndex: NSInteger = currentHourIndex+24
        if endIndex > (temperatureList.count) {
            endIndex = temperatureList.count
        }
        
        
        var tempMax: CGFloat = temperatureList.first!["value"] as! CGFloat
        var tempMin: CGFloat = temperatureList.first!["value"] as! CGFloat
        
        /// 构建并保存数据，刷新小时模块数据
        for i in currentHourIndex..<endIndex {
            let tempItem: [String: Any] = temperatureList[i]
            let tempera: CGFloat = tempItem["value"] as! CGFloat
            if tempera > tempMax {
                tempMax = tempera
            }
            
            if tempera < tempMin {
                tempMin = tempera
            }
        }
        
        /// 构建并保存数据，刷新小时模块数据
        for i in currentHourIndex..<endIndex {
            let weatherTimeModel: HourWeatherTimeModel = HourWeatherTimeModel.init(temperatureList[i], skyconInfo: skyconList[i], aqiInfo: aqiList[i])
            let nowSkycon: [String: Any] = skyconList[i]
            let nowWindInfo: [String: Any] = windInfoList[i]
            let itemTime: NSString = nowSkycon["datetime"] as! NSString
            let itemTimeStr: String = itemTime.timeToyyyy_MM_ddHHMM() as String
            if itemTimeStr.substring(from: 11, to: 11) == "0" {
                weatherTimeModel.dateStr = "\(itemTimeStr.substring(from: 12, to: 12))\n点"
                weatherTimeModel.timeStr = "\(itemTimeStr.substring(from: 12, to: 12))点"
            } else {
                weatherTimeModel.dateStr = "\(itemTimeStr.substring(from: 11, to: 12))\n点"
                weatherTimeModel.timeStr = "\(itemTimeStr.substring(from: 11, to: 12))点"
            }
            
            if nowHour == itemTimeStr as String {
                weatherTimeModel.dateStr = "现在"
                weatherTimeModel.timeStr = "现在"
                weatherTimeModel.skycon = weatherLineModel?.skycon
                weatherTimeModel.weatherStr = weatherLineModel?.skycon
                weatherTimeModel.currentValue = weatherLineModel?.currentValue
            }
            
            weatherTimeModel.windLevel = (nowWindInfo["rank"] as! String)
            weatherTimeModel.currentMax = tempMax
            weatherTimeModel.currentMin = tempMin
            weatherTimeModel.index = i - currentHourIndex
            currentHourInfoList.append(weatherTimeModel)
        }
        
        return currentHourInfoList
    }
    
    /** 获取当天该小时天气数据 */
    func getCurrentHourInfo() -> String {
        /// 小时天气t容器List
        var currentTemperature: String = "--"
        guard let temperatureList = temperature else {
            return currentTemperature
        }
        
        let currentHour: String = Date().getFullTime()
        for (_ , item) in temperatureList.enumerated() {
            let value: CGFloat = item["value"] as! CGFloat
            let itemTime: NSString = item["datetime"] as! NSString
            let itemTimeStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
            if currentHour == itemTimeStr as String {
                currentTemperature = "\(Int(value))"
                break
            }
        }
        
        return currentTemperature
    }
    
    /** 获取当天该小时天气图标 */
    func getCurrentHourSkyInfo() -> [String: Any] {
        
        var currentSkyInfo: [String: Any] = Skycon2WeatherBgSetting.getWeatherColor(WeatherType: .CLEAR_DAY)
        
        guard let skyconList = skycon else {
            return currentSkyInfo
        }
        
        let currentHour: String = Date().getFullTime()
        for (_ , item) in skyconList.enumerated() {
            let itemTime: NSString = item["datetime"] as! NSString
            let itemTimeStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
            if currentHour == itemTimeStr as String {
                /// 获取到当前天气图标
                let skycon: String = item["value"] as! String
                currentSkyInfo = Skycon2WeatherBgSetting.getWeatherColor(WeatherType: SkyconType(rawValue: skycon)!)
                break
            }
        }
        
        return currentSkyInfo
    }
    
}
