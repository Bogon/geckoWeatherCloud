//
//  UpdateController+Layout.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/13.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

extension UpdateController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        initSubView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func initSubView() {
        webView = WebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - TopMarginX.topMargin))
        view.addSubview(webView)
        // 配置webView样式
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        config.progressTintColor = UIColor(hex: "#333333")
        // 加载普通URL
        webView.webConfig = config
        webView.webloadType(self, .URLString(url: update_url!))
        
    }
    
}
