//
//  SunGuageInfoModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper

/// 日规信息model
class SunGuageInfoModel: NSObject, Mappable {
    
    var currentMax: String? = "06:11"             /** 日落时间 */
    var currentMin: String? = "18:31"             /** 日出时间 */
    var currentValue: String? = "0小时1分"         /** 距日落剩余时间 */
    var sunsetAllTime: NSInteger? = 0             /** 日落时间 */
    var angle: CGFloat? = 0                       /** 太阳偏转角度 */
    var isAnimation: Bool? = false                /** 是否展示日落动画 */
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        currentValue     <- map["currentValue"]
        currentMin       <- map["currentMin"]
        currentMax       <- map["currentMax"]
    }
    
    override init() {
        super.init()
    }
    
    /** 当前的详情页展示信息 */
    init(_ astro: [String: Any]?) {
        super.init()
        let currentTime: Date = Date()
        let currentDate: String = astro!["date"] as! String
        let sunset: [String: Any] = astro!["sunset"] as! [String: Any]
        let sunrise: [String: Any] = astro!["sunrise"] as! [String: Any]
        self.currentMax = "\(currentDate.substring(to: 9)) \(sunset["time"] ?? "0:0")"
        self.currentMin = "\(currentDate.substring(to: 9)) \(sunrise["time"] ?? "0:0")"
        
        let currentMinDate: Date = (self.currentMin?.stringConvertDate("yyyy-MM-dd HH:mm"))!
        let currentMaxDate: Date = (self.currentMax?.stringConvertDate("yyyy-MM-dd HH:mm"))!
        /// 在日落范围之间 ( currentTime.timeIntervalSince1970 > currentMinDate.timeIntervalSince1970) &&(currentMaxDate.timeIntervalSince1970 > currentTime.timeIntervalSince1970)
        if ( currentTime.timeIntervalSince1970 > currentMinDate.timeIntervalSince1970) && (currentMaxDate.timeIntervalSince1970 > currentTime.timeIntervalSince1970) {
            self.isAnimation = true
            /// 获取日出和日落的时间间隔
            //let tempTime: String = "\(currentDate.substring(to: 9)) 11:30"
            
            let timeInterveal: CGFloat = CGFloat(((self.currentMax!.stringConvertDate("yyyy-MM-dd HH:mm").timeIntervalSince1970) - (self.currentMin?.stringConvertDate("yyyy-MM-dd HH:mm").timeIntervalSince1970)!))
            let currentInterveal: CGFloat = CGFloat((currentTime.timeIntervalSince1970) - (self.currentMin?.stringConvertDate("yyyy-MM-dd HH:mm").timeIntervalSince1970)!)
            //let currentInterveal: CGFloat = CGFloat((tempTime.stringConvertDate("yyyy-MM-dd HH:mm").timeIntervalSince1970) - (self.currentMin?.stringConvertDate("yyyy-MM-dd HH:mm").timeIntervalSince1970)!)
            /** 距离日落剩余时间 */
            let lastTimeINterveal: CGFloat = timeInterveal - currentInterveal
            
            let hour: Int = Int(lastTimeINterveal/60/60)
            let minute: Int = Int((lastTimeINterveal/60))%60
            if hour == 0 && minute == 0 {
                self.currentValue = "1分"
            } else {
                self.currentValue = "\(hour)小时\(minute)分"
            }
            
            self.angle = currentInterveal/timeInterveal
            
        } else if ( currentTime.timeIntervalSince1970 < currentMinDate.timeIntervalSince1970) {
            let timeInterveal: CGFloat = CGFloat(((self.currentMax!.stringConvertDate("yyyy-MM-dd HH:mm").timeIntervalSince1970) - (self.currentMin?.stringConvertDate("yyyy-MM-dd HH:mm").timeIntervalSince1970)!))
            self.angle = (1)/timeInterveal
            self.isAnimation = true
            /// 获取日出和日落的时间间隔
            self.currentValue = ""
        } else {
            self.angle = 1
            self.isAnimation = true
            /// 获取日出和日落的时间间隔
            self.currentValue = ""
        }
    }
}
