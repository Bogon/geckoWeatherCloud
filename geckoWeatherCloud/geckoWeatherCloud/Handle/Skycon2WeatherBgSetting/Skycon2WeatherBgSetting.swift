//
//  Skycon2WeatherBgSetting.swift
//  geckoWeatherCloud
//
//  Created by Bogon on 2020/6/24.
//  Copyright © 2020 Bogon. All rights reserved.
//

import Foundation

/// 全局颜色设置
struct Skycon2WeatherBgSetting {
    
    /// 根据当前天，返回背景图片和和背景色
    static func getWeatherColor(WeatherType type: SkyconType) -> [String: Any] {
        var weatherInfo: [String: Any] = ["color": "#116BFF", "imagename": "UNKNOW-B"]
        switch type {
        
            case .CLEAR_DAY:
                weatherInfo = ["color": "#116BFF", "imagename": "CLEAR_DAY-B"]
            
            case .CLEAR_NIGHT:
                weatherInfo = ["color": "#052687", "imagename": "CLEAR_NIGHT-B"]
            
            case .PARTLY_CLOUDY_DAY:
                weatherInfo = ["color": "#1397EC", "imagename": "PARTLY_CLOUDY_DAY-B"]
            
            case .PARTLY_CLOUDY_NIGHT:
                weatherInfo = ["color": "#051B63", "imagename": "PARTLY_CLOUDY_NIGHT-B"]
            
            case .CLOUDY:
                weatherInfo = ["color": "#0190CC", "imagename": "CLOUDY-B"]
            
            case .WIND:
                weatherInfo = ["color": "#777BD6", "imagename": "WIND-B"]
            
            case .DUST, .SAND:
                weatherInfo = ["color": "#787879", "imagename": "HAZE-B"]
            
            case .FOG:
                weatherInfo = ["color": "#7EB5B5", "imagename": "FOG-B"]
              
            case .LIGHT_HAZE, .MODERATE_HAZE, .HEAVY_HAZE:
                weatherInfo = ["color": "#919DB5", "imagename": "LIGHT_HAZE-B"] /// 填充纯色值：#585572（轻度雾霾）
            
            case .LIGHT_RAIN, .MODERATE_RAIN, .HEAVY_RAIN, .STORM_RAIN:
                weatherInfo = ["color": "#3784A8", "imagename": "RAIN-B"]
            
            case .LIGHT_SNOW, .MODERATE_SNOW, .HEAVY_SNOW, .STORM_SNOW:
                weatherInfo = ["color": "#87AABD", "imagename": "SNOW-B"]

            case .HAIL:
                weatherInfo = ["color": "#5E8E90", "imagename": "HAIL-B"]
            
            case .THUNDER_SHOWER:
                weatherInfo = ["color": "#6B5078", "imagename": "THUNDER_SHOWER-B"]
            case .SLEET:
                weatherInfo = ["color": "#3B86BF", "imagename": "SLEET-B"]
            case .UNKNOW:
                weatherInfo = ["color": "#116BFF", "imagename": "UNKNOW-B"]
        }
        
        return weatherInfo
    }
}
