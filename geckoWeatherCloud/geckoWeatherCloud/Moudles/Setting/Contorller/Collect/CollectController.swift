//
//  CollectController.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import RxCocoa
import RxSwift
import RxDataSources
import Reusable

class CollectController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    let bag = DisposeBag()
    
    private var viewModel: CollectViewModel?
    private var store_job_type: StoreJobType?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK:-  兼职表单
    lazy var contentTableView: UITableView = {
        var contentTableView: UITableView = UITableView()
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        return contentTableView
    }()
    
    init(storeJobType value: StoreJobType) {
        super.init(nibName: nil, bundle: nil)
        store_job_type = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var navi_title: String = ""
        switch store_job_type! {
      
            case .just_look:
                navi_title = "浏览记录"
            case .just_join:
                navi_title = "报名记录"
            case .just_like:
                navi_title = "收藏记录"
            case .none:
                navi_title = "记录"
        }
        
        navigationItem.title = navi_title
        
        viewModel = CollectViewModel(storeJobType: store_job_type!,
                                     dependency: (disposeBag: bag, networkService: CollectNetworkService()))
        
        load()
        
        contentTableView.rx.itemSelected.bind { [weak self] indexPath in
            self?.contentTableView.deselectRow(at: indexPath, animated: true)
            let jobListSection: HotJobListSection = (self?.viewModel!.tableData.value[indexPath.section])!
            let jobInfoModel: HotJobItemInfoModel = jobListSection.items[indexPath.row] as HotJobItemInfoModel
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

    deinit {
        print("CollectController 释放了")
    }
}

extension CollectController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return JobTableViewCell.layoutHeight
    }

}

private extension CollectController {
    
    /// 1.保证网络正常的情况下加载骨架动画和请求数据
    func load() {
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
        
        _ = viewModel!.tableData.asObservable().bind(to: contentTableView.rx.items(dataSource: dataSource))
    }
}
