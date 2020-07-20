//
//  RealTimeForcastController.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import RxSwift
import RxCocoa
import MJRefresh

class RealTimeForcastController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {
    
    let bag = DisposeBag()
    
    private var viewModel: WeatherInfoViewModel = WeatherInfoViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    lazy var contentScrollView: UIScrollView = {
        let contentScrollView:UIScrollView = UIScrollView.init()
        contentScrollView.contentSize = UIScreen.main.bounds.size
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.keyboardDismissMode = .interactive
        contentScrollView.backgroundColor = .clear
        return contentScrollView
    }()
    
    var currentCityModel: CityModel {
        return CityManager.share.locationCity()
    }
    
    var paramaters: [String: Any] {
        return currentCityModel.areaCodeValue
    }
    /// 添加背景图
    var backgroudV: WeatherBackgroudEffictive = WeatherBackgroudEffictive.instance()!
    
    /// 当前天气信息视图
    var realTimeWeaInfoV: RealTimeWeatherInfoView = RealTimeWeatherInfoView.instance()!
    /// 未来七天信息工具栏
    var hourlyToolBar: HourlyWeatherToolBar = HourlyWeatherToolBar.instance()!
    /// 小时级别天气预报
    var hourlyWeatherInfoV: HourlyWeatherInfoView = HourlyWeatherInfoView.instance()!
    /// 明日小时级别天气工具栏
    var tomorrowToolBar: TomorrowWeatherToolBar = TomorrowWeatherToolBar.instance()!
    /// 明日小时级别天气信息
    var tomorrowWeatherInfoV: TomorrowWeatherInfoView = TomorrowWeatherInfoView.instance()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateTitle()
       
        /// 收到点击左侧城市
        NotificationCenter.default.rx
            .notification(NSNotification.Name.updateLocaitonCity)
            .takeUntil(self.rx.deallocated) /// 页面销毁自动移除通知监听
            .subscribe(onNext: { [weak self] notification in
                self?.updateTitle()
                
            }).disposed(by: bag)
        
        /// 下拉刷新天气数据
        let headerNormalRefresh: MJRefreshNormalHeader = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            
            self?.updateTitle()
        })
        headerNormalRefresh.stateLabel?.textColor = UIColor.white
        headerNormalRefresh.lastUpdatedTimeLabel?.textColor = UIColor.white
        headerNormalRefresh.loadingView?.style = .white
        contentScrollView.mj_header = headerNormalRefresh
        
        hourlyToolBar.htb_next_button.rx.tap.subscribe(onNext: { [weak self] in
            self?.bindingSenvenDayTo((self?.viewModel.response)!)
        }).disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetting()
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(contentScrollView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(contentScrollView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
    }
    
    /// 未来七天页面逻辑绑定
    private func bindingSenvenDayTo(_ value: CityWeatherInfoResponseModel) {
        /// 跳转到未来七天的页面
        navigationController?.pushViewController(SevenDayWeatherInfoController(value: value), animated: true)
    }

    
    private func updateTitle() {
        navigationItem.title = "\(currentCityModel.district!)天气预报"
        /// 数据绑定
        viewModel.binding(controller: self, bindingType: .RealTime)
        //        viewModel.binding(controller: self, bindingType: .SenvenDay)
        viewModel.binding(controller: self, bindingType: .Hourly)
        viewModel.binding(controller: self, bindingType: .Tomorrow)
        
        contentScrollView.mj_header?.endRefreshing()
    }
    
}
