//
//  DayDetailWeatherTableCell.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class DayDetailWeatherTableCell: UITableViewCell {

    fileprivate let sideValue: CGFloat = (UIScreen.main.bounds.width/2.0 - 35/2.0 - 3 - 35 - 15 - 3) / 2.0
    
    @IBOutlet weak var ddc_week_label: UILabel!
    @IBOutlet weak var ddc_aqi_imageview: UIImageView!
    @IBOutlet weak var ddc_aqi_title_label: UILabel!
    @IBOutlet weak var ddc_skycon_imageview: UIImageView!
    @IBOutlet weak var ddc_min_temp_label: UILabel!
    @IBOutlet weak var ddc_min_value_view: UIView!
    @IBOutlet weak var ddc_max_value_view: UIView!
    @IBOutlet weak var ddc_max_temp_label: UILabel!
    
    // MARK: - 添加属性监听器，修改控件上的值
    var week: String = "周一" {
        didSet {
            ddc_week_label.text = week
        }
    } /// 周几
    
    var skycon: String = "" {
        
        didSet {
            ddc_skycon_imageview.image = UIImage.init(named: "\(skycon)-C")
        }
    } /// 周几
    
    var max_current: CGFloat = 0.0 {
        
        didSet {
            ddc_max_temp_label.text = "\(Int(max_current))℃"
            
            if min_current > 25 {
                 ddc_min_value_view.layer.masksToBounds = true
                 ddc_min_value_view.layer.cornerRadius = 10
            } else {
                ddc_min_value_view.layer.masksToBounds = true
                ddc_min_value_view.corner(byRoundingCorners: [.topLeft, .bottomLeft], radii: 10)
            }
        }
    } /// 最高温度
    var min_current: CGFloat = 0.0 {
        didSet {
            ddc_min_temp_label.text = "\(Int(min_current))℃"
            if max_current < 25 {
                 ddc_min_value_view.layer.masksToBounds = true
                 ddc_min_value_view.layer.cornerRadius = 10
            } else {
                ddc_min_value_view.layer.masksToBounds = true
                ddc_min_value_view.corner(byRoundingCorners: [.topRight, .bottomRight], radii: 10)
            }
        }
    } /// 最低温度
    var AQI: String = "优" {
        didSet {
            ddc_aqi_title_label.text = AQI
        }
    }             /// 空气质量
    
    var min: CGFloat = 0
    var max: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// ddc_week_label
        ddc_week_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.snp.top).offset(15)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        /// ddc_aqi_imageview
        ddc_aqi_imageview.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(ddc_week_label.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        /// ddc_aqi_title_label
        ddc_aqi_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(ddc_aqi_imageview.snp.right).offset(3)
            make.centerY.equalTo(ddc_aqi_imageview.snp.centerY)
            make.height.equalTo(20)
        }
        
        /// ddc_min_temp_label
        ddc_min_temp_label.snp.remakeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: 35, height: 20))
        }
        
        /// ddc_skycon_imageview
        ddc_skycon_imageview.snp.remakeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX).offset(-UIScreen.main.bounds.width/4.0 + 55/2.0)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        /// ddc_max_temp_label
        ddc_max_temp_label.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: 35, height: 20))
        }

        
        /// 温度显示全部在左边
        if max_current <= 25 {
            /// ddc_max_value_view
            ddc_max_value_view.snp.makeConstraints { (make) in
                make.right.equalTo(ddc_max_temp_label.snp.left).offset(-3)
                make.centerY.equalTo(contentView.snp.centerY)
                make.size.equalTo(CGSize(width: 0, height: 20))
            }

            ddc_min_value_view.layer.masksToBounds = true
            ddc_min_value_view.layer.cornerRadius = 10
            
            let singalVlaue: CGFloat = abs(sideValue / (25 - min)) ///  单元值
            let tempValue: CGFloat = singalVlaue * (25 - min_current)
            
            /// ddc_min_value_view
            ddc_min_value_view.snp.makeConstraints { (make) in
                make.left.equalTo(ddc_min_temp_label.snp.right).offset(3)
                make.centerY.equalTo(contentView.snp.centerY)
                make.size.equalTo(CGSize(width: tempValue, height: 20))
            }
            
        } else {
            /// 温度显示全部在右方
            if min_current >= 25 {
                /// ddc_min_value_view
                ddc_min_value_view.snp.makeConstraints { (make) in
                    make.left.equalTo(ddc_min_temp_label.snp.right).offset(3)
                    make.centerY.equalTo(contentView.snp.centerY)
                    make.size.equalTo(CGSize(width: 0, height: 20))
                }
                
                ddc_max_value_view.layer.masksToBounds = true
                ddc_max_value_view.layer.cornerRadius = 10
                
                let singalVlaue: CGFloat = abs(sideValue / (max - 25)) ///  单元值
                let tempValue: CGFloat = singalVlaue * (max_current - min_current)
                let tempOffset: CGFloat = singalVlaue * (min_current - 25)
                
                /// ddc_max_value_view
                ddc_max_value_view.snp.makeConstraints { (make) in
                    make.left.equalTo(ddc_min_temp_label.snp.right).offset(3 + sideValue + tempOffset)
                    make.centerY.equalTo(contentView.snp.centerY)
                    make.size.equalTo(CGSize(width: tempValue, height: 20))
                }

            } else {  /// 两边都有
                ddc_min_value_view.layer.masksToBounds = true
                ddc_min_value_view.corner(byRoundingCorners: [.topLeft, .bottomLeft], radii: 10)
                
                ddc_max_value_view.layer.masksToBounds = true
                ddc_max_value_view.corner(byRoundingCorners: [.topRight, .bottomRight], radii: 10)
                    
                let singalRightVlaue: CGFloat = abs(sideValue / (max - 25)) ///  单元值
                let rightValue: CGFloat = singalRightVlaue * (max_current - 25)
                /// ddc_max_value_view
                ddc_max_value_view.snp.makeConstraints { (make) in
                    make.left.equalTo(ddc_min_temp_label.snp.right).offset(3 + sideValue)
                    make.centerY.equalTo(contentView.snp.centerY)
                    make.size.equalTo(CGSize(width: rightValue, height: 20))
                }
                
                let singalLeftVlaue: CGFloat = abs(sideValue / (25 - min)) ///  单元值
                let leftValue: CGFloat = singalLeftVlaue * (25 - min_current)
                
                /// ddc_min_value_view
                ddc_min_value_view.snp.makeConstraints { (make) in
                    make.right.equalTo(ddc_max_value_view.snp.left)
                    make.centerY.equalTo(contentView.snp.centerY)
                    make.size.equalTo(CGSize(width: leftValue, height: 20))
                }
            }
            
        }
        
    }
    
    //MARK: - Cell默认属性
    static var layoutHeight: CGFloat {
        return 15 + 20 + 5 + 20 + 15
    }
    
}
