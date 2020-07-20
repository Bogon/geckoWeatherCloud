//
//  TomorrowDetailToolBar.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class TomorrowDetailToolBar: UIView {

    @IBOutlet weak var tdb_title_label: UILabel!
   
    // MARK: - 创建视图
    class func instance() -> TomorrowDetailToolBar? {
      let nibView = Bundle.main.loadNibNamed("TomorrowDetailToolBar", owner: nil, options: nil);
      if let view = nibView?.first as? TomorrowDetailToolBar {
        view.backgroundColor = .clear
          return view
      }
      return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// tdb_title_label
        self.tdb_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(60)
        }
    }
    
    //MARK: - 默认属性
    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /** 根据参数返回当前item的高度 */
    static var layoutHeight: CGFloat {
        return 60
    }
}
