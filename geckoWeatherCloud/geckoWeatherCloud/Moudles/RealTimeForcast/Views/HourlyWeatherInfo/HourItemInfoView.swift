//
//  HourItemInfoView.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class HourItemInfoView: UIView {

    @IBOutlet weak var hi_time_label: UILabel!
    @IBOutlet weak var hi_imageView: UIImageView!
    @IBOutlet weak var hi_temparature_label: UILabel!

    //MARK: - 为当前时刻，设置页面样式
    var isCurrentHour: Bool = false {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = 30
            if isCurrentHour {
                backgroundColor = UIColor.white.alpha(0.8)
                hi_temparature_label.textColor = UIColor.init(hex: "#333333")
                hi_time_label.textColor = UIColor.init(hex: "#333333")
                layer.borderColor = UIColor.white.cgColor
                layer.borderWidth = 1.0
            } else {
                backgroundColor = UIColor.white.alpha(0.1)
                hi_temparature_label.textColor = UIColor.init(hex: "#FFFFFF")
                hi_time_label.textColor = UIColor.init(hex: "#FFFFFF")
                layer.borderColor = UIColor.white.alpha(0.3).cgColor
                layer.borderWidth = 1.0
            }
        }
    }
    
    // MARK:- 创建视图
    class func instance() -> HourItemInfoView? {
      let nibView = Bundle.main.loadNibNamed("HourItemInfoView", owner: nil, options: nil);
      if let view = nibView?.first as? HourItemInfoView {
          return view
      }
      return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - 页面元素布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// hi_time_label
        self.hi_time_label.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(15)
            make.height.equalTo(15)
        }
        
        /// hi_imageView
        self.hi_imageView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        /// hi_temparature_label
        self.hi_temparature_label.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-15)
            make.height.equalTo(15)
        }
        
    }
    
    //MARK: - 小时天气默认属性
    static var layoutWith: CGFloat {
        return 60
    }
    
    static var layoutHeight: CGFloat {
        return 120
    }

}
