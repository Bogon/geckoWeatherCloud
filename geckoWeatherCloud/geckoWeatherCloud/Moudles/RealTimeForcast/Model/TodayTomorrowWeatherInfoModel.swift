//
//  TodayTomorrowWeatherInfoModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper

/// 当天天气信息和明日天气信息model
class TodayTomorrowWeatherInfoModel: NSObject, Mappable {
    
    var todayTemprature: CGFloat? = 0                /** 当天气温 */
    var weatherStr: String? = "未知"                 /** 当天天气 */
    var currentMax: CGFloat? = 0                     /** 当天最大气温 */
    var currentMin: CGFloat? = 0                     /** 当天最低气温 */
    var airQuality: String? = "优"                   /** 空气质量 */
    /** 当前城市 */
    var location: String? {
        let infoData: CityModel = CityManager.share.locationCity()
        return infoData.district ?? "北京" }
    var somatosensory: String? = "0℃"               /** 体感 */
    var humidity: String? = "0%"                    /** 湿度 */
    
    var tomorrowWeather: String? = ""               /** 明日天气 */
    var tomorrowMax: CGFloat? = 0                   /** 明日最高气温 */
    var tomorrowMin: CGFloat? = 0                   /** 明日最低气温 */
    var tomorrowWeaIcon: String? = "CLEAR_DAY-C"    /** 明日天气icon */
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        todayTemprature     <- map["todayTemprature"]
        weatherStr          <- map["weatherStr"]
        currentMax          <- map["currentMax"]
        currentMin          <- map["currentMin"]
        airQuality          <- map["airQuality"]
        somatosensory       <- map["somatosensory"]
        humidity            <- map["humidity"]
        tomorrowWeather     <- map["tomorrowWeather"]
        tomorrowMax         <- map["tomorrowMax"]
        tomorrowMin         <- map["tomorrowMin"]
        tomorrowWeaIcon     <- map["tomorrowWeaIcon"]
    }
    
    override init() {
        super.init()
    }
    
    /** 当前的详情页展示信息 */
    init(_ todayWeatherInfo: [String: Any]?) {
        super.init()
        
        let weather2Description: [String: String] = ["CLEAR_DAY":"晴", "CLEAR_NIGHT":"晴", "PARTLY_CLOUDY_DAY":"多云", "PARTLY_CLOUDY_NIGHT":"多云", "CLOUDY":"阴", "LIGHT_HAZE":"轻度雾霾", "MODERATE_HAZE":"中度雾霾", "HEAVY_HAZE":"重度雾霾","RAIN":"有雨", "LIGHT_RAIN":"小雨", "MODERATE_RAIN":"中雨", "HEAVY_RAIN":"大雨", "STORM_RAIN":"暴雨", "FOG":"雾", "LIGHT_SNOW":"小雪", "MODERATE_SNOW":"中雪", "HEAVY_SNOW":"大雪", "STORM_SNOW":"暴雪", "DUST":"浮尘", "SAND":"沙尘", "WIND":"大风", "THUNDER_SHOWER":"雷阵雨", "HAIL":"冰雹"]
        /** 检索当天的数据 */
        let currentTime: String = Date().string(withFormat: "yyyy-MM-dd")
        /// 获取当天的数据
        let temperatureList: [[String: Any]] = todayWeatherInfo!["temperature"] as! [[String : Any]]
        let skyconList: [[String: Any]] = todayWeatherInfo!["skycon_08h_20h"] as! [[String : Any]]
        let aqiList: [[String: Any]] = todayWeatherInfo!["aqi"] as! [[String : Any]]
        let humidityList: [[String: Any]] = todayWeatherInfo!["humidity"] as! [[String : Any]]
        
        for (i, item) in temperatureList.enumerated() {
            /** 构造当天需要的数据 */
            let timeItemStr: String = item["date"] as! String
            if timeItemStr.substring(to: 9) == currentTime {     /// 今天的数据
                /** 当天天气 */
                let currentTemprature: CGFloat = (item["avg"] as! CGFloat)
                self.todayTemprature = currentTemprature
                /** 当天天气描述 */
                let skyconValue: [String: Any] = skyconList[i]
                let skycon: String = skyconValue["value"] as! String
                self.weatherStr = weather2Description[skycon]
                /** 当天最高气温和当天最低气温 */
                self.currentMax = (item["max"] as! CGFloat)
                self.currentMin = (item["min"] as! CGFloat)
                /** 当天温度湿度 */
                let humidityValue: [String: Any] = humidityList[i]
                let humidityCurrent: CGFloat = (humidityValue["avg"] as! CGFloat)
                self.humidity = "\(Int(humidityCurrent*100))%"
                /** 当天体感 */
                let somatosensoryValue: CGFloat = TempratureHumidity2Somatosensory.shared.getSomatosensory(temprature: currentTemprature, humidity: humidityCurrent)
                self.somatosensory = "\(Int(somatosensoryValue))℃"
                /** 空气质量 */
                let aqiValue: [String: Any] = aqiList[i]
                let currentAQI: CGFloat = aqiValue["avg"] as! CGFloat
                self.airQuality = AQI2AirQuiltyDescription.shared.getAQITitle(NSInteger(currentAQI))
            
            } else {                            /// 明天的数据
                /** 明天天气描述 */
                let skyconValue: [String: Any] = skyconList[i]
                let skycon: String = skyconValue["value"] as! String
                self.tomorrowWeather = weather2Description[skycon]
                /** 当天最高气温和当天最低气温 */
                self.tomorrowMax = (item["max"] as! CGFloat)
                self.tomorrowMin = (item["min"] as! CGFloat)
                self.tomorrowWeaIcon = "\(skycon)-C"
            }
        }
    }
}

