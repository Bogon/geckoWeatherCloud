//
//  LoginController+Layout.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import Reusable

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

extension LoginController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        navigationBarSetting()
        leftBarItemSeeting()
        initSubView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginContentView.snp.remakeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.size.equalTo(CGSize(width: ScreenWidth, height: LoginContentView.layoutHeight))
        }
    }
    
    private func initSubView() {
        loginContentView.delegate = self
        view.addSubview(loginContentView)
        
    }
    
    func navigationBarSetting() {
        navigationController?.navigationBar.barTintColor = UIColor.white    /// 设置导航栏
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false           /// 去除磨砂效果
        navigationController?.navigationBar.tintColor = .black              /// 修改返回按钮的颜色
        
    }
    
    private func leftBarItemSeeting() {
        let closeItem:UIBarButtonItem = UIBarButtonItem.init(image: Asset.back.image, style: .plain, target: self, action:
            #selector(dismissController))
        closeItem.tintColor = UIColor(hex: "#333333")
        navigationItem.leftBarButtonItem = closeItem
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
}
