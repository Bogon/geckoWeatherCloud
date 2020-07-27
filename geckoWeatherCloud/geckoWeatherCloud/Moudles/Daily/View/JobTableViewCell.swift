//
//  JobTableViewCell.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

class JobTableViewCell: UITableViewCell, NibReusable {

    static var reuseIdentifier: String { return "JobTableViewCell" }
    
    fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
    fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height
    
    fileprivate let XMargin: CGFloat = 20
    fileprivate let YMargin: CGFloat = 20
    
    @IBOutlet weak var hj_title_label: UILabel!
    @IBOutlet weak var hj_address_label: UILabel!
    @IBOutlet weak var hj_xinzi_label: UILabel!
    @IBOutlet weak var hj_join_label: UILabel!
    @IBOutlet weak var hj_virify_label: UILabel!
    @IBOutlet weak var hj_compony_label: UILabel!
    @IBOutlet weak var line: UIView!
    
    var hj_job_tag_view: TagsContentView = TagsContentView.init(frame: CGRect.zero)
    
    /// job展示信息
    var job_title: String = "服务员*室内活动接待员" {
        didSet {
            hj_title_label.text = job_title
        }
    }
    
    /// job所属范围
    var job_address: String = "浦东-多商圈" {
        didSet {
            hj_address_label.text = job_address
        }
    }
    
    /// job薪资
    var job_xinzi: String = "400元/天" {
        didSet {
            hj_xinzi_label.text = job_xinzi
        }
    }
    
    /// job薪资
    var job_compony: String = "上海钹栎文化传媒有限公司" {
        didSet {
            hj_compony_label.text = job_compony
        }
    }
    
    /// job的标签
    var job_tags: [String] = ["日结", "营业执照", "会员"] {
        didSet {
            hj_job_tag_view.updateTags(tags: job_tags)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        hj_virify_label.layer.masksToBounds = true
        hj_virify_label.layer.cornerRadius = 3
        hj_virify_label.layer.borderColor = UIColor(hex: "#5b8563").cgColor
        hj_virify_label.layer.borderWidth = 0.5
        
        hj_join_label.layer.masksToBounds = true
        hj_join_label.layer.cornerRadius = 5
        
        hj_job_tag_view.updateTags(tags: job_tags)
        contentView.addSubview(hj_job_tag_view)

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// line
        line.snp.remakeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(XMargin)
            make.bottom.equalTo(contentView.snp.bottom)
            make.size.equalTo(CGSize(width: ScreenWidth - XMargin - XMargin, height: 0.5))
        }
        
        /// hj_virify_label
        hj_virify_label.snp.remakeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom).offset(-YMargin)
            make.left.equalTo(contentView.snp.left).offset(XMargin)
            make.size.equalTo(CGSize(width: 30, height: 18))
        }
        
        /// hj_compony_label
        var compony_size: CGSize = "\(job_compony)  ".sizeWithAttributes(ScreenWidth, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        compony_size.height += 2
        hj_compony_label.snp.remakeConstraints { (make) in
            make.centerY.equalTo(hj_virify_label.snp.centerY)
            make.left.equalTo(hj_virify_label.snp.right).offset(5)
            make.size.equalTo(compony_size)
        }
        
        /// hj_job_tag_view
        hj_job_tag_view.snp.remakeConstraints { (make) in
            make.bottom.equalTo(hj_compony_label.snp.top).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(XMargin)
            make.size.equalTo(CGSize(width: hj_job_tag_view.v_width, height: hj_job_tag_view.v_height))
        }
        
        /// hj_title_label
        var title_size = "\(job_title)  ".sizeWithAttributes(ScreenWidth, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .medium)])
        title_size.height += 2
        title_size.width += 6
        hj_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(XMargin)
            make.top.equalTo(contentView.snp.top).offset(YMargin)
            make.size.equalTo(title_size)
        }
        
        /// hj_xinzi_label
        var xinzi_size: CGSize = "\(job_xinzi)  ".sizeWithAttributes(ScreenWidth, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .medium)])
        xinzi_size.height += 2
        xinzi_size.width += 10
        hj_xinzi_label.snp.remakeConstraints { (make) in
            make.top.equalTo(hj_title_label.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left).offset(XMargin)
            make.size.equalTo(xinzi_size)
        }
        
        /// hj_address_label
        var address_size: CGSize = "\(job_address)  ".sizeWithAttributes(ScreenWidth/2.0, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        address_size.height += 2
        address_size.width += 4
        hj_address_label.snp.remakeConstraints { (make) in
            make.centerY.equalTo(hj_title_label.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-XMargin)
            make.size.equalTo(address_size)
        }
        
        /// hj_join_label
        hj_join_label.snp.remakeConstraints { (make) in
           make.centerY.equalTo(contentView.snp.centerY)
           make.right.equalTo(contentView.snp.right).offset(-XMargin)
            make.size.equalTo(CGSize(width: 60, height: 30))
       }
        
    }
    
    
    //MARK: - Cell默认属性
    static var layoutHeight: CGFloat {
        return (20 + 25 + 10 + 20 + 10 + 20 + 10 + 20 + 20)
    }
}

/// 创建一个带有标签的View
class TagsContentView: UIView {
    
    private let base_tag: Int = 100
    private var tag_content_v_width: CGFloat = 0
    
    var v_width: CGFloat {
        get {
            return tag_content_v_width
        }
    }
    
    var v_height: CGFloat {
        get {
            return 18
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 更新tags
    public func updateTags(tags values: [String]?) {
        
        for (_, subview) in subviews.enumerated() {
            subview.removeFromSuperview()
        }
        
        // 1.如果数组为空，将所有标签隐藏
        guard let tagList = values else {
            return
        }
        
        var leftMargin: CGFloat = 0
        
        for (idx, title) in tagList.enumerated() {
            var title_size: CGSize = "\(title)  ".sizeWithAttributes(ScreenWidth/4.0, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
            title_size.height = 18
            title_size.width += 10
            let titleLabel: UILabel = getLabel(title: title)
            titleLabel.tag = base_tag + idx
            titleLabel.frame = CGRect(x: leftMargin, y: 0, width: title_size.width, height: title_size.height)
            
            leftMargin += 6
            leftMargin += title_size.width
            
            addSubview(titleLabel)
        }
        
        leftMargin += 6
        tag_content_v_width = leftMargin
        
        layoutIfNeeded()
        
    }
    
    /// 传入一个title，返回一个label
    private func getLabel(title value: String) -> UILabel {
        let titleLabel: UILabel = UILabel()
        titleLabel.isHidden = false
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor(hex: "#515151")
        titleLabel.textAlignment = .center
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.borderColor = UIColor(hex: "#9b9b9b").cgColor
        titleLabel.layer.borderWidth = 0.5
        titleLabel.layer.cornerRadius = 3.0
        titleLabel.text = value
        return titleLabel
    }
    
}

