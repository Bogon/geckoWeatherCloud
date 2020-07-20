//
//  TempratureHumidity2Somatosensory.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import CoreGraphics

/** 根据当前温度和湿度计算 体感温度 */
struct TempratureHumidity2Somatosensory {
    
    internal static let shared = TempratureHumidity2Somatosensory()
    private init() {}
    
    /** 根据当前温度和湿度计算体感温度 */
    func getSomatosensory(temprature: CGFloat, humidity: CGFloat) -> CGFloat {
        var _humidity: CGFloat = humidity
        var _temprature: CGFloat = temprature
        if humidity < 1 {
            _humidity = humidity * 100
        }
        _temprature = temprature * 1.8 + 32
        var somatosensory: CGFloat = 0.5 * (_temprature + 61 + (_temprature - 68) * 1.2 + _humidity * 0.094)
        if somatosensory >= 80 {    /// 如果不小于 80华氏度 则用完整公式重新计算
            somatosensory = 2.04901523 * _temprature + 10.14333127 * _humidity - 0.22475541 * _temprature * _humidity - 0.00683783 * _temprature * _temprature - 0.05481717 * _humidity * _humidity + 0.00122874 * _temprature * _temprature * _humidity + 0.00085282 * _temprature * _humidity * _humidity - 0.00000199 * _temprature * _temprature * _humidity * _humidity - 42.379
            if _humidity < 13 && (_temprature > 80 && _temprature < 112) {
                let adjustment: CGFloat = (13 - _humidity) / 4 * CGFloat(sqrt(Double((17 - abs(_temprature - 95)) / 17)))
                somatosensory -= adjustment
            } else if _humidity > 85 && (_temprature > 80 && _temprature < 87) {
                let adjustment: CGFloat = (_humidity - 85) * (87 - _temprature) / 50
                somatosensory -= adjustment
            }
        }
        return CGFloat((somatosensory - 32) / 1.8).rounded()
    }
}
