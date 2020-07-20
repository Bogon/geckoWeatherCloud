//
//  SevenDayWeatherInfoController+Layout.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import UIKit

fileprivate let ContentScrollViewWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

extension SevenDayWeatherInfoController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.init(hex: "#11103a")
        initSubView()
        
    }
    
    private func initSubView() {
        self.contentTableView.registerCellNib(DayDetailWeatherTableCell.self)
        contentTableView.frame = CGRect(x: 0, y: 0, width: ContentScrollViewWidth, height: UIScreen.main.bounds.height - TopMarginX.topMargin)
        view.addSubview(contentTableView)
        tomorrowListHeader.frame = CGRect(x: 0, y: 0, width: TomorrowDetailListHeader.layoutWith, height: TomorrowDetailListHeader.layoutHeight)
        contentTableView.tableHeaderView = tomorrowListHeader
        contentTableView.tableFooterView = UIView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
