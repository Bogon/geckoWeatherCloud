//
//  HourlyWeatherInfoView.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class HourlyWeatherInfoView: UIView {

    fileprivate let itemMarginX: CGFloat = 15
    fileprivate let itemWidth: CGFloat = HourItemInfoView.layoutWith
    
    lazy var hourlyScrollView: UIScrollView = {
        let contentScrollView:UIScrollView = UIScrollView.init()
        contentScrollView.contentSize = CGSize(width: Self.layoutWith, height: Self.layoutHeight)
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.keyboardDismissMode = .interactive
        return contentScrollView
    }()
    
    //MARK: - 当前页面元素个数
    private var count: Int = 0 {
        
        willSet {
            
        }
        
        didSet {
            let contentSizeWidth: CGFloat = (itemWidth + itemMarginX) * CGFloat(count) + itemMarginX
            hourlyScrollView.contentSize = CGSize(width: contentSizeWidth > Self.layoutWith ? contentSizeWidth : Self.layoutWith, height: Self.layoutHeight)
        }
    }
    
    // MARK:- 创建视图
    class func instance() -> HourlyWeatherInfoView? {
      let nibView = Bundle.main.loadNibNamed("HourlyWeatherInfoView", owner: nil, options: nil);
      if let view = nibView?.first as? HourlyWeatherInfoView {
          view.backgroundColor = UIColor.clear
          return view
      }
      return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /// 添加子视图
        addSubview(hourlyScrollView)
    }
    
    //MARK: - 添加元素
    func addHourItemList(_ values: [HourWeatherTimeModel]?) {
        clear()
        guard let list = values else {
            return
        }
        
        count = values!.count
        
        for (idx, item) in list.enumerated() {
            let hourItemV: HourItemInfoView = HourItemInfoView.instance()!
            hourItemV.isCurrentHour = item.isCurrent!
            hourItemV.tag = 100 + idx
            hourItemV.hi_temparature_label.text = "\(Int(item.currentValue!))℃"
            hourItemV.hi_time_label.text = item.dateStr ?? "8 AM"
            hourItemV.hi_imageView.image = UIImage.init(named: "\(item.weatherStr!)-C")
            hourlyScrollView.addSubview(hourItemV)
            
            /// 布局
            let topMargin: CGFloat = Self.layoutHeight/2.0 - HourItemInfoView.layoutHeight / 2.0
            hourItemV.frame = CGRect(x: itemMarginX + itemMarginX + CGFloat(idx) * (itemMarginX + itemWidth), y: item.isCurrent! ? topMargin - 30 : topMargin, width: HourItemInfoView.layoutWith, height: HourItemInfoView.layoutHeight)
            
            hourItemV.layoutIfNeeded()
            
        }
    }
    
    
    //MARK: - 清除元素
    func clear() {
        count = 0
        let subviewList: [UIView] = hourlyScrollView.subviews
        
        for (_, subview) in subviewList.enumerated() {
            if subview.tag >= 100 {
                subview.removeFromSuperview()
            }
        }
        
    }
    
    //MARK: - 页面元素布局
    override func layoutSubviews() {
        super.layoutSubviews()
        hourlyScrollView.frame = CGRect(x: 0, y: 0, width: Self.layoutWith, height: Self.layoutHeight)
    }
    
    //MARK: - 小时天气默认属性
    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var layoutHeight: CGFloat {
        return 200
    }

}
