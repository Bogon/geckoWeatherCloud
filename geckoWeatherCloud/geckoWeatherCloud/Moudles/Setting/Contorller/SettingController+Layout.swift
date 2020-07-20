//
//  SettingController+Layout.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import UIKit


fileprivate let SettingViewWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

extension SettingController {
     
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.init(hex: "#F2F2F2")
        initSubView()
        
    }
    
    private func initSubView() {
         self.settingTableView.registerCellNib(SettingTableViewCell.self)
        settingTableView.frame = CGRect(x: 0, y: 0, width: SettingViewWidth, height: UIScreen.main.bounds.height - TopMarginX.topMargin)
        view.addSubview(settingTableView)
        
        settingTableView.separatorStyle = .none
        settingHeadV.frame = CGRect(x: 0, y: 0, width: SettingHeadView.layoutWith, height: SettingHeadView.layoutHeight)
        settingTableView.tableHeaderView = settingHeadV
        settingTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetting()
    }
    
    private func navigationBarSetting() {
        navigationItem.title = "设置"
        
        navigationController?.navigationBar.barTintColor = UIColor.init(hex: "#F2F2F2") /// 设置导航栏
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false    /// 去除磨砂效果
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#000000"),NSAttributedString.Key.font : UIFont
                          .boldSystemFont(ofSize: 18)]
        navigationController?.navigationBar.tintColor = .black  /// 修改返回按钮的颜色
    }
    
}
