//
//  SkyconType.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

/// 当前的天气的类型
enum SkyconType: String {
    typealias RawValue = String
    
    case CLEAR_DAY              = "CLEAR_DAY"               /// 晴天
    case CLEAR_NIGHT            = "CLEAR_NIGHT"             /// 晴
    case PARTLY_CLOUDY_DAY      = "PARTLY_CLOUDY_DAY"       /// 多云
    case PARTLY_CLOUDY_NIGHT    = "PARTLY_CLOUDY_NIGHT"     /// 多云
    case CLOUDY                 = "CLOUDY"                  /// 阴天
    case WIND                   = "WIND"                    /// 大风
    case LIGHT_HAZE             = "LIGHT_HAZE"              /// 轻度雾霾
    case MODERATE_HAZE          = "MODERATE_HAZE"           /// 中度雾霾
    case HEAVY_HAZE             = "HEAVY_HAZE"              /// 重度雾霾
    case LIGHT_RAIN             = "LIGHT_RAIN"              /// 小雨
    case MODERATE_RAIN          = "MODERATE_RAIN"           /// 中雨
    case HEAVY_RAIN             = "HEAVY_RAIN"              /// 大雨
    case STORM_RAIN             = "STORM_RAIN"              /// 暴雨
    case FOG                    = "FOG"                     /// 雾
    case LIGHT_SNOW             = "LIGHT_SNOW"              /// 小雪
    case MODERATE_SNOW          = "MODERATE_SNOW"           /// 中雪
    case HEAVY_SNOW             = "HEAVY_SNOW"              /// 大雪
    case STORM_SNOW             = "STORM_SNOW"              /// 暴雪
    case DUST                   = "DUST"                    /// 浮尘
    case SAND                   = "SAND"                    /// 扬沙
    case HAIL                   = "HAIL"                    /// 冰雹
    case SLEET                  = "SLEET"                   /// 雨夹雪
    case THUNDER_SHOWER         = "THUNDER_SHOWER"          /// 雷阵雨
    case UNKNOW                 = "UNKNOW"                  /// 未知天气
}
