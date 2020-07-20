//
//  SwitchRootController.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import UIKit
import AMScrollingNavbar

struct SwitchRootController {
    
    /// 切换当前控制器为根控制器
    static func switchto() {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let realFocastNavi: ScrollingNavigationController = ScrollingNavigationController(rootViewController: RealTimeForcastController())
        delegate.window?.rootViewController = realFocastNavi
    }
    
    /// 获取跟控制器
    static func getRootController() -> UIViewController {
        if FirstLaunch.isFirstLaunch() {
            return OnBoardingController()
        } else {
            return ScrollingNavigationController(rootViewController: RealTimeForcastController())
        }
    }
}
