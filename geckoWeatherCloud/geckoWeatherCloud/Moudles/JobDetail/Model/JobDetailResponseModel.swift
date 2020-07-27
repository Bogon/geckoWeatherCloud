//
//  JobDetailResponseModel.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

/// job详情信息
struct JobDetailResponseModel: Mappable {
    var status: Int?
    var msg: String?
    var result: [String: Any]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status          <- map["status"]
        msg             <- map["msg"]
        result          <- map["result"]
    }
    
    // 计算类型：头部工作信息
    var titleAreaInfoModel: JobTitleAreaInfoModel? {
         
        guard let info: [Any] = result?["info"] as? [Any] else {
            return nil
        }
        //let info: [Any] = result!["info"] as! [Any]
        let title_area_value: [String: Any] = info.first as! [String: Any]
        let title_area_list: [Any] = title_area_value["title_area"] as! [Any]
        let title_area_detail: [String: Any] = title_area_list.first as! [String: Any]
        let jz_titleItem: [String: Any] = title_area_detail["jz_titleItem"] as! [String: Any]
        
        let _titleAreaInfoModel: JobTitleAreaInfoModel = JobTitleAreaInfoModel(JSON: jz_titleItem)!
        return _titleAreaInfoModel
        
    }
    
    // 计算类型：工作区域信息
    var jobAreaDescInfoModel: JobAreaDescInfoModel? {
        //let info: [Any] = result!["info"] as! [Any]
        guard let info: [Any] = result?["info"] as? [Any] else {
            return nil
        }
        
        let job_area_value: [String: Any] = info[1] as! [String: Any]
        
        let _jobAreaDescInfoModel: JobAreaDescInfoModel = JobAreaDescInfoModel(JSON: job_area_value)!
        return _jobAreaDescInfoModel
        
    }
    
    // 计算类型：工作单位信息
    var jobComponyDescInfoModel: JobComponyDescInfoModel? {
        //let info: [Any] = result!["info"] as! [Any]
        guard let info: [Any] = result?["info"] as? [Any] else {
            return nil
        }
        let qy_area_job: [String: Any] = info[2] as! [String: Any]
        
        let _jobComponyDescInfoModel: JobComponyDescInfoModel = JobComponyDescInfoModel(JSON: qy_area_job)!
        return _jobComponyDescInfoModel
        
    }
}

struct HotJobDetailListSection {
    var items: [Item]
}

extension HotJobDetailListSection: SectionModelType {
    
    typealias Item = JobDetailResponseModel

    init(original: HotJobDetailListSection, items: [HotJobDetailListSection.Item]) {
        self = original
        self.items = items
    }
}

/// 兼职头部数据
struct JobTitleAreaInfoModel: Mappable {
    var title: String?
    var date: String?
    var text: String?
    var user_type: String?
    var browered: String?
    var delivery: String?
    var price: String?
    var unit: String?
    var baseinfo_area: [Any]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title                   <- map["title"]
        date                    <- map["date"]
        text                    <- map["text"]
        user_type               <- map["user_type"]
        browered                <- map["browered"]
        delivery                <- map["delivery"]
        price                   <- map["price"]
        unit                    <- map["unit"]
        baseinfo_area           <- map["baseinfo_area"]
    }
    
    // 计算类型数据: 工作时间
    var work_time: (String?, String?)? {
        
        var _work_time_title: String = ""
        var _work_time_detail: String = ""
        if baseinfo_area == nil { return (nil, nil) }
        let _work_time_value: [String: Any] = baseinfo_area?.first as! [String: Any]
        let baseinfo: [Any] = _work_time_value["baseinfo"] as! [Any]
        let work_date_value: [String: Any] = baseinfo.first as! [String: Any]
        
        _work_time_title = work_date_value["title"] as! String
        _work_time_detail = work_date_value["content"] as! String
        
        return (_work_time_title, _work_time_detail)
    }
    
    // 计算类型数据: 招聘时长
    var work_allowed: (String?, String?)? {
        
        var _work_allowed_title: String = ""
        var _work_allowed_detail: String = ""
        if baseinfo_area == nil { return (nil, nil) }
        let _work_allowed_value: [String: Any] = baseinfo_area?.first as! [String: Any]
        let baseinfo: [Any] = _work_allowed_value["baseinfo"] as! [Any]
        let _work_allowed_second_value: [String: Any] = baseinfo[1] as! [String: Any]
        
        _work_allowed_title = _work_allowed_second_value["title"] as! String
        _work_allowed_detail = _work_allowed_second_value["content"] as! String
        
        return (_work_allowed_title, _work_allowed_detail)
    }
    
    // 计算类型数据: 工作地点
    var work_address: (String?, String?)? {
        
        var _work_address_title: String = ""
        var _work_address_detail: String = ""
        if baseinfo_area == nil { return (nil, nil) }
        let _work_address_value: [String: Any] = baseinfo_area?.first as! [String: Any]
        let baseinfo: [Any] = _work_address_value["baseinfo"] as! [Any]
        let _work_address_third_value: [String: Any] = baseinfo[2] as! [String: Any]
        let _work_address_third_detail_value: [String: Any] = _work_address_third_value["mapAddressItem"] as! [String: Any]
        
        _work_address_title = _work_address_third_detail_value["title"] as! String
        _work_address_detail = _work_address_third_detail_value["content"] as! String
        
        return (_work_address_title, _work_address_detail)
    }

}

/// 兼职工作范围数据
struct JobAreaDescInfoModel: Mappable {
    
    var desc_area_job: [Any]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        desc_area_job           <- map["desc_area_job"]
    }
    
    // 计算类型数据: 职位描述
    var desc_job: (String?, String?)? {
        
        var _desc_job_title: String = ""
        var _desc_job_detail: String = ""
        if desc_area_job == nil { return (nil, nil) }
        let _desc_job_title_value: [String: Any] = desc_area_job?.first as! [String: Any]
        let labelItem: [String: Any] = _desc_job_title_value["labelItem"] as! [String: Any]
        _desc_job_title = labelItem["title"] as! String
        
        let _desc_job_detail_value: [String: Any] = desc_area_job?[1] as! [String: Any]
        let jobDescItem: [String: Any] = _desc_job_detail_value["jobDescItem"] as! [String: Any]
        _desc_job_detail = jobDescItem["text"] as! String
        
        return (_desc_job_title, _desc_job_detail)
    }

}

/// 兼职企业数据
struct JobComponyDescInfoModel: Mappable {
    
    var qy_area_job: [Any]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        qy_area_job           <- map["qy_area_job"]
    }
    
    // 计算类型数据: 单位头部描述
    var title: String? {
        
        var _title: String = ""
        if qy_area_job == nil { return nil }
        let _desc_job_title_value: [String: Any] = qy_area_job?.first as! [String: Any]
        
        let labelItem: [String: Any] = _desc_job_title_value["labelItem"] as! [String: Any]
        _title = labelItem["title"] as! String
        
        return _title
    }

    
    // 计算类型数据: 单位详细信息描述
    var componyInfoModel: JobComponyInfoModel? {
        
        if qy_area_job == nil { return nil }
        let _compony_value: [String: Any] = qy_area_job![1] as! [String: Any]
        let companyInfoItem: [String: Any] = _compony_value["companyInfoItem"] as! [String: Any]
        
        let _componyInfoModel: JobComponyInfoModel = JobComponyInfoModel(JSON: companyInfoItem)!
        
        return _componyInfoModel
    }
    
    // 计算类型数据: 单位地址以及经营范围描述
    var componyAddressInfoModel: JobComponyAddressInfoModel? {
        if qy_area_job == nil { return nil }
        let _compony_value: [String: Any] = qy_area_job![2] as! [String: Any]
        let companyDetailItem: [String: Any] = _compony_value["companyDetailItem"] as! [String: Any]
        
        let _componyAddressInfoModel: JobComponyAddressInfoModel = JobComponyAddressInfoModel(JSON: companyDetailItem)!
        
        return _componyAddressInfoModel
    }

}

struct JobComponyInfoModel: Mappable {
    
    var _id: String?
    var name: String?
    var company: String?
    var label: String?
    var authentication: String?
    var protection: String?
    var tmallState: String?
    var realName: String?
    var size: String?
    var nature: String?
    var trade: String?
    var address: String?
    var logo: String?
    var alias: String?
    var jobcate: String?
    var position: String?
    var auth: String?
    var authico: String?
    var catetype: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        _id                 <- map["id"]
        name                <- map["name"]
        company             <- map["company"]
        label               <- map["label"]
        authentication      <- map["authentication"]
        protection          <- map["protection"]
        tmallState          <- map["tmallState"]
        
        realName            <- map["realName"]
        size                <- map["size"]
        nature              <- map["nature"]
        trade               <- map["trade"]
        address             <- map["address"]
        logo                <- map["logo"]
        alias               <- map["alias"]
        
        jobcate             <- map["jobcate"]
        position            <- map["position"]
        auth                <- map["auth"]
        authico             <- map["authico"]
        catetype            <- map["catetype"]
    }
    
}

struct JobComponyAddressInfoModel: Mappable {
    
    var title: String?
    var content: String?
    var companyDesc: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title                   <- map["title"]
        content                 <- map["content"]
        companyDesc             <- map["companyDesc"]
    }

}
