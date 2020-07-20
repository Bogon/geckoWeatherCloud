//
//  Angle2WindDirection.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import UIKit

/** 根据角度计算风向 */
struct Angle2WindDirection {
    
    internal static let shared = Angle2WindDirection()
    private init() {}
    
    /** 根据角度计算风向 */
    func windDirection(_ angle: CGFloat) -> String {
        if angle == 0 ||  angle == 360 {
            return "北"
        } else if angle < 90 && angle > 0 {
            return "东北"
        } else if angle == 90 {
            return "东"
        } else if angle < 180 && angle > 90 {
            return "东南"
        } else if angle == 180 {
            return "南"
        } else if angle < 270 && angle > 180 {
            return "西南"
        } else if angle == 270 {
            return "西"
        } else if angle < 360 && angle > 270 {
            return "西北"
        }
        return ""
    }
    
}
