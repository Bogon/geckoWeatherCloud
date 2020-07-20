//
//  CityModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import LKDBHelper

@objc class CityModel: NSObject {
    @objc var id : NSInteger               = 0         /// id 序号
    @objc var country: String?              = ""        /// 国家
    @objc var province : String?            = ""        /// 省份
    @objc var city : String?                = ""        /// 市
    @objc var district : String?            = ""        /// 区县
    @objc var area_code : String?          = ""        /// 地址编码
    @objc var longitude : CGFloat           = 0.0       /// 经度
    @objc var latitude : CGFloat            = 0.0       /// 纬度
    @objc var city_type: Int                = 0          ///国内外城市
    @objc var pinyin_district : String?     = ""        /// 区县拼音
    @objc var recommendCity : String?       = ""        /// 推荐城市展示姓名
    @objc var isRecommend : Bool            = false     /// 是否是推荐城市
    @objc var isSelected : Bool             = false     /// 是否是添加关注
    @objc var isPositioning : Bool          = false     /// 是否是定位城市
    @objc var isDefalut : Bool              = false     /// 是否是默认城市
    @objc var selectedTimeScamp: Int       = 0           /// 添加时间
    
    var tempString: String?                 = "0°"    ///附加属性，温度
    var weatherStatus: String?              = ""        ///附加属性，天气类型
    
    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "id"
    }
    
    override static func getTableName() -> String {
        return "CityModel"
    }
    
    
    
    override init() {
        super.init()
    }
    
    /// 返回天气城市路径
    override static func getUsingLKDBHelper() -> LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/CityCloudDatabase.db"
        let db: LKDBHelper = LKDBHelper.init(dbPath: targetPath)
        return db
    }
    
    var areaCode : [String: Any] {
        guard let cityCode = area_code else {
            return ["areaCode": "", "city": district!]
        }
        return ["areaCode": cityCode, "city": district!]
    }
    
    var areaCodeValue : [String: Any] {
        guard let cityCode = area_code else {
            return ["areaCode": ""]
        }
        return ["areaCode": cityCode]
    }
    
    var longlatiInfo : [String: Any] {
        return ["longitude": longitude, "latitude": latitude]
    }
}
