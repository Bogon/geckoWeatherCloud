//
//  SettingController.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import RxCocoa
import RxSwift
import RxDataSources
import Reusable

class SettingController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    let bag = DisposeBag()
    
    private var viewModel: SettingViewModel?
    
    let settingHeaderView: SettingHeaderView = SettingHeaderView.instance()!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK:-  设置表单
    lazy var settingTableView: UITableView = {
        var contentTableView: UITableView = UITableView()
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        return contentTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = ""
        
        viewModel = SettingViewModel(dependency: (disposeBag: bag, networkService: SettingNetworkService()))
        
        load()
        
        settingTableView.rx.itemSelected.bind { [weak self] indexPath in
            self?.settingTableView.deselectRow(at: indexPath, animated: true)
            let settingListSection: SettingListSection = (self?.viewModel!.tableData.value[indexPath.section])!
            let itemInfoModel: SettingItemInfoModel = settingListSection.items[indexPath.row] as SettingItemInfoModel
            self?.dealWithSettingType(settingType: itemInfoModel.type!)
        }.disposed(by: bag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHeaderCount()
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 导航栏跟随滑动视图滚动
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(settingTableView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(settingTableView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
    }
    
    /// 退出登录
    @objc func logoutAction(sender: UIButton) {
        let logout_reslult = UserInfoHandle.share.logout()
        
        if logout_reslult {
            MBProgressHUD.showSuccess("退出登录成功", to: view)
            loadHeaderCount()
            deSettingRightBarItem()
        }
    }
}

private extension SettingController {
    
    /// 处理设置点击事件信息
    func dealWithSettingType(settingType value: SettingType) {
        switch value {
        
            case .look:
                // 浏览
                let collectController: CollectController = CollectController(storeJobType: .just_look)
                collectController.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(collectController, animated: true)
            
            case .jion:
                // 应聘
                let collectController: CollectController = CollectController(storeJobType: .just_join)
                collectController.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(collectController, animated: true)
            
            case .colleciton:
                // 展示收藏职位
                let collectController: CollectController = CollectController(storeJobType: .just_like)
                collectController.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(collectController, animated: true)
            
            case .protocols:
                // 展示协议
                let procotolController: ProcotolController = ProcotolController()
                procotolController.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(procotolController, animated: true)
            
            case .version:
                MBProgressHUD.showMessage("当前已是最新版本", to: view)
                
            case .clear:
                ClearCache.share.clear()
                viewModel?.reload()
                MBProgressHUD.showMessage("缓存已清除", to: view)
        }
    }
    
    /// 1.保证网络正常的情况下加载骨架动画和请求数据
    func load() {
        /// 设置 DataSource
        let dataSource = RxTableViewSectionedReloadDataSource<SettingListSection>(configureCell: { ds, tv, ip, item in
            let cell: SettingTableViewCell = tv.dequeueReusableCell(for: ip)
            cell.selectionStyle = .none
            cell.type = item.type!
            return cell
        })
        
        _ = viewModel!.tableData.asObservable().bind(to: (settingTableView.rx.items(dataSource: dataSource)))
        
    }
    
    /// 2.设置头部浏览信息
    func loadHeaderCount() {
        
        /// 设置header数据
        let result:(Bool, UserInfoModel?) = UserInfoHandle.share.selectLoginingUserInfo()
        let is_login: Bool = result.0
        settingHeaderView.is_login = is_login
        
        if is_login {
            let userInfo: UserInfoModel = result.1!
            let nickname: String = userInfo.nickname ?? ""
            settingHeaderView.nickname = nickname
            
            /// 设置登出按钮
            settingRightBarItem()
        }
        
        let look_count: Int = JobInfoHandle.share.selecteJobList(storeJobType: .just_look).count
        let join_count: Int = JobInfoHandle.share.selecteJobList(storeJobType: .just_join).count
        let collection_count: Int = JobInfoHandle.share.selecteJobList(storeJobType: .just_like).count
        
        settingHeaderView.look_count = "\(look_count)"
        settingHeaderView.join_count = "\(join_count)"
        settingHeaderView.collection_count = "\(collection_count)"
    }
}

extension SettingController: SettingHeaderLoginDelegate {
    
    /// 登录注册事件
    func login_sign_up() {
        /// 登录注册事件
        let loginController = ScrollingNavigationController(rootViewController: LoginController())
        loginController.modalPresentationStyle = .fullScreen
        self.present( loginController, animated: true)
    }

}


extension SettingController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingTableViewCell.layoutHeight
    }

}
