//
//  RealTimeForcastController+NavigationBarStyle.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import UIKit

extension RealTimeForcastController {
    
    func navigationBarSetting() {
        
        navigationController?.navigationBar.barTintColor = UIColor.init(hex: "#11103a") /// 设置导航栏
        navigationController?.navigationBar.isTranslucent = false    /// 去除磨砂效果
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#FFFFFF"),NSAttributedString.Key.font : UIFont
                            .boldSystemFont(ofSize: 18)]
        
        /// 修改返回按钮的颜色
        let backItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backItem

    }
}
