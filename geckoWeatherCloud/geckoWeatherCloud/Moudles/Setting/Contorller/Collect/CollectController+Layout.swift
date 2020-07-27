//
//  CollectController+Layout.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import Hue

fileprivate let ContentScrollViewWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

extension CollectController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        
        leftBarItemSeeting()
        initSubView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func initSubView() {
        contentTableView.frame = CGRect(x: 0, y: 0, width: ContentScrollViewWidth, height: UIScreen.main.bounds.height - BottomMarginY.margin)
        contentTableView.delegate = self
        contentTableView.tableHeaderView = UIView()
        contentTableView.tableFooterView = UIView()
        view.addSubview(contentTableView)
        
        contentTableView.tabAnimated = TABTableAnimated.init(cellClass: JobTableViewCell.self, cellHeight: JobTableViewCell.layoutHeight)
        contentTableView.tabAnimated?.animatedSectionCount = 1
        contentTableView.tabAnimated?.showTableHeaderView = false
        contentTableView.tabAnimated?.superAnimationType = .shimmer
        contentTableView.tabAnimated?.canLoadAgain = true
        contentTableView.register(cellType: JobTableViewCell.self)
        
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
    
}
