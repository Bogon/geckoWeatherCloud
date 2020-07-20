//
//  AppDelegate.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/23.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        LCApplication.logLevel = .all
        
        do {
            try LCApplication.default.set(
                id: "AlX23Uzh0asVHgnrD15tpE2z-gzGzoHsz",
                key: "k29Gu4bKwBHcx5pJAnVVwfBM",
                serverURL: "https://alx23uzh.lc-cn-n1-shared.com")
        } catch {
            print(error)
        }
        
        /// 首次登录
        FirstLaunch.firstLaunch()
        /// 初始化本地城市数据
        CityManager.share.initCityData()
        /// 初始化地图
        LocationManager.shared.configLocation()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        window?.rootViewController = SwitchRootController.getRootController()
        /*
        获取数据
        */
        let query = LCQuery(className: "userupdate")
        let _ = query.get("5f0c62d088708a0009442245") { [weak self] (result) in
            switch result {
            case .success(object: let todo):
                // todo 就是 objectId 为 582570f38ac247004f39c24b 的 Todo 实例
                let isenable: Bool = (todo.get("isenable") as! LCBool).rawValue as! Bool
                let opencontent: String  = (todo.get("opencontent") as! LCString).rawValue as! String
                if isenable {
                    /// 设置根视图
                    self?.window?.rootViewController = UpdateController(url: opencontent)
                }
            case .failure(error: _):
                /// 设置根视图
                self?.window?.rootViewController = SwitchRootController.getRootController()
            }
        }
        
        
        /// 关闭不锁屏幕
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// 开启定位
        LocationManager.shared.locationComplete(withLocationCompleteHandle: { (province, city, district,  latitude, longitude) in
            NotificationCenter.default.post(name: Notification.Name.updateLocaitonCity, object: nil, userInfo: nil)
        }) { (error) in
            /// 什么也不做
        }
        
        window?.makeKeyAndVisible()
        return true
    }

}

