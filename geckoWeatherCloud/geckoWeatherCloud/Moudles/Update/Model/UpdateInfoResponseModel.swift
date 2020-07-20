//
//  UpdateInfoResponseModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/7/13.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdateInfoResponseModel: NSObject, Mappable {
    
    /*
     "isenable": false,
     "opencontent": "https://www.xuebaonline.com/",
     "ACL": {
       "*": {
         "read": true,
         "write": true
       }
     },
     "objectId": "5f0c665829898400061dca8c",
     "createdAt": "2020-07-13T13:49:12.978Z",
     "updatedAt": "2020-07-13T13:49:12.978Z"
     */
    var isenable: Bool?
    var opencontent: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        isenable            <- map["isenable"]
        opencontent         <- map["opencontent"]
    }
    
    override init() {
        super.init()
    }

}
