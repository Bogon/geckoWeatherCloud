//
//  LifeAssistantDescriptionByType.swift
//  geckoWeatherCloud
//
//  Created by Bogon on 2020/6/24.
//  Copyright © 2020 Bogon. All rights reserved.
//

import Foundation

/// 生活助手类型
enum LiftAssistantType : Int {
    
    /// 穿衣提醒
    case dressing               = 120
    /// 带伞
    case umbrella               = 121
    /// 感冒
    case flu                    = 122
    /// 紫外线
    case uv                     = 123
    /// 晾晒
    case airing                 = 124
    /// 晨练
    case morning_sport          = 125
    /// 旅游
    case travel                 = 126
    /// 钓鱼
    case fishing                = 127
    /// 洗车
    case car_washing            = 128
    /// 过敏
    case allergy                = 129
    /// 化妆
    case makeup                 = 130
    /// 风寒
    case chill                  = 131
    /// 心情
    case mood                   = 132
    /// 户外
    case sport                  = 133
    /// 防晒
    case sunscreen              = 134
    
}

/** 根据生活指数类型返回文字描述 */
struct LifeAssistantDescriptionByType {
    
    internal static let shared = LifeAssistantDescriptionByType()
    private init() {}
    
    /** 根据生活指数类型返回文字描述 */
    func getLiftAssistantTitle(WithLiftAssistantType liftAssistantType: LiftAssistantType) -> String {
        var title: String = ""
        switch liftAssistantType {
            case .dressing:
                title = "穿衣"
            case .umbrella:
                title = "雨伞"
            case .flu:
                title = "感冒"
            case .uv:
                title = "紫外线"
            case .airing:
                title = "晾晒"
            case .morning_sport:
                title = "晨练"
            case .travel:
                title = "旅游"
            case .fishing:
                title = "钓鱼"
            case .car_washing:
                title = "洗车"
            case .allergy:
                title = "过敏"
            case .makeup:
                title = "化妆"
            case .chill:
                title = "风寒"
            case .mood:
                title = "心情"
            case .sport:
                title = "户外"
            case .sunscreen:
                title = "防晒"
        }
 
        return title
    }
    
    /** 根据生活指数类型返回文字图片 */
    func getLiftAssistantImagename(WithLiftAssistantType liftAssistantType: LiftAssistantType) -> String {
        var title: String = ""
        switch liftAssistantType {
            case .dressing:
                title = "dressing"
            case .umbrella:
                title = "umbrella"
            case .flu:
                title = "flu"
            case .uv:
                title = "uv"
            case .airing:
                title = "airing"
            case .morning_sport:
                title = "morning_sport"
            case .travel:
                title = "travel"
            case .fishing:
                title = "fishing"
            case .car_washing:
                title = "car_washing"
            case .allergy:
                title = "allergy"
            case .makeup:
                title = "makeup"
            case .chill:
                title = "chill"
            case .mood:
                title = "mood"
            case .sport:
                title = "sport"
            case .sunscreen:
                title = "sunscreen"
        }
        return title
    }
}
