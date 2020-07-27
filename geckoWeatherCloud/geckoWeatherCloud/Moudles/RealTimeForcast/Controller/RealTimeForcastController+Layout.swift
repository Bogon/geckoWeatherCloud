//
//  RealTimeForcastController+Layout.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import AMScrollingNavbar

fileprivate let ContentScrollViewWidth: CGFloat = UIScreen.main.bounds.width

extension RealTimeForcastController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.init(hex: "#11103a")
        
        initSubView()
    }
    
    private func initSubView() {
        view.addSubview(self.backgroudV)
        view.addSubview(self.contentScrollView)
        contentScrollView.addSubview(self.realTimeWeaInfoV)
        contentScrollView.addSubview(self.hourlyToolBar)
        contentScrollView.addSubview(self.hourlyWeatherInfoV)
        contentScrollView.addSubview(self.tomorrowToolBar)
        contentScrollView.addSubview(self.tomorrowWeatherInfoV)
        
        contentScrollView.contentSize = CGSize(width: ContentScrollViewWidth, height: UIScreen.main.bounds.height + 44)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /// 背景点缀
        backgroudV.snp.remakeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.size.equalTo(CGSize.init(width: WeatherBackgroudEffictive.layoutWith, height: WeatherBackgroudEffictive.layoutHeight))
        }
        
        contentScrollView.frame = CGRect(x: 0, y: 0, width: ContentScrollViewWidth, height: UIScreen.main.bounds.height - TopMarginX.topMargin)
    
        /// 实时天气
        realTimeWeaInfoV.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(contentScrollView.snp.top).offset(20)
            make.size.equalTo(CGSize.init(width: RealTimeWeatherInfoView.layoutWith, height: RealTimeWeatherInfoView.layoutHeight))
        }
        
        /// 未来七天工具栏
        hourlyToolBar.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(realTimeWeaInfoV.snp.bottom)
            make.size.equalTo(CGSize.init(width: HourlyWeatherToolBar.layoutWith, height: HourlyWeatherToolBar.layoutHeight))
        }
        
        /// 小时级别天气预报
        hourlyWeatherInfoV.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(hourlyToolBar.snp.bottom)
            make.size.equalTo(CGSize.init(width: HourlyWeatherInfoView.layoutWith, height: HourlyWeatherInfoView.layoutHeight))
        }
        
        /// 明日天气小时级别天气工具栏
        tomorrowToolBar.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(hourlyWeatherInfoV.snp.bottom)
            make.size.equalTo(CGSize.init(width: TomorrowWeatherToolBar.layoutWith, height: TomorrowWeatherToolBar.layoutHeight))
        }
        
        /// 明日小时级别天气预报
        tomorrowWeatherInfoV.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(tomorrowToolBar.snp.bottom)
            make.size.equalTo(CGSize.init(width: TomorrowWeatherInfoView.layoutWith, height: TomorrowWeatherInfoView.layoutHeight))
        }
    }
    
    
}
