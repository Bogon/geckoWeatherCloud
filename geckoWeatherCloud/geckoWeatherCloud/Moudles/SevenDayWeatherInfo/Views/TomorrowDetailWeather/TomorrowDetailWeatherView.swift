//
//  TomorrowDetailWeatherView.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class TomorrowDetailWeatherView: UIView {

    @IBOutlet weak var tdv_weak_label: UILabel!
    @IBOutlet weak var tdv_skycon_imageview: UIImageView!
    @IBOutlet weak var tdv_max_temparature_label: UILabel!
    @IBOutlet weak var tdv_min_tempture_label: UILabel!
    
    @IBOutlet weak var tdv_speed_title: UILabel!
    @IBOutlet weak var tdv_speed_value_label: UILabel!
    
    @IBOutlet weak var tdv_sd_title: UILabel!
    @IBOutlet weak var tdv_sd_value_label: UILabel!
    
    @IBOutlet weak var tdv_njd_title: UILabel!
    @IBOutlet weak var tdv_njd_value_label: UILabel!
    
    @IBOutlet weak var tdv_kqzl_title: UILabel!
    @IBOutlet weak var tdv_kqzl_value_label: UILabel!
    
    // MARK: - 添加属性监听器，修改控件上的值
    var week: String = "周一" {

        didSet {
            tdv_weak_label.text = week
        }
    } /// 周几
    
    var skycon: String = "" {
        
        didSet {
            tdv_skycon_imageview.image = UIImage.init(named: "\(skycon)-C")
        }
    } /// 周几
    
    var maxTemparaature: CGFloat = 0.0 {
        
        didSet {
            tdv_max_temparature_label.text = "\(Int(maxTemparaature))℃"
        }
    } /// 最高温度
    var minTemparaature: CGFloat = 0.0 {
        
        didSet {
            tdv_min_tempture_label.text = "\(Int(minTemparaature))℃"
        }
    } /// 最低温度
    
    var windSpeed: String = "" {
        
        didSet {
            tdv_speed_value_label.text = "\(windSpeed) km/h"
        }
    }         /// 风速
    var humidity: String = "" {

        didSet {
            tdv_sd_value_label.text = humidity
        }
    }          /// 湿度
    var visibility: String = "" {
        
        didSet {
            tdv_njd_value_label.text = visibility
        }
    }      /// 紫外线强度度
    var AQI: String = "优" {

        didSet {
            tdv_kqzl_value_label.text = AQI
        }
    }             /// 空气质量
    
    // MARK: - 创建视图
    class func instance() -> TomorrowDetailWeatherView? {
      let nibView = Bundle.main.loadNibNamed("TomorrowDetailWeatherView", owner: nil, options: nil);
      if let view = nibView?.first as? TomorrowDetailWeatherView {
          
          return view
      }
      return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.white
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1.5)
    }
    
    //MARK: - 页面元素布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let subLabelWith: CGFloat = (UIScreen.main.bounds.width - 30 - 30)/4.0
        
        /// tdv_weak_label
        self.tdv_weak_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 50, height: 22))
        }
        
        /// tdv_skycon_imageview
        self.tdv_skycon_imageview.snp.remakeConstraints { (make) in
            make.left.equalTo(tdv_weak_label.snp.right)
            make.centerY.equalTo(tdv_weak_label.snp.centerY)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        /// 最低温度计算
        var minTempLSize: CGSize = "\(Int(minTemparaature))℃  ".sizeWithConstrainedWidth(80, font: UIFont.systemFont(ofSize: 14))
        minTempLSize.width += 2
        /// tdv_min_tempture_label
        self.tdv_min_tempture_label.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.centerY.equalTo(tdv_weak_label.snp.centerY)
            make.size.equalTo(CGSize(width: minTempLSize.width, height: 21))
        }
        /// 最高温度计算
        var maxTempLSize: CGSize = "\(Int(maxTemparaature))℃  ".sizeWithConstrainedWidth(80, font: UIFont.systemFont(ofSize: 18))
        maxTempLSize.width += 2
        /// tdv_max_temparature_label
        self.tdv_max_temparature_label.snp.remakeConstraints { (make) in
            make.right.equalTo(tdv_min_tempture_label.snp.left).offset(-3)
            make.centerY.equalTo(tdv_weak_label.snp.centerY)
            make.size.equalTo(CGSize(width: maxTempLSize.width, height: 21))
        }
        
        
        /// tdv_speed_title
        self.tdv_speed_title.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(tdv_weak_label.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: subLabelWith, height: 21))
        }
        /// tdv_speed_value_label
        self.tdv_speed_value_label.snp.remakeConstraints { (make) in
            make.left.equalTo(tdv_speed_title.snp.right)
            make.centerY.equalTo(tdv_speed_title.snp.centerY)
            make.size.equalTo(CGSize(width: subLabelWith, height: 21))
        }
        
        /// tdv_sd_title
        self.tdv_sd_title.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(30)
            make.top.equalTo(tdv_weak_label.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: subLabelWith, height: 21))
        }
        /// tdv_sd_value_label
        self.tdv_sd_value_label.snp.remakeConstraints { (make) in
            make.left.equalTo(tdv_sd_title.snp.right)
            make.centerY.equalTo(tdv_sd_title.snp.centerY)
            make.size.equalTo(CGSize(width: subLabelWith - 30, height: 21))
        }
        
        /// tdv_njd_title
        self.tdv_njd_title.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(tdv_speed_title.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: subLabelWith, height: 21))
        }
        /// tdv_njd_value_label
        self.tdv_njd_value_label.snp.remakeConstraints { (make) in
            make.left.equalTo(tdv_njd_title.snp.right)
            make.centerY.equalTo(tdv_njd_title.snp.centerY)
            make.size.equalTo(CGSize(width: subLabelWith, height: 21))
        }
        
        /// tdv_kqzl_title
        self.tdv_kqzl_title.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(30)
            make.top.equalTo(tdv_speed_title.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: subLabelWith, height: 21))
        }
        /// tdv_kqzl_value_label
        self.tdv_kqzl_value_label.snp.remakeConstraints { (make) in
            make.left.equalTo(tdv_kqzl_title.snp.right)
            make.centerY.equalTo(tdv_kqzl_title.snp.centerY)
            make.size.equalTo(CGSize(width: subLabelWith - 30, height: 21))
        }
    }
    
    //MARK: - 天气默认属性
    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width - 30
    }
    
    /** 根据参数返回当前item的高度 */
    static var layoutHeight: CGFloat {
        return 20 + 22 + 30 + 21 + 15 + 21 + 20
    }
    
}
