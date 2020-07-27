//
//  UserInfoHandle.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

struct UserInfoHandle {
    
    static internal let share = UserInfoHandle()
    private init() {}
    
    //MARK: - 退出登录
    /// 退出登录
    ///
    /// - Parameter value: email, 非必填数据
    /// - Parameter value: password, 非必填数据
    /// - Returns Bool: 是否登录成功
    func logout() -> Bool {
        
        var logout_result: Bool = false
        /// 1.将所有的用户置为未登录
        logout_result = UserInfoModel.helper.update(toDB: UserInfoModel.self, set: "update_time=\(Date().millisecond), is_logining=0", where: "is_logining=1")
        return logout_result
    }
    
    //MARK: - 登录
    /// 登录
    ///
    /// - Parameter value: email, 非必填数据
    /// - Parameter value: password, 非必填数据
    /// - Returns Bool: 是否登录成功
    func login(email value: String, password: String) -> Bool {
        
        var login_result: Bool = false
        
        let result:(Bool, UserInfoModel?) = selectUserInfo(email: value, password: password)
        if !result.0 {
            return false
        }
        let userInfo: UserInfoModel = result.1!
        
        /// 1.将所有的用户置为未登录
        UserInfoModel.helper.update(toDB: UserInfoModel.self, set: "update_time=\(Date().millisecond), is_logining=0", where: "is_logining=1")
        
        /// 2.登录，修改该条记录
        login_result = UserInfoModel.helper.update(toDB: UserInfoModel.self, set: "update_time=\(Date().millisecond), is_logining=1", where: "user_id=\'\(userInfo.user_id)\'")

        return login_result
    }
    
    //MARK: - 查询登录的用户数据是否存在
    /// 查询登录的用户数据是否存在
    ///
    /// - Parameter value: email, 非必填数据
    /// - Parameter value: password, 非必填数据
    /// - Returns: (Bool, UserInfoModel?): (返回当前登录的用户信息, 以及是否处于登录状态)
    func selectUserInfo(email value: String, password: String) -> (Bool, UserInfoModel?) {
        let helper = UserInfoModel.helper
        let sql: String = "select * from UserInfoModel where email=\'\(value)\' and password=\'\(password)\' order by update_time DESC limit 0,1;"
        let list: [UserInfoModel] = helper.search(withSQL: sql, to: UserInfoModel.self) as! [UserInfoModel]
        return list.count != 0 ? (true, list.first) : (false, nil)
    }
    
    //MARK: - 再次登录更新当前登录的用户数据
    /// 再次登录更新当前登录的用户数据
    ///
    /// - Returns: 无返回值
    func relogin() {
        let result:(Bool, UserInfoModel?) = selectLoginingUserInfo()
        if result.0 {
            let userInfo: UserInfoModel = result.1!
            UserInfoModel.helper.update(toDB: UserInfoModel.self, set: "update_time=\(Date().millisecond)", where: "user_id=\'\(userInfo.user_id)\'")
        }
    }
    
    //MARK: - 查询当前登录的用户数据
    /// 查询当前登录的用户数据
    ///
    /// - Returns: (Bool, UserInfoModel?): (返回当前登录的用户信息, 以及是否处于登录状态)
    func selectLoginingUserInfo() -> (Bool, UserInfoModel?) {
        let helper = UserInfoModel.helper
        let sql: String = "select * from UserInfoModel where is_logining=1 order by update_time DESC limit 0,1;"
        let list: [UserInfoModel] = helper.search(withSQL: sql, to: UserInfoModel.self) as! [UserInfoModel]
        print("list.count = \(list.count)")
        return list.count != 0 ? (true, list.first) : (false, nil)
    }
    
    //MARK: - 使用事务插入用户数据
    /// 使用事务插入用户数据
    ///
    /// - Parameter value: 非必填数据
    /// - Returns: 无返回值
    func insert(userInfo value: UserInfoModel?) {
        guard let _userInfo = value else { return }
        /// 使用事务插入数据
        UserInfoModel.helper.execute { (_helper) -> Bool in
            let insertSucceed = _helper.insert(toDB: _userInfo)
            return insertSucceed
        }
    }
    
}
