//
//  TomorrowWeatherToolBar.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class TomorrowWeatherToolBar: UIView {

    @IBOutlet weak var ttb_title_label: UILabel!
    // MARK:- 创建视图
    class func instance() -> TomorrowWeatherToolBar? {
         let nibView = Bundle.main.loadNibNamed("TomorrowWeatherToolBar", owner: nil, options: nil);
         if let view = nibView?.first as? TomorrowWeatherToolBar {
             view.backgroundColor = UIColor.clear
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

        /// ttb_title_label
        self.ttb_title_label.snp.remakeConstraints { (make) in
             make.left.equalTo(self.snp.left).offset(30)
             make.centerY.equalTo(self.snp.centerY)
             make.height.equalTo(20)
        }
    }

    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }

    /** 根据参数返回当前item的高度 */
    static var layoutHeight: CGFloat {
        return 44
    }

}
