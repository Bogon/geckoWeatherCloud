//
//  SevenDayWeatherInfoController.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import RxCocoa
import RxSwift

class SevenDayWeatherInfoController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    private var response: CityWeatherInfoResponseModel?
    
    private var viewModel: SevenDayWeatherViewModel = SevenDayWeatherViewModel()
    
    var currentCityModel: CityModel {
        return CityManager.share.locationCity()
    }
    
    var paramaters: [String: Any] {
        return currentCityModel.areaCodeValue
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK:-  天气表单
    lazy var contentTableView: UITableView = {
        var contentTableView: UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        contentTableView.backgroundColor = .clear
        return contentTableView
    }()
    
    /// 头部视图
    var tomorrowListHeader: TomorrowDetailListHeader = TomorrowDetailListHeader.instance()!
    
    //MARK: - 初始化控制器
    /// 初始化器中初始化七天天气数据
    ///
    /// - Parameter sevenDayValues: 天气数据
    /// - Returns: 无返回值
    init(value sevenDayValues: CityWeatherInfoResponseModel?) {
        super.init(nibName: nil, bundle: nil)
        self.response = sevenDayValues
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.binding(controller: self, bindingType: .TomorrowHeader)
        viewModel.binding(controller: self, bindingType: .TomorrowList)

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
              navigationController.followScrollView(contentTableView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
              navigationController.followScrollView(contentTableView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
          }
    }

}

extension SevenDayWeatherInfoController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DayDetailWeatherTableCell.layoutHeight
    }
}
