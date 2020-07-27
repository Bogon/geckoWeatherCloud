//
//  WeekDayController+Layout.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import Hue
import MJRefresh

fileprivate let ContentScrollViewWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

extension WeekDayController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        initSubView()
        
    }
    
    private func initSubView() {
        contentTableView.frame = CGRect(x: 0, y: 0, width: ContentScrollViewWidth, height: UIScreen.main.bounds.height)
        contentTableView.delegate = self
        contentTableView.tableHeaderView = UIView()
        contentTableView.tableFooterView = UIView()
        view.addSubview(contentTableView)
        
        contentTableView.tabAnimated = TABTableAnimated.init(cellClass: JobTableViewCell.self, cellHeight: JobTableViewCell.layoutHeight)
        contentTableView.tabAnimated?.animatedSectionCount = 1
        contentTableView.tabAnimated?.showTableHeaderView = false
        contentTableView.tabAnimated?.superAnimationType = .shimmer
        contentTableView.tabAnimated?.canLoadAgain = true
        contentTableView.register(cellType: JobTableViewCell.self)
        
        // 设置头部刷新控件
        contentTableView.mj_header = MJRefreshNormalHeader()
        // 设置尾部刷新控件
        contentTableView.mj_footer = MJRefreshBackNormalFooter()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}


