//
//  FifteenDayWeatherInfoModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper

/** 15天天气返回的主要数据 */
class FifteenDayWeatherInfoModel: NSObject, Mappable {

    var ultraviolet: [[String: Any]]?
    var temperature: [[String: Any]]?
    var skycon: [[String: Any]]?
    var aqi: [[String: Any]]?
    var humidity: [[String: Any]]?
    var wind: [[String: Any]]?
    var windInfo: [[String: Any]]?
    var skycon_20h_32h: [[String: Any]]?
    var astro: [[String: Any]]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ultraviolet      <- map["ultraviolet"]
        temperature      <- map["temperature"]
        skycon           <- map["skycon"]
        aqi              <- map["aqi"]
        humidity         <- map["humidity"]
        wind             <- map["wind"]
        windInfo         <- map["windInfo"]
        skycon_20h_32h   <- map["skycon_20h_32h"]
        astro            <- map["astro"]
    }
    
    override init() {
        super.init()
    }
    
    
    /** 返回某一天的天气详情 */
    func getSomeDayWeatherInfo(WithSomeDay dayType: TemperatureDayType, realTimeModel: DayWeatherInfoModel?) -> DayWeatherInfoModel {
        /// 初始化最大和最小的温度
        var weatherLineInfo: DayWeatherInfoModel = DayWeatherInfoModel()
        /// 获取到天气数据集合
        guard let temperatureList = temperature else {
            return weatherLineInfo
        }
        guard let skyconList = skycon else {
            return weatherLineInfo
        }
        guard let humidityList = humidity else {
            return weatherLineInfo
        }
        guard let windList = wind else {
            return weatherLineInfo
        }
        guard let windInfoList = windInfo else {
            return weatherLineInfo
        }
        guard let aqiList = aqi else {
            return weatherLineInfo
        }
        guard let ultravioletList = ultraviolet else {
            return weatherLineInfo
        }
        guard let astroList = astro else {
            return weatherLineInfo
        }
        /// 存放当前日期字符串
        var dateStr: String = ""
        switch dayType {
        case .last:
            /// 后天
            let lastDay: Date = NSDate.init(timeInterval: 24*60*60*2, since: Date()) as Date
            dateStr = lastDay.dateConvertString("yyyy-MM-dd")
        case .today:
            /// 当天
            dateStr = Date().dateConvertString("yyyy-MM-dd")
        case .tomorrow:
            /// 明天
            let tomorrowDay: Date = NSDate.init(timeInterval: 24*60*60, since: Date()) as Date
            dateStr = tomorrowDay.dateConvertString("yyyy-MM-dd")
        case .other:
            dateStr = ""
        }
        
        for (index, item) in temperatureList.enumerated() {
            let itemTime: String = item["date"] as! String
            let itemTimeStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
            let currentDate: Date = (itemTimeStr as String).stringConvertDate("yyyy-MM-dd HH:mm")
            if currentDate.dateConvertString("yyyy-MM-dd") == dateStr {
                weatherLineInfo = DayWeatherInfoModel.init(temperatureList[index], skycon_08h_20h: skyconList[index], skycon_20h_32h: skyconList[index], wind: windList[index], humidity: humidityList[index], aqi: aqiList[index], windInfo: windInfoList[index], astroInfo: astroList[index])
                let ultravioletInfo: [String: Any] = ultravioletList[index]
                let ultravioletDesp: String? = (ultravioletInfo["desc"] as! String)
                weatherLineInfo.ultraviolet = ultravioletDesp
                
                if .today == dayType {
                    if realTimeModel != nil {
                        weatherLineInfo.skycon = realTimeModel?.skycon
                        weatherLineInfo.weatherStr = realTimeModel?.weatherStr
                    }
                }
                
            }
        }
        
        if .today == dayType {
            guard let realTimeInfoModel = realTimeModel else {
                return weatherLineInfo
            }
            
            /// 更换最新天气范围
            if (realTimeInfoModel.currentValue!) > weatherLineInfo.currentMax! {
                weatherLineInfo.currentMax = realTimeInfoModel.currentValue!
            }
            
            if (realTimeInfoModel.currentValue!) < weatherLineInfo.currentMin! {
                weatherLineInfo.currentMin = realTimeInfoModel.currentValue!
            }
        }
        return weatherLineInfo
        
    }
    
    /** 返回某一天的天气详情 */
    func getSenvenDayWeatherInfo() -> ([DayWeatherInfoModel], CGFloat, CGFloat) {
        /// 初始化最大和最小的温度
        var weatherListInfo: [DayWeatherInfoModel] = [DayWeatherInfoModel]()
        /// 获取到天气数据集合
        guard let temperatureList = temperature else {
            return (weatherListInfo, 0, 0)
        }
        guard let skyconList = skycon else {
            return (weatherListInfo, 0, 0)
        }
        guard let humidityList = humidity else {
            return (weatherListInfo, 0, 0)
        }
        guard let windList = wind else {
            return (weatherListInfo, 0, 0)
        }
        guard let windInfoList = windInfo else {
            return (weatherListInfo, 0, 0)
        }
        guard let aqiList = aqi else {
            return (weatherListInfo, 0, 0)
        }
        guard let ultravioletList = ultraviolet else {
            return (weatherListInfo, 0, 0)
        }
        guard let astroList = astro else {
            return (weatherListInfo, 0, 0)
        }
        /// 存放当前日期字符串 明天
        let tomorrowDay: Date = NSDate.init(timeInterval: 24*60*60, since: Date()) as Date
        let dateStr: String = tomorrowDay.dateConvertString("yyyy-MM-dd")
        
        /// 起始索引
        var startIdx: Int = 0
        
        var tempMax: CGFloat = 0
        var tempMin: CGFloat = temperatureList.first!["min"] as! CGFloat
        /// 构建并保存数据，刷新小时模块数据
        for (index , item) in (temperatureList.enumerated()) {
            
            let itemTime: String = item["date"] as! String
            let itemTimeStr: NSString = itemTime.timeToyyyy_MM_ddHHMM() as NSString
            let currentDate: Date = (itemTimeStr as String).stringConvertDate("yyyy-MM-dd HH:mm")
            if currentDate.dateConvertString("yyyy-MM-dd") == dateStr {
                startIdx = index
            } else if startIdx < index && (startIdx + 7) > index {
                let temperaMax: CGFloat = item["max"] as! CGFloat
                let temperaMin: CGFloat = item["min"] as! CGFloat
                if temperaMax > tempMax {
                    tempMax = temperaMax
                }
                
                if temperaMin < tempMin {
                    tempMin = temperaMin
                }
                
                let dayWeatherInfo: DayWeatherInfoModel = DayWeatherInfoModel.init(temperatureList[index], skycon_08h_20h: skyconList[index], skycon_20h_32h: skyconList[index], wind: windList[index], humidity: humidityList[index], aqi: aqiList[index], windInfo: windInfoList[index], astroInfo: astroList[index])
                let ultravioletInfo: [String: Any] = ultravioletList[index]
                let ultravioletDesp: String? = (ultravioletInfo["desc"] as! String)
                dayWeatherInfo.ultraviolet = ultravioletDesp
                
                weatherListInfo.append(dayWeatherInfo)
            }
            
            if weatherListInfo.count >= 6 {
                break
            }
        }
                
        return (weatherListInfo, tempMin, tempMax)
        
    }
    
    /** 获取当天的天气气温区间 */
    func getTodayTemperatureInternal(WithRealTimeInfo realTimeModel: DayWeatherInfoModel?) -> [String: String] {
        /// 初始化最大和最小的温度
        var min: String = "--"
        var max: String = "--"
        /// 获取到天气数据集合
        guard let temperatureList = temperature else {
            return ["min": min, "max": max]
        }
        
        /// 存放当前日期字符串
        let todayStr: String = Date().dateConvertString("yyyy-MM-dd")
        for (_, item) in temperatureList.enumerated() {
            let itemTime: NSString = item["date"] as! NSString
            let itemTimeStr: NSString = itemTime.timeToyyyy_MM_dd() as NSString
            if itemTimeStr as String == todayStr {
                var tempMin: CGFloat = item["min"] as! CGFloat
                var tempMax: CGFloat = item["max"] as! CGFloat
                /// 更换最新天气范围
                if (realTimeModel?.currentValue!)! > tempMax {
                    tempMax = realTimeModel!.currentValue!
                }
                
                if (realTimeModel?.currentValue!)! < tempMin {
                    tempMin = realTimeModel!.currentValue!
                }
                min = "\(Int(tempMin))"
                max = "\(Int(tempMax))"
            }
        }
        return ["min": min, "max": max]
    }
    
    /** 构造每天区间的数据 */
    func getDailyInfoList(WithRealTimeInfo realTimeModel: DayWeatherInfoModel?) -> [DayWeatherInfoModel] {
        /// 定位数据中的数据，定位到当前时间点
        var currentDayInfoList: [DayWeatherInfoModel] = [DayWeatherInfoModel]()
        guard let temperatureList = temperature else {
            return currentDayInfoList
        }
        
        if temperatureList.count == 0 {
            return currentDayInfoList
        }
        
        guard let skyconList = skycon else {
            return currentDayInfoList
        }
        guard let humidityList = humidity else {
            return currentDayInfoList
        }
        guard let windList = wind else {
            return currentDayInfoList
        }
        guard let aqiList = aqi else {
            return currentDayInfoList
        }
        
        guard let skycon_20h_32hList = skycon_20h_32h else {
            return currentDayInfoList
        }
        
        guard let windInfoList = windInfo else {
            return currentDayInfoList
        }
        
        guard let ultravioletList = ultraviolet else {
            return currentDayInfoList
        }
        
        guard let astroList = astro else {
            return currentDayInfoList
        }
        
        var tempMax: CGFloat = 0
        var tempMin: CGFloat = temperatureList.first!["min"] as! CGFloat
        /// 构建并保存数据，刷新小时模块数据
        for (_ , item) in (temperatureList.enumerated()) {
            let temperaMax: CGFloat = item["max"] as! CGFloat
            let temperaMin: CGFloat = item["min"] as! CGFloat
            if temperaMax > tempMax {
                tempMax = temperaMax
            }
            
            if temperaMin < tempMin {
                tempMin = temperaMin
            }
        }
        
        let tempAvgAQIValue: [String: Any] = aqiList.first!["avg"] as! [String : Any]
        var tempAQIMax: CGFloat = tempAvgAQIValue["chn"] as! CGFloat
        var tempAQIMin: CGFloat = tempAvgAQIValue["chn"] as! CGFloat
        /// 构建并保存数据，刷新小时模块数据
        for (_ , aqiItem) in (aqiList.enumerated()) {
            let tempAQI: [String: Any] = aqiItem["avg"] as! [String : Any]
            let aqi: CGFloat = tempAQI["chn"] as! CGFloat
            if aqi > tempAQIMax {
                tempAQIMax = aqi
            }
            
            if aqi < tempAQIMin {
                tempAQIMin = aqi
            }
        }
        
        /// 更换最新天气范围
        if (realTimeModel?.currentValue!)! > tempMax {
            tempMax = realTimeModel!.currentValue!
        }
        
        if (realTimeModel?.currentValue!)! < tempMin {
            tempMin = realTimeModel!.currentValue!
        }
        
        /// 构建并保存数据，刷新天模块数据
        for index in 0..<(temperature?.count)! {
            
            //            let currentTime: String = temperature![index]["date"] as! String
            let currentTime: NSString = temperature![index]["date"] as! NSString
            let itemTimeStr: NSString = currentTime.timeToyyyy_MM_ddHHMM() as NSString
            let currentDate: Date = (itemTimeStr as String).stringConvertDate("yyyy-MM-dd HH:mm")
            
            /// 构建数据
            let weatherLineModel: DayWeatherInfoModel = DayWeatherInfoModel.init(temperatureList[index], skycon_08h_20h: skyconList[index], skycon_20h_32h: skycon_20h_32hList[index], wind: windList[index], humidity: humidityList[index], aqi: aqiList[index], windInfo: windInfoList[index], astroInfo: astroList[index])
            weatherLineModel.index = index
            weatherLineModel.isArrow = true
            weatherLineModel.mdDateStr = "\(currentDate.string(withFormat: "yyyy年MM月dd日").substring(from: 5))"
            weatherLineModel.requestDate = currentDate.string(withFormat: "yyyy-MM-dd")
            weatherLineModel.yijiShowDate = currentDate.string(withFormat: "yyyy年MM月dd日")
            /// 设置最高温度和最低温度
            weatherLineModel.min = tempMin
            weatherLineModel.max = tempMax
            
            let ultravioletInfo: [String: Any] = ultravioletList[index]
            let ultravioletDesp: String? = (ultravioletInfo["desc"] as! String)
            weatherLineModel.ultraviolet = ultravioletDesp
            
            /// 设置最高空气质量和最低空气质量
            weatherLineModel.aqimin = tempAQIMin
            weatherLineModel.aqimax = tempAQIMax
            
            let todayTimeDayStr: String = "\(Date().string(withFormat: "yyyy-MM-dd")) 00:00"
            
            let now: Date = Date()
            
            /// 昨天
            let lastDay: Date = NSDate.init(timeInterval: -24*60*60, since: now) as Date
            let lastTimeDayStr: String = "\(lastDay.string(withFormat: "yyyy-MM-dd")) 23:59:59"
            let lastTimeDayString: String = "\(lastDay.string(withFormat: "yyyy-MM-dd")) 00:00"
            let lastNewDate: Date = lastTimeDayStr.stringConvertDate("yyyy-MM-dd HH:mm:ss")
            
            /// 明天
            let tomorrowDay: Date = NSDate.init(timeInterval: 24*60*60, since: now) as Date
            let tomorrowTimeDayStr: String = "\(tomorrowDay.string(withFormat: "yyyy-MM-dd")) 00:00"
            
            /// 后天
            let acquiredDay: Date = NSDate.init(timeInterval: 24*60*60*2, since: now) as Date
            let acquiredTimeDayStr: String = "\(acquiredDay.string(withFormat: "yyyy-MM-dd")) 00:00"
            
            if itemTimeStr as String == lastTimeDayString {
                weatherLineModel.dateStr = "昨天"
                weatherLineModel.isAlpha = true
            } else {
                weatherLineModel.isAlpha = false
            }
            
            if itemTimeStr as String == todayTimeDayStr {
                weatherLineModel.dateStr = "今天"
                weatherLineModel.AQI = realTimeModel?.AQI
                weatherLineModel.aqi = realTimeModel?.aqi
                weatherLineModel.weatherQualityStr = realTimeModel?.weatherQualityStr
                weatherLineModel.aqiColor = realTimeModel?.aqiColor
                
                /// 更换最新天气范围
                if (realTimeModel?.AQI!)! > weatherLineModel.aqimax! {
                    weatherLineModel.aqimax = realTimeModel?.AQI
                }
                
                if (realTimeModel?.AQI!)! < weatherLineModel.aqimin! {
                    weatherLineModel.aqimin = realTimeModel?.AQI
                }
                
                /// 更换最新天气范围
                if (realTimeModel?.currentValue!)! > weatherLineModel.currentMax! {
                    weatherLineModel.currentMax = realTimeModel?.currentValue
                }
                
                if (realTimeModel?.currentValue!)! < weatherLineModel.currentMin! {
                    weatherLineModel.currentMin = realTimeModel?.currentValue
                }
            }
            
            if itemTimeStr as String == tomorrowTimeDayStr {
                weatherLineModel.dateStr = "明天"
            }
            
            if itemTimeStr as String == acquiredTimeDayStr {
                weatherLineModel.dateStr = "后天"
            }
            
            if currentDate.timeIntervalSince1970 > acquiredDay.timeIntervalSince1970 {
                weatherLineModel.isArrow = false
            }
            
            if currentDate.timeIntervalSince1970 < lastNewDate.timeIntervalSince1970 {
                weatherLineModel.isArrow = false
                weatherLineModel.isAlpha = true
            }
            
            currentDayInfoList.append(weatherLineModel)
        }
        return currentDayInfoList
    }
}
