//
//  HourlyWeatherToolBar.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/25.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class HourlyWeatherToolBar: UIView {

    @IBOutlet weak var htb_title_label: UILabel!
    @IBOutlet weak var htb_next_button: UIButton!
    
    // MARK:- 创建视图
    class func instance() -> HourlyWeatherToolBar? {
      let nibView = Bundle.main.loadNibNamed("HourlyWeatherToolBar", owner: nil, options: nil);
      if let view = nibView?.first as? HourlyWeatherToolBar {
          view.backgroundColor = UIColor.clear
          return view
      }
      return nil
    }

    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
        htb_next_button.tintColor = UIColor.init(hex: "#488cdf")
    }

    //MARK: - 页面元素布局
    override func layoutSubviews() {
          super.layoutSubviews()
          
      /// htb_title_label
      self.htb_title_label.snp.remakeConstraints { (make) in
          make.left.equalTo(self.snp.left).offset(30)
          make.centerY.equalTo(self.snp.centerY)
          make.height.equalTo(20)
      }
        
        /// htb_next_button
        self.htb_next_button.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-25)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 85, height: 30))
        }
    }
    
    //MARK: - 小时天气默认属性
    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /** 根据参数返回当前item的高度 */
    static var layoutHeight: CGFloat {
        return 44
    }

}
