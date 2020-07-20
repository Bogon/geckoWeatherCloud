//
//  TomorrowWeatherInfoView.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class TomorrowWeatherInfoView: UIView {

    fileprivate let itemMarginX: CGFloat = 5
    fileprivate let itemWidth: CGFloat = TomorrowItemInfoView.layoutWith
    
    lazy var tomorrowScrollView: UIScrollView = {
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
            let contentSizeWidth: CGFloat = (itemWidth + itemMarginX) * CGFloat(count) + 15
            tomorrowScrollView.contentSize = CGSize(width: contentSizeWidth > Self.layoutWith ? contentSizeWidth : Self.layoutWith, height: Self.layoutHeight)
        }
    }
    
    // MARK:- 创建视图
    class func instance() -> TomorrowWeatherInfoView? {
      let nibView = Bundle.main.loadNibNamed("TomorrowWeatherInfoView", owner: nil, options: nil);
      if let view = nibView?.first as? TomorrowWeatherInfoView {
          view.backgroundColor = UIColor.clear
          return view
      }
      return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /// 添加子视图
        addSubview(tomorrowScrollView)
    }
    
    //MARK: - 添加元素
    func addTomorrowItemList(_ values: [HourWeatherTimeModel]?) {
        
        clear()
        guard let list = values else {
            return
        }
        
        count = values!.count
        
        for (idx, item) in list.enumerated() {
            let tomorrowItemV: TomorrowItemInfoView = TomorrowItemInfoView.instance()!
            tomorrowItemV.tag = 110 + idx
            /// 布局
            let topMargin: CGFloat = Self.layoutHeight/2.0 - HourItemInfoView.layoutHeight / 2.0
            tomorrowItemV.frame = CGRect(x: 15 + CGFloat(idx) * (itemMarginX + itemWidth), y: item.isCurrent! ? topMargin - 30 : topMargin, width: TomorrowItemInfoView.layoutWith, height: TomorrowItemInfoView.layoutHeight)
            tomorrowScrollView.addSubview(tomorrowItemV)
            
            tomorrowItemV.tiv_time_label.text = item.dateStr ?? "8 AM"
            /// 计算Value
            let _value: CGFloat = (TomorrowItemInfoView.valueHeight) / (item.currentMax! - item.currentMin!) * (item.currentValue! - item.currentMin!)
            tomorrowItemV.value = _value
        }
    }
    
    //MARK: - 清除元素
    func clear() {
        count = 0
        let subviewList: [UIView] = tomorrowScrollView.subviews
        for (_, subview) in subviewList.enumerated() {
            if subview.tag >= 110 {
                subview.removeFromSuperview()
            }
        }
    }
    
    //MARK: - 页面元素布局
    override func layoutSubviews() {
        super.layoutSubviews()
        tomorrowScrollView.frame = CGRect(x: 0, y: 0, width: Self.layoutWith, height: Self.layoutHeight)
    }
    
    //MARK: - 小时天气默认属性
    static var layoutWith: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var layoutHeight: CGFloat {
        return 140
    }
}
