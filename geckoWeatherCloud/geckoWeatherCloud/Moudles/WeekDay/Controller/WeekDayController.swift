//
//  WeekDayController.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import MJRefresh
import RxCocoa
import RxSwift
import RxDataSources
import Reusable
import Connectivity

class WeekDayController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    let bag = DisposeBag()
    
    fileprivate let connectivity: Connectivity = Connectivity()
    private var viewModel: WeekDayJobInfoViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }// MARK:-  兼职表单
    lazy var contentTableView: UITableView = {
        var contentTableView: UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        return contentTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "周末兼职"
        
        configureConnectivityNotifier()
        connectivity.startNotifier()
        
        // 初始化ViewModel
        viewModel = WeekDayJobInfoViewModel(
            input: (
                headerRefresh: (contentTableView.mj_header?.rx.refreshing.asDriver())!,
                footerRefresh: (contentTableView.mj_footer?.rx.refreshing.asDriver())!),
            dependency: (
                disposeBag: bag,WeekDayJobNetworkService()))
        
        load()

        // 下拉刷新状态结束的绑定
        viewModel!.endHeaderRefreshing
            .drive(contentTableView.mj_header!.rx.endRefreshing)
            .disposed(by: bag)

        // 上拉刷新状态结束的绑定
        viewModel!.endFooterRefreshing
            .drive(contentTableView.mj_footer!.rx.endRefreshing)
            .disposed(by: bag)
        
        contentTableView.rx.itemSelected.bind { [weak self] indexPath in
            self?.contentTableView.deselectRow(at: indexPath, animated: true)
            let jobListSection: HotJobListSection = (self?.viewModel!.tableData.value[indexPath.section])!
            let jobInfoModel: HotJobItemInfoModel = jobListSection.items[indexPath.row] as HotJobItemInfoModel
            /// 1.保存浏览数据
            JobInfoHandle.share.insert(jobInfo: jobInfoModel, store_job_type: .just_look)
            let jobDetailController: JobDetailController = JobDetailController.init(jobInfo: jobInfoModel)
            jobDetailController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(jobDetailController, animated: true)
        }.disposed(by: bag)
        
    }
    

    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 导航栏跟随滑动视图滚动
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


extension WeekDayController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return JobTableViewCell.layoutHeight
    }
}

private extension WeekDayController {
    
    /// 1.保证网络正常的情况下加载骨架动画和请求数据
    func load() {
        /// 开始动画
        contentTableView.tab_startAnimation { [weak self] in
            self?.contentTableView.dataSource = nil
            /// 设置 DataSource
            let dataSource = RxTableViewSectionedReloadDataSource<HotJobListSection>(configureCell: { ds, tv, ip, item in
                let cell: JobTableViewCell = tv.dequeueReusableCell(for: ip)
                cell.selectionStyle = .none
                cell.job_title = "\(item.catename ?? "")•\(item.title ?? "")"
                cell.job_xinzi = item.xinzi ?? ""
                cell.job_address = item.quyu ?? ""
                cell.job_compony = item.qyname ?? ""
                cell.job_tags = item.job_tags ?? [String]()
                return cell
            })
            
            _ = self?.viewModel!.tableData.asObservable().bind(to: (self?.contentTableView.rx.items(dataSource: dataSource))!)
            
        }
    }
    
    func reload() {
        
        if viewModel!.tableData.value.count == 0 {
            contentTableView.mj_header?.beginRefreshing()
        }
    }
}

private extension WeekDayController {
    
    func configureConnectivityNotifier() {
        let connectivityChanged: (Connectivity) -> Void = { [weak self] connectivity in
            self?.updateConnectionStatus(connectivity.status)
        }
        connectivity.whenConnected = connectivityChanged
        connectivity.whenDisconnected = connectivityChanged
    }
    
    func startConnectivityChecks() {
        connectivity.startNotifier()
    }

    func stopConnectivityChecks() {
        connectivity.stopNotifier()
    }
    
    func updateConnectionStatus(_ status: Connectivity.Status) {
        
        switch status {
        case .connectedViaWiFi, .connectedViaCellular, .connected:
            reload()
            
        case .connectedViaWiFiWithoutInternet, .connectedViaCellularWithoutInternet, .notConnected:
            MBProgressHUD.showMessage("无网络，请检查网络设置", to: view)
            break
            
        case .determining:
            break
        }
    }
}
