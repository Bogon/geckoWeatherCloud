//
//  SettingHeadView.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class SettingHeadView: UIView {

 // MARK: - 创建视图
   class func instance() -> SettingHeadView? {
       let nibView = Bundle.main.loadNibNamed("SettingHeadView", owner: nil, options: nil);
       if let view = nibView?.first as? SettingHeadView {
           view.backgroundColor = .clear
           return view
       }
       return nil
   }

   override func awakeFromNib() {
       super.awakeFromNib()
       // Initialization code
   }
    //MARK: - 默认属性
    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var layoutHeight: CGFloat {
        return 195
    }
}
