//
//  WeatherBackgroudEffictive.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class WeatherBackgroudEffictive: UIView {

    // MARK:- 创建视图
    class func instance() -> WeatherBackgroudEffictive? {
         let nibView = Bundle.main.loadNibNamed("WeatherBackgroudEffictive", owner: nil, options: nil);
         if let view = nibView?.first as? WeatherBackgroudEffictive {
             view.backgroundColor = UIColor.clear
             return view
         }
         return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }

    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }

    /** 根据参数返回当前item的高度 */
    static var layoutHeight: CGFloat {
        return 400
    }

}
