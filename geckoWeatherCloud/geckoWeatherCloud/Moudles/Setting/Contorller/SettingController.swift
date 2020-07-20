//
//  SettingController.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class SettingController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK:- 表单
    lazy var settingTableView: UITableView = {
        var tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var viewModel: SettingViewModel = SettingViewModel()
    
    var settingHeadV: SettingHeadView = SettingHeadView.instance()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.binding(controller: self, bindingType: .Version)
    }
    

}

extension SettingController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingTableViewCell.layoutHeight
    }
}

