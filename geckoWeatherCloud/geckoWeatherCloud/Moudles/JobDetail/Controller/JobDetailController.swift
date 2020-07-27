//
//  JobDetailController.swift
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

class JobDetailController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    let bag = DisposeBag()
    
    private var viewModel: JobInfoViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK:-  兼职详情表单
    lazy var contentTableView: UITableView = {
        var contentTableView: UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        return contentTableView
    }()
    
    private var jobItemInfoModel: HotJobItemInfoModel?
    
    
    final var jion2JobDetailView: Jion2JobDetailView = Jion2JobDetailView.instance()!
    
    init(jobInfo value: HotJobItemInfoModel) {
        super.init(nibName: nil, bundle: nil)
        jobItemInfoModel = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "详情"
        
        viewModel = JobInfoViewModel(
            headerRefresh: (contentTableView.mj_header?.rx.refreshing.asDriver())!,
            dependency: (disposeBag: bag, networkService: JobNetworkService.init(url: (jobItemInfoModel?.jump_url!)!)))
        
        jion2JobDetailView.tab_startAnimation()
        /// 开始动画
        contentTableView.tab_startAnimation { [weak self] in
            self?.jion2JobDetailView.tab_endAnimationEaseOut()
            self?.contentTableView.dataSource = nil
            /// 设置 DataSource
            let dataSource = RxTableViewSectionedReloadDataSource<HotJobDetailListSection>(configureCell: { ds, tv, ip, element in
                let cell: JobDetailTableViewCell = tv.dequeueReusableCell(for: ip)
                cell.selectionStyle = .none
                // JOb 头部信息
                cell.head_title = element.titleAreaInfoModel?.title ?? ""
                let xinzi_type: [String] = element.titleAreaInfoModel?.unit?.components(separatedBy: CharacterSet.init(charactersIn: "，")) ?? ["元/天", "日结"]
                cell.head_xinzi = "\(element.titleAreaInfoModel?.price ?? "400")\(xinzi_type.first!)"
                cell.head_salory_type = xinzi_type.last!
                cell.head_update = element.titleAreaInfoModel?.date ?? "更新：今天"
                cell.head_want = element.titleAreaInfoModel?.delivery ?? "申请：477人"
                cell.head_look = element.titleAreaInfoModel?.browered ?? "浏览：6473人"
                cell.head_work_time_title = element.titleAreaInfoModel?.work_time?.0 ?? "工作时间"
                cell.head_work_time_value = element.titleAreaInfoModel?.work_time?.1 ?? "星期一、星期二、星期三、星期四、星期五、星期六、星期日"
                cell.head_deadline_title = element.titleAreaInfoModel?.work_allowed?.0 ?? "有效期限"
                cell.head_deadline_value = element.titleAreaInfoModel?.work_allowed?.1 ?? "长期招聘"
                cell.head_work_place_title = element.titleAreaInfoModel?.work_address?.0 ?? "工作地点"
                cell.head_work_place_value = element.titleAreaInfoModel?.work_address?.1 ?? "各大区就近分配"
                
                // JOb 职位描述
                cell.job_desc_title = element.jobAreaDescInfoModel?.desc_job?.0 ?? "职位描述"
                cell.job_desc_value = element.jobAreaDescInfoModel?.desc_job?.1 ?? "工作要求：18-32周岁，普通话标准，工作负责认真，有责任心；<br>工作时间：课余时间，平时，周末，可以做长期；<br>工作时间：4-6小时，周一至周日均可，支持长期工作。"
                
                // JOb 公司信息
                cell.compony_title = element.jobComponyDescInfoModel?.title ?? "公司信息"
                cell.compony_name = element.jobComponyDescInfoModel?.componyInfoModel?.name ?? "桐乡市欣月鞋材有限公司"
                cell.compony_guimo = "规模：\(element.jobComponyDescInfoModel?.componyInfoModel?.size ?? "-")"
                cell.compony_address = "\(element.jobComponyDescInfoModel?.componyAddressInfoModel?.title ?? "公司地址：")：\(element.jobComponyDescInfoModel?.componyAddressInfoModel?.content == "" ? "-" : element.jobComponyDescInfoModel?.componyAddressInfoModel?.content ?? "-")"
                cell.compony_jingyingfanwei = element.jobComponyDescInfoModel?.componyAddressInfoModel?.companyDesc ?? ""
                
                return cell
            })
            
            _ = self?.viewModel!.tableData.asObservable().bind(to: (self?.contentTableView.rx.items(dataSource: dataSource))!)
        }
        
        // 下拉刷新状态结束的绑定
        viewModel?.endHeaderRefreshing
            .drive(contentTableView.mj_header!.rx.endRefreshing)
            .disposed(by: bag)
        
        contentTableView.rx.itemSelected.bind { [weak self] indexPath in
           self?.contentTableView.deselectRow(at: indexPath, animated: true)
       }.disposed(by: bag)
        
        contentTableView.rx.willDisplayCell.bind { [weak self] indexPath in
            DispatchQueue.main.async {
                self?.jion2JobDetailView.isHidden = false
            }
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
    
    /// 收藏
    @objc func collectAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        /// 3.保存收藏数据
        JobInfoHandle.share.insert(jobInfo: jobItemInfoModel, store_job_type: .just_like)
        _ = sender.isSelected ? MBProgressHUD.showMessage("收藏成功", to: view) : MBProgressHUD.showMessage("已取消收藏", to: view)
        
    }
    
    deinit {
        print("JobDetailController 释放了")
    }

}

extension JobDetailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let jobDetailListSection: HotJobDetailListSection = viewModel!.tableData.value[indexPath.section]
        let jobDetailModel: JobDetailResponseModel = jobDetailListSection.items[indexPath.row] as JobDetailResponseModel
        return JobDetailTableViewCell.layoutHeight(infoModel: jobDetailModel)
    }
}

extension JobDetailController: Jion2JobDetailDelegate {
    // 处理报名逻辑
    func jion2Job() {
        let userInfo: (Bool, UserInfoModel?) = UserInfoHandle.share.selectLoginingUserInfo()
        if userInfo.0 {
            /// 2.保存报名数据
            JobInfoHandle.share.insert(jobInfo: jobItemInfoModel, store_job_type: .just_join)
            MBProgressHUD.showMessage("报名成功，请耐心等待雇主与你联系", to: view)
        } else {
            /// 用户未登录
            let alertController = UIAlertController( title: "请登录", message: "您尚未登录，暂不能执行该操作", preferredStyle: .actionSheet)
            let cancle_action = UIAlertAction( title: "取消", style: .cancel, handler: { (action: UIAlertAction!) -> Void in
                
            })
            alertController.addAction(cancle_action)
            
            let login_action = UIAlertAction( title: "登录", style: .default, handler: { [weak self] (action: UIAlertAction!) -> Void in
                /// 登录注册事件
                let loginController = ScrollingNavigationController(rootViewController: LoginController())
                loginController.modalPresentationStyle = .fullScreen
                self?.present( loginController, animated: true)
            })
            alertController.addAction(login_action)
            
            self.present( alertController, animated: true, completion: nil)
        }
    }
}
