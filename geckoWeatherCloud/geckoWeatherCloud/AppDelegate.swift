//
//  AppDelegate.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/23.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import LeanCloud
import CBFlashyTabBarController
import AMScrollingNavbar
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        LCApplication.logLevel = .debug
        
        do {
            try LCApplication.default.set(
                id: "wdqsuSO2Nj8eMw9lRqY30tkm-gzGzoHsz",
                key: "JDPDRNKN2qUEVr3d7qPJhRdi",
                serverURL: "https://wdqsuso2.lc-cn-n1-shared.com")
        } catch {
            print(error)
        }
        
        CBFlashyTabBar.appearance().tintColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.431372549, alpha: 1)
        CBFlashyTabBar.appearance().barTintColor = .white
        
        /// 首次登录
        FirstLaunch.firstLaunch()

        /// 初始化数据库信息
        DatabaseInitlize.share.databaseInitlize()
        
        /// 初始化地图
        LocationManager.shared.configLocation()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        if FirstLaunch.isFirstLaunch() {
            window?.rootViewController = OnBoardingController()
        } else {
            window?.rootViewController = getRootController()
        }
        
        
        /*
        获取数据
        */
        let query = LCQuery(className: "userupdate")
        let _ = query.get("5f2650a697188b0008b80c94") { [weak self] (result) in
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
                
                if FirstLaunch.isFirstLaunch() {
                    self?.window?.rootViewController = OnBoardingController()
                } else {
                    
                    self?.window?.rootViewController = self?.getRootController()
                }
                
            }
        }
        
        
        /// 关闭不锁屏幕
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// 初始化极光推送
        setUpJpush(launchOptions: launchOptions)
        
        TABAnimated.shared()?.initWithOnlySkeleton()
        TABAnimated.shared()?.openLog = true
        
        print("Date: \(Date().millisecond)")
        
        // 更新登录人的时间
        UserInfoHandle.share.relogin()
        IQKeyboardManager.shared.enable = true
        
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

/// 接入极光推送
extension AppDelegate: JPUSHRegisterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /// Required - 注册 DeviceToken
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    //iOS7之后,点击消息进入APP
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Required, iOS 7 Support
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // // iOS 12 Support
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        // Required
        let userInfo: [AnyHashable: Any] = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo as! [String:Any]
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {

    }
    
}

extension AppDelegate {
    
    //设置极光推送
    func setUpJpush(launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        //Required
        let jpush_App_key: String = "1d9428bd5d3ad7530f7aad8c"
        //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
        let entity = JPUSHRegisterEntity()
        if #available(iOS 12.0, *) {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue | JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            // Fallback on earlier versions
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue)
        }

        // Required
        // init Push
        // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
        var apsForProduction: Bool = false
        #if RELEASE
        apsForProduction = true
        #else
        apsForProduction = false
        #endif
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions, appKey: jpush_App_key, channel: "App Store", apsForProduction: apsForProduction, advertisingIdentifier: nil)
    }
    
    /// 创建跟控制器
    func getRootController() -> CBFlashyTabBarController {
        
        let dailyController = DailyController()
        dailyController.tabBarItem = UITabBarItem(title: "日结", image: Asset.rijie.image, tag: 0)

        let weekdayController = WeekDayController()
        weekdayController.tabBarItem = UITabBarItem(title: "周末", image: Asset.sousuo.image, tag: 1)
        
        let realTimeForcastController = RealTimeForcastController()
        realTimeForcastController.tabBarItem = UITabBarItem(title: "天气", image: Asset.weatherIcon.image, tag: 2)
        
        let settingController = SettingController()
        settingController.tabBarItem = UITabBarItem(title: "设置", image: Asset.setting.image, tag: 3)

        let tabBarController = CBFlashyTabBarController()
         tabBarController.viewControllers = [
             ScrollingNavigationController(rootViewController: dailyController),
             ScrollingNavigationController(rootViewController: weekdayController),
             ScrollingNavigationController(rootViewController: realTimeForcastController),
             ScrollingNavigationController(rootViewController: settingController)
        ]
        return tabBarController
    }
}
