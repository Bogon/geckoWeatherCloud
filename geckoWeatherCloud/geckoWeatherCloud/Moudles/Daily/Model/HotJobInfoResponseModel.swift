//
//  HotJobInfoResponseModel.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources
import LKDBHelper

/// 热门API获取当前的数据
struct HotJobInfoResponseModel: Mappable {
    var status: Int?
    var msg: String?
    var result: HotJobListInfoModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status        <- map["status"]
        msg         <- map["msg"]
        result        <- map["result"]
    }

}

/// 热门兼职数据列表
struct HotJobListInfoModel: Mappable {
    var baseQuery: String?
    var dispCateId: String?
    var getListInfo: [Any]?
    var lastPage: String?
    var pageIndex: String?
    var pageSize: String?
    var pubTitle: String?
    var pubUrl: String?
    var recType: String?
    var recommend: String?
    var searchNum: String?
    var showLocalTip: String?
    var tabTitle: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        baseQuery           <- map["baseQuery"]
        dispCateId          <- map["dispCateId"]
        getListInfo         <- map["getListInfo"]
        lastPage            <- map["lastPage"]
        pageIndex           <- map["pageIndex"]
        pageSize            <- map["pageSize"]
        pubTitle            <- map["pubTitle"]
        pubUrl              <- map["pubUrl"]
        recType             <- map["recType"]
        recommend           <- map["recommend"]
        searchNum           <- map["searchNum"]
        showLocalTip        <- map["showLocalTip"]
        tabTitle            <- map["tabTitle"]
    }
    
    // 计算类型数据
    var jobInfoList: [HotJobItemInfoModel]? {
        
        var jobInfosList: [HotJobItemInfoModel] = [HotJobItemInfoModel]()
        
        guard let listInfo = getListInfo else { return jobInfosList }
        
        for (_, value) in listInfo.enumerated() {
            let jobInfo: [String: Any] = value as! [String: Any]
            if jobInfo.keys.contains("xinzi") {
                let jobInfoModel: HotJobItemInfoModel = HotJobItemInfoModel.init(JSON: jobInfo)!
                jobInfosList.append(jobInfoModel)
            }
        }
        
        return jobInfosList
    }

}

struct HotJobListSection {
    var items: [Item]
}

extension HotJobListSection: SectionModelType {
    
    typealias Item = HotJobItemInfoModel

    init(original: HotJobListSection, items: [HotJobListSection.Item]) {
        self = original
        self.items = items
    }
}

/// 保存到数据库中JOb的类型信息
enum StoreJobType: Int {
    // 浏览
    case just_look = 0
    // 报名参加
    case just_join = 1
    // 收藏
    case just_like = 2
    // 原始展示
    case none      = 3
}

/// 热门兼职数据
@objc class HotJobItemInfoModel: NSObject, Mappable {
    @objc var xinzi: String?
    @objc var longterm: String?
    @objc var qyname: String?
    @objc var buttonTitle: String?
    @objc var title: String?
    @objc var type: String?
    @objc var userID: String?
    @objc var dateShow: String?
    @objc var biz: Bool = false
    @objc var bottomTags: [String: Any]?
    @objc var checkbox: Bool = false
    @objc var jumpAction: [String: Any]?
    @objc var catename: String?
    @objc var contract: String?
    @objc var xinzijiesuan: String?
    @objc var url: String?
    @objc var quyu: String?
    @objc var labelAddr: [String]?
    @objc var validity: String?
    @objc var jobTags: [Any]?
    @objc var pageview: String?
    @objc var infoID: String?
    @objc var _id: String?
    // 关联用户id, 为空时表示在游客模式
    @objc var user_id: String = ""
    // 收藏job的类型
    @objc var store_job_type: Int = StoreJobType.none.rawValue
    /// 主键
    @objc var job_id: String? { UUID().uuidString }
    /// 创建时间
    @objc var insert_time: TimeInterval = Date().millisecond
    
    @objc var info_id: String? {
        let jobJumpInfo: [String: Any] = jumpAction!["content"] as! [String : Any]
        let _infoID: String = jobJumpInfo["infoID"] as! String
        return _infoID
        
    }
    
    required init?(map: Map) {
        
    }
    
    override init() {
        super.init()
    }
    
    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "_id"
    }
    
    override static func getTableName() -> String {
        return "HotJobItemInfoModel"
    }
    
    func mapping(map: Map) {
        xinzi          <- map["xinzi"]
        longterm       <- map["longterm"]
        qyname         <- map["qyname"]
        buttonTitle    <- map["buttonTitle"]
        title          <- map["title"]
        type           <- map["type"]
        userID         <- map["userID"]
        dateShow       <- map["dateShow"]
        biz            <- map["biz"]
        bottomTags     <- map["bottomTags"]
        checkbox       <- map["checkbox"]
        jumpAction     <- map["jumpAction"]
        catename       <- map["catename"]
        contract       <- map["contract"]
        xinzijiesuan   <- map["xinzijiesuan"]
        url            <- map["url"]
        quyu           <- map["quyu"]
        labelAddr      <- map["labelAddr"]
        validity       <- map["validity"]
        jobTags        <- map["jobTags"]
        pageview       <- map["pageview"]
        infoID         <- map["infoID"]
    }
    //
    
    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/CityCloudDatabase.db"
        let db: LKDBHelper = LKDBHelper.init(dbPath: targetPath)
        return db
    }
    
    // 计算类型数据：工作类型
    var job_tags: [String]? {
        var jobTagsList: [String] = [String]()
        
        guard let listInfo = jobTags else { return jobTagsList }
        
        for (_, value) in listInfo.enumerated() {
            let jobInfo: [String: Any] = value as! [String: Any]
            if jobInfo.keys.contains("text") {
                jobTagsList.append(jobInfo["text"] as! String)
            }
        }
        return jobTagsList
       
    }
    
    // 计算类型数据：工作详情
    var jump_url: String? {
        var url: String = ""
        let jobJumpInfo: [String: Any] = jumpAction!["content"] as! [String : Any]
        let list_name: String = jobJumpInfo["list_name"] as! String
        let infoID: String = jobJumpInfo["infoID"] as! String
        url = "/\(list_name)/\(infoID)"
        return url
        
    }

}
