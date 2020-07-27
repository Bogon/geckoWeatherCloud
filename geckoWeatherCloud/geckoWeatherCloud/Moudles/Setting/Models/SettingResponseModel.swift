//
//  SettingResponseModel.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct SettingListSection {
    var items: [Item]
}

extension SettingListSection: SectionModelType {
    
    typealias Item = SettingItemInfoModel

    init(original: SettingListSection, items: [SettingListSection.Item]) {
        self = original
        self.items = items
    }
}

/// 设置数据模型
struct SettingItemInfoModel: Mappable {
    
    var type: SettingType?
    var is_refresh: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        type                <- map["type"]
        is_refresh          <- map["is_refresh"]
    }

}

