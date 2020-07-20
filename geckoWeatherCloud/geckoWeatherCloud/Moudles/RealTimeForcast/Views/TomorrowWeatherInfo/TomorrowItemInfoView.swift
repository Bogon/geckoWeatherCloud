//
//  TomorrowItemInfoView.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class TomorrowItemInfoView: UIView {

    @IBOutlet weak var tiv_time_label: UILabel!
    @IBOutlet weak var tiv_base_view: UIView!
    @IBOutlet weak var tiv_value_view: UIView!
    
    var value: CGFloat = 5.0 {
        
        didSet {
            layoutIfNeeded()
        }
    }
    
    // MARK:- 创建视图
    class func instance() -> TomorrowItemInfoView? {
      let nibView = Bundle.main.loadNibNamed("TomorrowItemInfoView", owner: nil, options: nil);
      if let view = nibView?.first as? TomorrowItemInfoView {
          view.backgroundColor = UIColor.clear
          return view
      }
      return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tiv_value_view.layer.masksToBounds = true
        tiv_value_view.layer.cornerRadius = 5
    }
    
    //MARK: - 页面元素布局
    override func layoutSubviews() {
       super.layoutSubviews()
       
       /// tiv_time_label
       self.tiv_time_label.snp.remakeConstraints { (make) in
           make.centerX.equalTo(self.snp.centerX)
           make.bottom.equalTo(self.snp.bottom).offset(-15)
           make.height.equalTo(15)
       }
       
        /// tiv_base_view
        self.tiv_base_view.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.tiv_time_label.snp.top).offset(-5)
            make.top.equalTo(self.snp.top)
            make.width.equalTo(1)
        }
        
        /// tiv_value_view
        self.tiv_value_view.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.tiv_base_view.snp.bottom)
            make.height.equalTo(value + 15)
            make.width.equalTo(10)
        }
    }

    //MARK: - 小时天气默认属性
    static var layoutWith: CGFloat {
       return 44
    }

    static var layoutHeight: CGFloat {
       return 120
    }
    
    static var valueHeight: CGFloat {
       return 120 - 30 - 5 - 15
    }

    
}
