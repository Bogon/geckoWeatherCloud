//
//  SevenDayWeatherInfoController+NavigationBar.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import UIKit


extension SevenDayWeatherInfoController {
    
    func navigationBarSetting() {
        
        navigationController?.navigationBar.barTintColor = UIColor.init(hex: "#11103a") /// 设置导航栏
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false    /// 去除磨砂效果
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#000000"),NSAttributedString.Key.font : UIFont
                          .boldSystemFont(ofSize: 18)]
        navigationController?.navigationBar.tintColor = .white  /// 修改返回按钮的颜色
        
    }
}
