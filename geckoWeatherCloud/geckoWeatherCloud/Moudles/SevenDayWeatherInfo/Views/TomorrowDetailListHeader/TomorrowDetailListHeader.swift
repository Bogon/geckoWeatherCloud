//
//  TomorrowDetailListHeader.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class TomorrowDetailListHeader: UIView {

    /// tomorrow 表头提示信息
    var tomorrowToolBar: TomorrowDetailToolBar = TomorrowDetailToolBar.instance()!
    /// tomorrow 天气信息
    var tomorrowDetailWeatherV: TomorrowDetailWeatherView = TomorrowDetailWeatherView.instance()!
    
    // MARK: - 创建视图
    class func instance() -> TomorrowDetailListHeader? {
        let nibView = Bundle.main.loadNibNamed("TomorrowDetailListHeader", owner: nil, options: nil);
        if let view = nibView?.first as? TomorrowDetailListHeader {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubview(self.tomorrowToolBar)
        addSubview(self.tomorrowDetailWeatherV)
    }
    
    //MARK: - 页面元素布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// tomorrowToolBar
        tomorrowToolBar.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.size.equalTo(CGSize(width: TomorrowDetailToolBar.layoutWith, height: TomorrowDetailToolBar.layoutHeight))
        }
        
        /// tomorrow 天气信息
        tomorrowDetailWeatherV.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(tomorrowToolBar.snp.bottom).offset(15)
            make.size.equalTo(CGSize.init(width: TomorrowDetailWeatherView.layoutWith, height: TomorrowDetailWeatherView.layoutHeight))
        }
    }
    
    //MARK: - 默认属性
    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /** 根据参数返回当前item的高度 */
    static var layoutHeight: CGFloat {
        return TomorrowDetailToolBar.layoutHeight + TomorrowDetailWeatherView.layoutHeight + 20 + 15
    }

}
