//
//  RealTimeWeatherInfoView.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import MarqueeLabel

class RealTimeWeatherInfoView: UIView {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var real_title_label: UILabel!
    @IBOutlet weak var real_weather_detail_label: UILabel!
    @IBOutlet weak var real_temparature_label: UILabel!
    @IBOutlet weak var real_temp_unit_label: UILabel!
    
    lazy var lblTitle: MarqueeLabel? = {
        let marqueeLabel: MarqueeLabel = MarqueeLabel.init()
       marqueeLabel.type = .continuous
       marqueeLabel.speed = .duration(10)
       marqueeLabel.fadeLength = 10.0
       marqueeLabel.trailingBuffer = 30.0
       marqueeLabel.text = "天气舒适，适合外出"
       marqueeLabel.textColor = UIColor.white
       marqueeLabel.font = UIFont.systemFont(ofSize: 14)
       marqueeLabel.isUserInteractionEnabled = false
       return marqueeLabel
    }()
    
    @IBOutlet weak var real_feel_sunset_label: UILabel!
    
   // MARK:- 创建视图
    class func instance() -> RealTimeWeatherInfoView? {
        let nibView = Bundle.main.loadNibNamed("RealTimeWeatherInfoView", owner: nil, options: nil);
        if let view = nibView?.first as? RealTimeWeatherInfoView {
            view.backgroundColor = UIColor.clear
            
            return view
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addSubview(self.lblTitle!)
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
        /// weatherImage
        self.weatherImage.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-5)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        /// real_title_label
        var real_title_size: CGSize = "今天 ".sizeWithConstrainedWidth(UIScreen.main.bounds.width/2.0, font: UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold))
        real_title_size.height += 2
        self.real_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.centerX)
            make.top.equalTo(self.weatherImage.snp.top)
            make.size.equalTo(real_title_size)
        }
        
        /// real_weather_detail_label
        self.real_weather_detail_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.weatherImage.snp.bottom).offset(-3)
        }
        
        /// real_temparature_label
        var real_temparature_size: CGSize = "88 ".sizeWithConstrainedWidth(UIScreen.main.bounds.width/2.0, font: UIFont.systemFont(ofSize: 100, weight: UIFont.Weight.regular))
        real_temparature_size.height += 2
        self.real_temparature_label.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(real_temparature_size.width/2.0)
            make.top.equalTo(self.weatherImage.snp.bottom).offset(15)
            make.size.equalTo(real_temparature_size)
        }
        
        self.real_temp_unit_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.real_temparature_label.snp.right)
            make.top.equalTo(self.real_temparature_label.snp.top).offset(5)
        }
        
        self.lblTitle!.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.real_temparature_label.snp.bottom).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        /// real_feel_sunset_label
        self.real_feel_sunset_label!.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.lblTitle!.snp.bottom).offset(15)
            make.height.equalTo(20)
        }
            
        }
        
        /** 根据参数返回当前item的高度 */
        static var layoutHeight: CGFloat {
            /// real_temparature_label
            var real_temparature_size: CGSize = "88 ".sizeWithConstrainedWidth(UIScreen.main.bounds.width/2.0, font: UIFont.systemFont(ofSize: 100, weight: UIFont.Weight.regular))
            real_temparature_size.height += 2
            
            return 20 + 60 + 20 + real_temparature_size.height + 15 + 10 + 20 + 15 + 20
        }
    
    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }

}
