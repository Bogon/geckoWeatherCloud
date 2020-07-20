//
//  WindSpeed2Level.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

/** 根据风速计算风力等级 */
struct WindSpeed2Level {

    internal static let shared = WindSpeed2Level()
    private init() {}
    
    /** 根据风速计算风力等级 */
    func windLevel(_ windSpeed: Double) -> String {
        
        let wind: Double = windSpeed.roundTo(places: 1)
        if wind <= 0.2 {    /// 0级
            return "0级"
        } else if wind <= 1.5 && wind >= 0.3 {
            return "1级"
        } else if wind <= 3.3 && wind >= 1.6 {
            return "2级"
        } else if wind <= 5.4 && wind >= 3.4 {
            return "3级"
        } else if wind <= 7.9 && wind >= 5.5 {
            return "4级"
        } else if wind <= 10.7 && wind >= 8.0 {
            return "5级"
        } else if wind <= 13.8 && wind >= 10.8 {
            return "6级"
        } else if wind <= 17.1 && wind >= 13.9 {
            return "7级"
        } else if wind <= 20.7 && wind >= 17.2 {
            return "8级"
        } else if wind <= 24.4 && wind >= 20.8 {
            return "9级"
        } else if wind <= 28.4 && wind >= 24.5 {
            return "10级"
        } else if wind <= 32.6 && wind >= 28.5 {
            return "11级"
        } else if wind <= 36.9 && wind >= 32.7 {
            return "12级"
        } else if wind <= 41 && wind >= 37 {
            return "13级"
        } else if wind <= 45 && wind >= 42 {
            return "14级"
        } else if wind <= 51 && wind >= 46 {
            return "15级"
        } else if wind <= 59 && wind >= 52 {
            return "16级"
        } else if wind <= 69 && wind >= 60 {
            return "17级"
        } else if wind >= 70 {
            return "18级"
        }
        return "0级"
    }
    
}

