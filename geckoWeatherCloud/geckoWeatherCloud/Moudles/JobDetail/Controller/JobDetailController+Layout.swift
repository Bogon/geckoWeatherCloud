//
//  JobDetailController+Layout.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import Hue
import MJRefresh

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

extension JobDetailController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(hex: "#F5F5F5")
        initSubView()
        
        leftBarItemSeeting()
        rightBarItemSeeting()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        jion2JobDetailView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.size.equalTo(CGSize(width: ScreenWidth, height: Jion2JobDetailView.layoutHeight))
        }
    }
    
    private func initSubView() {
        
        self.contentTableView.registerCellNib(JobDetailTableViewCell.self)
        contentTableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - Jion2JobDetailView.layoutHeight)
        contentTableView.delegate = self
        contentTableView.tableHeaderView = UIView()
        contentTableView.tableFooterView = UIView()
        view.addSubview(contentTableView)
        
        contentTableView.tabAnimated = TABTableAnimated.init(cellClass: JobDetailTableViewCell.self, cellHeight: 960)
        contentTableView.tabAnimated?.animatedSectionCount = 1
        contentTableView.tabAnimated?.showTableHeaderView = false
        contentTableView.tabAnimated?.superAnimationType = .shimmer
        contentTableView.tabAnimated?.canLoadAgain = true
        contentTableView.register(cellType: JobDetailTableViewCell.self)
        
        // 设置头部刷新控件
        contentTableView.mj_header = MJRefreshNormalHeader()
        jion2JobDetailView.delegate = self
        jion2JobDetailView.isHidden = true
        view.addSubview(jion2JobDetailView)
        
        jion2JobDetailView.tabAnimated = TABViewAnimated.init()
        jion2JobDetailView.tabAnimated?.superAnimationType = .shimmer
        jion2JobDetailView.tabAnimated?.canLoadAgain = true
    }
    
    private func leftBarItemSeeting() {
        let closeItem:UIBarButtonItem = UIBarButtonItem.init(image: Asset.back.image, style: .plain, target: self, action:
            #selector(pop))
        closeItem.tintColor = UIColor(hex: "#333333")
        navigationItem.leftBarButtonItem = closeItem
    }
    
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func rightBarItemSeeting() {
        let collectionButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        collectionButton.contentHorizontalAlignment = .right
        collectionButton.setImage(Asset.collect.image, for: .normal)
        collectionButton.setImage(Asset.collectSelected.image, for: .selected)
        collectionButton.addTarget(self, action: #selector(collectAction(sender:)), for: .touchUpInside)
        let collectItem:UIBarButtonItem = UIBarButtonItem(customView: collectionButton)
        navigationItem.rightBarButtonItem = collectItem
    }
}
