//
//  SettingController+Layout.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import Reusable

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

extension SettingController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        navigationBarSetting()
        initSubView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func initSubView() {
        settingTableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: UIScreen.main.bounds.height)
        settingTableView.delegate = self
        settingHeaderView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: SettingHeaderView.layoutHeight)
        settingHeaderView.delegate = self
        settingTableView.tableHeaderView = settingHeaderView
        settingTableView.tableFooterView = UIView()
        view.addSubview(settingTableView)
        settingTableView.register(cellType: SettingTableViewCell.self)
        
    }
    
    func navigationBarSetting() {
        navigationController?.navigationBar.barTintColor = UIColor.white    /// 设置导航栏
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false           /// 去除磨砂效果
        navigationController?.navigationBar.tintColor = .black              /// 修改返回按钮的颜色
        
    }
    
    func settingRightBarItem() {
        let logoutButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        logoutButton.contentHorizontalAlignment = .right
        logoutButton.setImage(Asset.logout.image, for: .normal)
        logoutButton.setImage(Asset.collectSelected.image, for: .selected)
        logoutButton.addTarget(self, action: #selector(logoutAction(sender:)), for: .touchUpInside)
        let logoutItem:UIBarButtonItem = UIBarButtonItem(customView: logoutButton)
        navigationItem.rightBarButtonItem = logoutItem
    }
    
    func deSettingRightBarItem() {
        navigationItem.rightBarButtonItem = nil
    }
}
