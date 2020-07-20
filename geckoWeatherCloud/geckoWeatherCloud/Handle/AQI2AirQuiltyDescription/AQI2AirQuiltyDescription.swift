//
//  AQI2AirQuiltyDescription.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import UIKit

/** 根据AQI计算并返回空气质量 */
struct AQI2AirQuiltyDescription {
    
    internal static let shared = AQI2AirQuiltyDescription()
    private init() {}
    
    /** 根据AQI计算并返回空气质量 */
    func getAQI(_ AQI: NSInteger) -> String {
        
        if AQI >= 0 && AQI <= 50 {
            return "\(AQI) 优"
        } else if AQI <= 100 && AQI >= 51 {
            return "\(AQI) 良"
        } else if AQI <= 150 && AQI >= 101 {
            return "\(AQI) 轻度"
        } else if AQI <= 200 && AQI >= 151 {
            return "\(AQI) 中度"
        } else if AQI >= 201 {
            return "\(AQI) 重度"
        }
        return ""
    }
    
    /** 根据AQI计算并返回空气质量 */
    func getAQIStrokeValue(_ AQI: NSInteger) -> CGFloat {
        return CGFloat(AQI)/300.0
    }
    
    /** 根据AQI计算并返回空气质量 */
    func getAQITitle(_ AQI: NSInteger) -> String {
        
        if AQI >= 0 && AQI <= 50 {
            return "优"
        } else if AQI <= 100 && AQI >= 51 {
            return "良"
        } else if AQI <= 150 && AQI >= 101 {
            return "轻度"
        } else if AQI <= 200 && AQI >= 151 {
            return "中度"
        } else if AQI >= 201 && AQI >= 250 {
            return "重度"
        } else {
            return "严重"
        }
    }
    
    /** 根据AQI计算并返回空气质量 */
    func getAQITitleDetailString(_ AQI: NSInteger) -> String {
        
        if AQI >= 0 && AQI <= 50 {
            return "优"
        } else if AQI <= 100 && AQI >= 51 {
            return "良"
        } else if AQI <= 150 && AQI >= 101 {
            return "轻度污染"
        } else if AQI <= 200 && AQI >= 151 {
            return "中度污染"
        } else if AQI >= 201 && AQI >= 250 {
            return "重度污染"
        } else {
            return "严重污染"
        }
    }
    
    /** 根据AQI计算并返回空气Label 颜色 */
    func getAQIColor(_ AQI: NSInteger) -> String {
        
        /**
         优：#16C436；良：#F7BD0C；轻度污染：#FE8C00；中度污染：#E82823；重度污染：#CE0D7A；严重污染：#A70909
         */
        if AQI >= 0 && AQI <= 50 {
            return "#80C813"
        } else if AQI <= 100 && AQI >= 51 {
            return "#D59418"
        } else if AQI <= 150 && AQI >= 101 {
            return "#D07537"
        } else if AQI <= 200 && AQI >= 151 {
            return "#C15332"
        } else if AQI >= 201 && AQI <= 300 {
            return "#A62071"
        } else if AQI > 300 {
            return "#7B2CC5"
        }
        return ""
    }
    
    /// 根据title获取相应空气质量的描述
    func getAQIItemDescription(WithTitle title: String, itemValue: CGFloat) -> [String: Any] {
        var itemInfo: [String: Any] = [String: Any]()
        switch title {
        case "no2":
            let value_roundf: NSInteger = lroundf(Float(itemValue))
            itemInfo = ["title":"NO2", "description": "二氧化氮", "value": "\(value_roundf)"]
        case "pm25":
            let value_roundf: NSInteger = lroundf(Float(itemValue))
            itemInfo = ["title":"PM2.5", "description": "细颗粒物", "value": "\(value_roundf)"]
        case "o3":
            let value_roundf: NSInteger = lroundf(Float(itemValue))
            itemInfo = ["title":"O₃", "description": "臭氧", "value": "\(value_roundf)"]
        case "so2":
            let value_roundf: NSInteger = lroundf(Float(itemValue))
            itemInfo = ["title":"SO2", "description": "二氧化硫", "value": "\(value_roundf)"]
        case "pm10":
            let value_roundf: NSInteger = lroundf(Float(itemValue))
            itemInfo = ["title":"PM10", "description": "粗颗粒物", "value": "\(value_roundf)"]
        case "co":
            itemInfo = ["title":"CO", "description": "一氧化碳", "value": "\(Double(itemValue).roundTo(places: 1))"]
        default:
            return itemInfo
        }
        return itemInfo
    }
    
    /// 根据title获取相应空气质量的解释性描述
    func getAQIDescriptionUnit(WithTitle title: String) -> [String: String] {
        var subTitleValue: [String: String] = ["":""]
        var subTitle: String = ""
        switch title {
        case "NO2":
            subTitle = "吸入过多易刺激眼睛和上呼吸道，造成咽部不适、干咳等"
            subTitleValue = ["title": subTitle, "unit": "μg/m³"]
        case "PM2.5":
            subTitle = "可深入到细支气管和肺泡。可引发心血管病、呼吸道疾病和肺癌。"
            subTitleValue = ["title": subTitle, "unit": "μg/m³"]
        case "O₃":
            subTitle = "刺激呼吸道，会造成咽喉肿痛、胸闷咳嗽、引发支气管炎和肺气肿。"
            subTitleValue = ["title": subTitle, "unit": "μg/m³"]
        case "SO2":
            subTitle = "可形成烟雾和气溶胶，随呼吸进入肺部，使人呼吸困难，并损伤肺部。"
            subTitleValue = ["title": subTitle, "unit": "μg/m³"]
        case "PM10":
            subTitle = "会积累在呼吸系统中，可以发多种疾病，对大气能见度影响很大。"
            subTitleValue = ["title": subTitle, "unit": "μg/m³"]
        case "CO":
            subTitle = "可造成头晕、缺氧甚至窒息，对心脏病和贫血和呼吸困难人群伤害大。"
            subTitleValue = ["title": subTitle, "unit": "mg/m³"]
        default:
            return subTitleValue
        }
        return subTitleValue
    }
    
    /// 根据title获取相应空气质量的是否达标
    func getAQIExcess(WithTitle title: String, value: String) -> [String: Any] {
        var subTitleValue: [String: Any] = ["":""]
        var subTitle: String = ""
        let currentValue: CGFloat = CGFloat(Double(value)!)
        var color: UIColor = UIColor.green
        var targetValue: CGFloat = 0
        switch title {
            case "NO2":
                targetValue = 500
                color = UIColor.init(hex: "#80C813")
            case "PM2.5":
                targetValue = 75
                color = UIColor.init(hex: "#80C813")
            case "O₃":
                targetValue = 300
                color = UIColor.init(hex: "#80C813")
            
            case "SO2":
                targetValue = 500
                color = UIColor.init(hex: "#80C813")
            
            case "PM10":
                targetValue = 150
                color = UIColor.init(hex: "#80C813")
            
            case "CO":
                targetValue = 10000
                color = UIColor.init(hex: "#D07537")
            
            default:
                return subTitleValue
        }
        
        subTitle = "未超标"
        if currentValue > targetValue {
            subTitle = "超标"
            //color = UIColor.orange
        }
        subTitleValue = ["title": subTitle, "color": color]
        
        return subTitleValue
    }
}
