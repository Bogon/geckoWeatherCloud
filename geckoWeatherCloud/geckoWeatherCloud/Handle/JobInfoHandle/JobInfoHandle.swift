//
//  JobInfoHandle.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

struct JobInfoHandle {
    
    static internal let share = JobInfoHandle()
    private init() {}
    
    //MARK: - 获取保存的job的信息数据
    /// 获取保存的job的信息数据: 条件：用户ID，收藏job的类型，按照插入时间倒序
    ///
    /// - Parameter jobInfo: job信息，必填数据
    /// - Parameter store_job_type: 保存的job信息类型，必填数据
    /// - Returns: [HotJobItemInfoModel]: 搜藏job数组
    func selecteJobList(storeJobType store_job_type: StoreJobType) -> [HotJobItemInfoModel] {
        
        // 获取当前用户信息
        let user_login_info:(Bool, UserInfoModel?) = UserInfoHandle.share.selectLoginingUserInfo()
        let user_id: String = user_login_info.0 ? (user_login_info.1! as UserInfoModel).user_id : ""
        let helper = HotJobItemInfoModel.helper
        let sql: String = "select * from HotJobItemInfoModel where user_id='\(user_id)' and store_job_type=\(store_job_type.rawValue) order by insert_time DESC;"
        let list: [HotJobItemInfoModel] = helper.search(withSQL: sql, to: HotJobItemInfoModel.self) as! [HotJobItemInfoModel]
        return list
    }
    
    //MARK: - 使用事务插入job的信息数据
    /// 使用事务插入用户数据
    ///
    /// - Parameter jobInfo: job信息，必填数据
    /// - Parameter store_job_type: 保存的job信息类型，必填数据
    /// - Returns: 无返回值
    func insert(jobInfo value: HotJobItemInfoModel?, store_job_type: StoreJobType) {
        guard let _jobInfo = value else { return }
        
        // 获取当前用户信息
        let user_login_info:(Bool, UserInfoModel?) = UserInfoHandle.share.selectLoginingUserInfo()
        let user_id: String = user_login_info.0 ? (user_login_info.1! as UserInfoModel).user_id : ""
        _jobInfo.user_id = user_id
        _jobInfo.store_job_type = store_job_type.rawValue
        _jobInfo.infoID = _jobInfo.info_id
        _jobInfo._id = _jobInfo.job_id
        
        let is_exist: Bool = isExist(storeJobType: store_job_type, user_id: user_id, info_id: value?.infoID ?? "")
        /// 如果数据库中已存在，不再插入
        if is_exist { return }
        /// 使用事务插入数据
        HotJobItemInfoModel.helper.execute { (_helper) -> Bool in
            let insertSucceed = _helper.insert(toDB: _jobInfo)
            return insertSucceed
        }
    }
    
    //MARK: - 获取保存的job的信息是否存在
    /// 获取保存的job的信息是否存在: 条件：用户ID，收藏job的类型，infoID
    ///
    /// - Parameter user_id: 用户唯一标识，必填数据
    /// - Parameter store_job_type: 保存的job信息类型，必填数据
    /// - Parameter info_id: job唯一标识，必填数据
    /// - Returns: Bool: true - 已存在；false - 不存在
    func isExist(storeJobType store_job_type: StoreJobType, user_id: String, info_id: String) -> Bool {
           
        // 获取当前用户信息
        let user_login_info:(Bool, UserInfoModel?) = UserInfoHandle.share.selectLoginingUserInfo()
        let user_id: String = user_login_info.0 ? (user_login_info.1! as UserInfoModel).user_id : ""
        let helper = HotJobItemInfoModel.helper
        let sql: String = "select * from HotJobItemInfoModel where user_id='\(user_id)' and store_job_type=\(store_job_type.rawValue) and infoID='\(info_id)';"
        let list: [HotJobItemInfoModel] = helper.search(withSQL: sql, to: HotJobItemInfoModel.self) as! [HotJobItemInfoModel]
        return list.count != 0 ? true : false
    }
}
