//
//  UserInfoModel.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import LKDBHelper


@objc class UserInfoModel: NSObject {
    @objc var user_id: String                   = UUID().uuidString         /// 主键
    @objc var nickname: String?                 = ""        /// 昵称
    @objc var password: String?                 = ""        /// 密码
    @objc var avatar: Image?                    = Asset.avatarLogin.image        /// 头像
    @objc var email: String?                    = ""        /// 邮件
    @objc var is_logining: Int                  = 0         /// 是否当前在登录： 0 - 未登录状态；1 - 登录状态
    @objc var insert_time: TimeInterval         = Date().millisecond    /// 创建时间
    @objc var update_time: TimeInterval         = Date().millisecond    /// 更新时间
    
    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "user_id"
    }
    
    override static func getTableName() -> String {
        return "UserInfoModel"
    }

    override init() {
        super.init()
    }
    
    /// 初始化用户对象
    init(nickname value: String?, _password: String, _email: String, is_login: Bool?) {
        super.init()
        nickname = value ?? RandomString.shared.getRandomStringOfLength(length: 8)
        password = _password
        email = _email
        is_logining = (is_login ?? false) ? 1 : 0
    }
    
    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/CityCloudDatabase.db"
        let db: LKDBHelper = LKDBHelper.init(dbPath: targetPath)
        return db
    }
    
}
