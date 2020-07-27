//
//  ProcotolController.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class ProcotolController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    var webView: WebView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "《用户协议与隐私政策》"
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 导航栏跟随滑动视图滚动
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(webView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(webView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
    }

}
