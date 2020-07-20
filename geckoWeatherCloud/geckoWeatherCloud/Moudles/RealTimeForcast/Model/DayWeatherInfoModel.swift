//
//  DayWeatherInfoModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper

/// 每天的天气数据结构model
class DayWeatherInfoModel: NSObject, Mappable {
    
    var requestDate: String?            = "--"                  /** 宜忌请求参数 */
    var yijiShowDate: String?            = "--"                  /** 宜忌请求参数 */
    var dateStr: String?            = "--"
    var weekStr: String?            = "--"                               /** 星期 */
    var windPower: String?          = "--"                              /** 风力 */
    var wind: String?               = "--"                                  /** 风力 */
    var windDirection: String?      = "--"                                /** 风向 */
    var weatherStr: String?         = "--"                              /** 天气 */
    var skycon: String?             = "PARTLY_CLOUDY_DAY"                    /** 天气ICON */
    var weatherQualityStr: String?  = "--"                             /** 空气质量 */
    var aqi: String?                = "--"                                   /** 空气质量 */
    var AQI: CGFloat?             = 0
    var aqiStrokeValue: CGFloat?    = 0.0                                    /** 空气质量在弧形图上的值 */
    var somatosensoryStr: String?   = "--"                              /** 体感 */
    var ultravioletStr: String?     = ""                                     /** 紫外线 */
    var ultraviolet: String?        = "--"                                    /** 紫外线 */
    var humidityStr: String?        = "--"                                  /** 湿度 */
    var humidity: String?           = "--"                                  /** 湿度 */
    var isAlpha: Bool?              = false                                  /** 是否加上遮罩 */
    var timeStr: String?            = "--"         /** 日期 2019年3月25日 周一 农历二月十九 "\(Date().string(withFormat: "yyyy年MM月dd日")) \(Date().week()) 农历\(Date().solarToLunar())" */
    var timeFlashStr: String?            = "--"         /** 日期 2019年3月25日 周一 农历二月十九 "\(Date().string(withFormat: "yyyy年MM月dd日")) \(Date().week()) 农历\(Date().solarToLunar())" */
    var mdDateStr: String?            = "--"                            /** 日期 */
    var max: CGFloat?               = 0.0                                   /** 最近12天 天气最大值 */
    var min: CGFloat?               = 0.0                                   /** 最近12天 天气最小值 */
    var aqimax: CGFloat?            = 0.0                                   /** 最近空气质量12天 天气最大值 */
    var aqimin: CGFloat?            = 0.0                                   /** 最近空气质量12天 天气最小值 */
    var aqiminPoint: CGPoint?       = CGPoint.zero                          /** 计算后的当日最小值点 */
    var aqimaxPoint: CGPoint?       = CGPoint.zero                          /** 计算后的当日最大点 */
    var currentMax: CGFloat?        = 0.0                                   /** 当前天的最大值 */
    var currentMin: CGFloat?        = 0.0                                   /** 当前天的最小值 */
    var currentValue: CGFloat?      = 0.0                                   /** 当前天的最小值 */
    var index: NSInteger?           = 0                                     /** 序号 */
    var minPoint: CGPoint?          = CGPoint.zero                          /** 计算后的当日最小值点 */
    var maxPoint: CGPoint?          = CGPoint.zero                          /** 计算后的当日最大点 */
    var isArrow: Bool? = false                                              /** 是否显示箭头 */
    var proposal: String? = ""                                              /** 根据空气质量，给出外出建议 */
    var aqiColor: String? = ""                         /** 空气颜色 */
    var cityname: String? = "北京"                         /** 空气cityname */
    ///var index: NSInteger? = 0                            /** 数组中所在的位置*/
    
    /// 发布时间
    var releaseTime: String?
    
    /// 能见度
    var visibility: CGFloat?
    
    /// 气压
    var pressure: Int?
    
    /// 日出时间
    var astro: [String: Any]? = [ "date": "", "sunrise": ["time":""], "sunset": ["time":""]]
    
    /// 新增如下字段
    var night_skycon: String? = ""                          /** 夜间天气 */
    var night_weather_value: String? = ""                         /** 夜间天气描述 */
    var night_wind_direction: String? = ""                         /** 夜间风向 */
    var night_wind_level: String? = ""                         /** 夜间风力 */
    
    /// AQI（国标）
    var air_quality: [String: Any]? = [ "no2": 0, "pm25": 0, "o3": 0, "so2": 0, "pm10": 0, "aqi": ["usa": 0, "chn": 0], "description": ["usa": "--", "chn": "--"], "co": 0]
  
    var livingContentValue: [String: Any]? = [ "uv": ["brief":"", "details":""],
                                               "dressing": ["brief":"", "details":""],
                                               "umbrella": ["brief":"", "details":""],
                                               "car_washing": ["brief":"", "details":""],
                                               "fishing": ["brief":"", "details":""],
                                               "morning_sport": ["brief":"", "details":""],
                                               "airing": ["brief":"", "details":""],
                                               "sport": ["brief":"", "details":""],
                                               "flu": ["brief":"", "details":""],
                                               "allergy": ["brief":"", "details":""],
                                               "makeup": ["brief":"", "details":""],
                                               "chill": ["brief":"", "details":""],
                                               "mood": ["brief":"", "details":""],
                                               "travel": ["brief":"", "details":""],
                                               "sunscreen": ["brief":"", "details":""],]   /** 生活指数内容 */
    
    var apparent_temperature: String? = "--"                                    /** 体感温度 */
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dateStr              <- map["dateStr"]
        weekStr              <- map["weekStr"]
        windPower            <- map["windPower"]
        windDirection        <- map["windDirection"]
        weatherStr           <- map["weatherStr"]
        max                  <- map["max"]
        min                  <- map["min"]
        currentMax           <- map["currentMax"]
        currentMin           <- map["currentMin"]
        index                <- map["index"]
        minPoint             <- map["minPoint"]
        maxPoint             <- map["maxPoint"]
        currentValue         <- map["currentValue"]
        somatosensoryStr     <- map["somatosensoryStr"]
        humidityStr          <- map["humidityStr"]
        timeStr              <- map["timeStr"]
        weatherQualityStr    <- map["weatherQualityStr"]
        ultravioletStr       <- map["ultraviolet"]
        skycon               <- map["skycon"]
        cityname             <- map["cityname"]
        
    }
    
    override init() {
        super.init()
    }
    
    /** 天气项目初始化当前数据 */
    init(_ realtimeModel: RealtimeWeatherInfoModel?) {
        super.init()
        self.dateStr = Date().week()
        self.weekStr = Date().getWeekInYear()
        let windSpeedFloat: Double = Double((realtimeModel?.wind?["speed"])!)
        let windSpeed: Double = (windSpeedFloat * 1000.0)/3600.0
        
        self.windPower = "\(WindSpeed2Level.shared.windLevel(windSpeed.roundTo(places: 2)))"
        //self.windPower = "\(XNWindSpeed2LevelHandle.shared.getWindLevel((windSpeed * 1000)/3600))"
        let direction: CGFloat = CGFloat((realtimeModel?.wind!["direction"])!)
        self.windDirection = "\(Angle2WindDirection.shared.windDirection(direction))风"
        let skycon: String  = (realtimeModel?.skycon!)!
        self.skycon = skycon
        self.weatherStr = "\(Skycon2WeatherDescription.shared.weatherDescription(skycon))"
        let AQI: NSInteger  = NSInteger((realtimeModel?.aqi!)!)
        self.aqiColor = AQI2AirQuiltyDescription.shared.getAQIColor(NSInteger(AQI))
        self.aqi = "\(AQI)"
        self.AQI = CGFloat(AQI)
        self.weatherQualityStr = AQI2AirQuiltyDescription.shared.getAQITitle(AQI)
        //self.weatherQualityStr = realtimeModel?.aqi_description!
        self.aqiStrokeValue = AQI2AirQuiltyDescription.shared.getAQIStrokeValue(AQI)
        let tempera: NSInteger = (lroundf(Float((realtimeModel?.temperature!)!)))
        let humidity: CGFloat = (realtimeModel?.humidity!)!
        self.humidity = "\(Int(humidity*100))%"
        self.somatosensoryStr = "\(Int(TempratureHumidity2Somatosensory.shared.getSomatosensory(temprature: CGFloat(tempera), humidity: humidity)))°"
        self.humidityStr = "\(Int(humidity*100))%"
        self.timeStr = "\(Date().string(withFormat: "MM月dd日"))   \(Date().week())" //  \(Date().string(withFormat: "HH:mm"))
        self.currentValue = CGFloat(tempera)
        
        /// 紫外线
        self.ultraviolet = realtimeModel?.ultraviolet
        
        /// 体感温度
        self.apparent_temperature = "\((lroundf(Float((realtimeModel?.apparent_temperature!)!))))"
        
        /// 空气质量全量数据
        self.air_quality = realtimeModel?.air_quality
        
        /// 外出建议
        self.proposal = realtimeModel?.remindContent ?? "--"
        
        /// 发布时间
        self.releaseTime = realtimeModel?.releaseTime!
        
        /// 能见度
        self.visibility = realtimeModel?.visibility ?? 10.0
        
        /// 气压
        self.pressure = realtimeModel?.pressure ?? 0
        
        /// 日出时间和日落时间
        self.astro = realtimeModel?.astro!
        
        if realtimeModel?.temperature == nil {
            return
        }
        
    }
    
    /** 根据后端信息获取当前的详情页展示信息 */
    init(_ temperature: [String: Any]?, skycon_08h_20h: [String: Any]?, skycon_20h_32h: [String: Any]?, wind: [String: Any]?, humidity: [String: Any]?, aqi: [String: Any]?, windInfo: [String: Any]?, astroInfo: [String: Any]?) {
        super.init()
        /// 获取日期字符串
        let currentDayStr: String = temperature!["date"] as! String
        let itemTimeStr: NSString = currentDayStr.timeToyyyy_MM_ddHHMM() as NSString
        /// 将日期字符串转成日期对象
        let currentDate: Date = (itemTimeStr as String).stringConvertDate("yyyy-MM-dd HH:mm")
        self.dateStr = currentDate.week()
        self.weekStr = currentDate.getWeekInYear()
        self.timeFlashStr = currentDate.getFlashDate()
        let windAvg: [String: Any] = wind!["avg"] as! [String: Any]
        let windSpeed: Double = ((windAvg["speed"] as! Double) * 1000.0)/3600.0
        self.wind = "\(Int(windSpeed))"
        
        self.windPower = "\(WindSpeed2Level.shared.windLevel(windSpeed.roundTo(places: 2)))"
        let direction: CGFloat = windAvg["direction"] as! CGFloat
        self.windDirection = "\(Angle2WindDirection.shared.windDirection(direction))风"
        let aqiAvg: [String: Any] = aqi!["avg"] as! [String: Any]
        let AQI: CGFloat  = aqiAvg["chn"] as! CGFloat
        self.AQI = AQI
        self.aqiColor = AQI2AirQuiltyDescription.shared.getAQIColor(NSInteger(AQI))
        self.aqi = "\(NSInteger(AQI))"
        self.aqiStrokeValue = AQI2AirQuiltyDescription.shared.getAQIStrokeValue(NSInteger(AQI))
        self.weatherQualityStr = AQI2AirQuiltyDescription.shared.getAQITitle(NSInteger(AQI))
        let temperaMax: CGFloat = temperature!["max"] as! CGFloat
        let temperaMin: CGFloat = temperature!["min"] as! CGFloat
        let tempMax: NSInteger = (lroundf(Float(temperaMax)))
        let tempMin: NSInteger = (lroundf(Float(temperaMin)))
        self.currentMax = CGFloat(tempMax)
        self.currentMin = CGFloat(tempMin)
        self.skycon = (skycon_08h_20h!["value"]! as! String)
        self.weatherStr = "\(Skycon2WeatherDescription.shared.weatherDescription(self.skycon!))"
        
        let humidityAvg: CGFloat = humidity!["avg"] as! CGFloat
        self.humidity = "\(Int(humidityAvg*100))%"
        
        /// 设置夜间天气
        self.night_skycon = (skycon_20h_32h!["value"]! as! String)
        self.night_weather_value = "\(Skycon2WeatherDescription.shared.weatherDescription(self.night_skycon!))"
        
        /// 日出时间和日落时间
        self.astro = astroInfo
        
        /// 设置夜间风力风向
        self.night_wind_direction = windInfo!["direction"] as? String
        self.night_wind_level = windInfo!["rank"] as? String

    }
}
