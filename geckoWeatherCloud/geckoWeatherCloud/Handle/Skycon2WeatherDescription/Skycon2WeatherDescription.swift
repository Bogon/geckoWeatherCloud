//
//  Skycon2WeatherDescription.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

/** 根据天气标识返回对应中文标识 */
struct Skycon2WeatherDescription {
    
    internal static let shared = Skycon2WeatherDescription()
    private init() {}
    
    /** 根据角度计算风向 */
    func weatherDescription(_ skycon: String) -> String {
        
        switch skycon {
            case "SUNNY":
                return "晴"
            case "CLEAR_DAY":
                return "晴"
            case "CLEAR_NIGHT":
                return "晴"
            case "PARTLY_CLOUDY_DAY":
                return "多云"
            case "PARTLY_CLOUDY_NIGHT":
                return "多云"
            case "CLOUDY":
                return "阴"
            case "WIND":
                return "大风"
            case "HAZE":
                return "雾霾"
            case "RAIN":
                return "雨"
            case "SNOW":
                return "雪"
            case "LIGHT_HAZE":
                return "轻度雾霾"
            case "MODERATE_HAZE":
                return "中度雾霾"
            case "HEAVY_HAZE":
                return "重度雾霾"
            case "LIGHT_RAIN":
                return "小雨"
            case "MODERATE_RAIN":
                return "中雨"
            case "HEAVY_RAIN":
                return "大雨"
            case "STORM_RAIN":
                return "暴雨"
            case "FOG":
                return "雾"
            case "LIGHT_SNOW":
                return "小雪"
            case "MODERATE_SNOW":
                return "中雪"
            case "HEAVY_SNOW":
                return "大雪"
            case "STORM_SNOW":
                return "暴雪"
            case "DUST":
                return "浮尘"
            case "SAND":
                return "扬沙"
            case "HEIL":
                return "冰雹"
            default:
                return "无"
        }
    }
}
