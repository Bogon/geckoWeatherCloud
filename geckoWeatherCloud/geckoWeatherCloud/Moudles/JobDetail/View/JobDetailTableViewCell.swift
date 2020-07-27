//
//  JobDetailTableViewCell.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import Reusable

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

class JobDetailTableViewCell: UITableViewCell, NibReusable {

    static var reuseIdentifier: String { return "JobDetailTableViewCell" }
    
    // JOb 头部信息
    @IBOutlet weak var head_content_view: UIView!
    @IBOutlet weak var head_title_label: UILabel!
    @IBOutlet weak var head_xinzi_label: UILabel!
    @IBOutlet weak var head_h_line: UIView!
    @IBOutlet weak var head_salory_type_label: UILabel!
    @IBOutlet weak var head_update_label: UILabel!
    @IBOutlet weak var head_look_label: UILabel!
    @IBOutlet weak var head_want_label: UILabel!
    @IBOutlet weak var head_1_line: UIView!
    @IBOutlet weak var head_work_time_title_label: UILabel!
    @IBOutlet weak var head_work_time_value_label: UILabel!
    @IBOutlet weak var head_deadline_title_label: UILabel!
    @IBOutlet weak var head_deadline_value_label: UILabel!
    @IBOutlet weak var head_2_line: UIView!
    @IBOutlet weak var head_work_place_title_label: UILabel!
    @IBOutlet weak var head_work_place_value_label: UILabel!
    
    // JOb 职位描述
    @IBOutlet weak var job_desc_content_view: UIView!
    @IBOutlet weak var job_desc_title_label: UILabel!
    @IBOutlet weak var job_desc_line: UIView!
    @IBOutlet weak var job_desc_value_label: UILabel!
    
    // JOb 职位所在公司信息
    @IBOutlet weak var compony_content_view: UIView!
    @IBOutlet weak var compony_title_label: UILabel!
    @IBOutlet weak var compony_1_line: UIView!
    @IBOutlet weak var compony_name_label: UILabel!
    @IBOutlet weak var compony_hyv_label: UILabel!
    @IBOutlet weak var compony_qyzp_label: UILabel!
    @IBOutlet weak var compony_qyrz_button: UIButton!
    @IBOutlet weak var compony_smrz_button: UIButton!
    @IBOutlet weak var compony_guimo_label: UILabel!
    @IBOutlet weak var compony_xingzhi_label: UILabel!
    @IBOutlet weak var compony_hangye_label: UILabel!
    @IBOutlet weak var compony_line: UIView!
    @IBOutlet weak var compony_address_label: UILabel!
    @IBOutlet weak var compony_jingyingfanwei_label: UILabel!
    
    // JOb 公司信息
    var compony_title: String = "公司信息" {
        didSet {
            compony_title_label.text = compony_title
        }
    }
    
    var compony_name: String = "桐乡市欣月鞋材有限公司" {
        didSet {
            compony_name_label.text = compony_name
        }
    }
    
    var compony_guimo: String = "规模：1-49人" {
        didSet {
            compony_guimo_label.text = compony_guimo
        }
    }
    
    var compony_address: String = "公司信息" {
        didSet {
            compony_address_label.text = compony_address
        }
    }
    
    var compony_jingyingfanwei: String = "鞋底生产销售，鞋用材料的批发零售（依法须经批准的项目，经相关部门批准后方可开展经营活动）" {
        didSet {
            let new_compony_jingyingfanwei:String = compony_jingyingfanwei.replacingOccurrences(of: "58", with: "吱吱兼职")
            compony_jingyingfanwei_label.text = new_compony_jingyingfanwei
        }
    }
    
    
    
    // JOb 职位描述
    var job_desc_title: String = "职位描述" {
        didSet {
            job_desc_title_label.text = job_desc_title
        }
    }
    
    var job_desc_value: String = "工作要求：18-32周岁，普通话标准，工作负责认真，有责任心；<br>工作时间：课余时间，平时，周末，可以做长期；<br>工作时间：4-6小时，周一至周日均可，支持长期工作；" {
        didSet {
            let job_desc_value_data = job_desc_value.data(using: String.Encoding.unicode)!
            let attrStr: NSMutableAttributedString = try! NSMutableAttributedString.init(data: job_desc_value_data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            let new_job_desc_value:String = job_desc_value.replacingOccurrences(of: "<br>", with: "")
            
            let jobb_desc_value_list: [String] = job_desc_value.components(separatedBy: "<br>")
            for (_, value) in jobb_desc_value_list.enumerated() {
                let range = (new_job_desc_value as NSString).range(of: value)
                attrStr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], range: range)
            }
            job_desc_value_label.attributedText = attrStr
            job_desc_value_label.sizeToFit()
        }
    }
    
    // JOb 头部信息
    var head_title: String = "室内活动协助员" {
        didSet {
            head_title_label.text = head_title
        }
    }
    
    var head_xinzi: String = "400元/天" {
        didSet {
            head_xinzi_label.text = head_xinzi
        }
    }
    
    var head_salory_type: String = "日结" {
        didSet {
            head_salory_type_label.text = head_salory_type
        }
    }
    
    var head_update: String = "更新：今天" {
        didSet {
            head_update_label.text = head_update
        }
    }
    
    var head_want: String = "申请：4736人" {
        didSet {
            head_want_label.text = head_want
        }
    }
    
    var head_look: String = "浏览：4736人" {
        didSet {
            head_look_label.text = head_look
        }
    }
    
    var head_work_time_title: String = "工作时间：" {
        didSet {
            head_work_time_title_label.text = head_work_time_title
        }
    }
    
    var head_work_time_value: String = "星期一、星期二、星期三、星期四、星期五、星期六、星期日" {
        didSet {
            head_work_time_value_label.text = head_work_time_value
        }
    }
    
    var head_deadline_title: String = "有效期限：" {
        didSet {
            head_deadline_title_label.text = head_deadline_title
        }
    }
    
    var head_deadline_value: String = "长期招聘" {
        didSet {
            head_deadline_value_label.text = head_deadline_value
        }
    }
    
    var head_work_place_title: String = "工作地点：" {
        didSet {
            head_work_place_title_label.text = head_work_place_title
        }
    }
    
    var head_work_place_value: String = "上海浦东各大区就近分配" {
        didSet {
            head_work_place_value_label.text = head_work_place_value
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        compony_hyv_label.layer.masksToBounds = true
        compony_hyv_label.layer.borderColor = UIColor(hex: "#59B6E6").cgColor
        compony_hyv_label.layer.borderWidth = 1.0
        
        compony_qyzp_label.layer.masksToBounds = true
        compony_qyzp_label.layer.cornerRadius = 3.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Cell布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //MARK: - head_content
        var head_content_height: CGFloat = 10
        
        var head_title_size: CGSize = "\(head_title)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        head_title_size.height += 2
        
        head_content_height += head_title_size.height
        head_content_height += 20
        
        var head_xinzi_size: CGSize = "\(head_xinzi)".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        head_xinzi_size.height += 2
        
        head_content_height += head_xinzi_size.height
        head_content_height += 25
        
        var head_update_size: CGSize = "\(head_update)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10)])
        head_update_size.height += 2
        
        head_content_height += head_update_size.height
        head_content_height += 15
        
        head_content_height += 1
        head_content_height += 15
        
        var head_work_time_title_size: CGSize = "\(head_work_time_title)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        head_work_time_title_size.height += 2
        
        var head_work_time_value_size: CGSize = "\(head_work_time_value)  ".sizeWithAttributes(ScreenWidth - 30 - head_work_time_title_size.width, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        head_work_time_value_size.height += 2
        
        head_content_height += head_work_time_value_size.height
        head_content_height += 15
        
        head_content_height += head_work_time_title_size.height
        head_content_height += 15
        
        head_content_height += 1
        head_content_height += 15
        
        head_content_height += head_work_time_title_size.height
        head_content_height += 15
        
        
        head_content_view.snp.remakeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(head_content_height)
        }
        
        head_title_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_content_view.snp.top).offset(10)
            make.left.equalTo(head_content_view.snp.left).offset(15)
            make.size.equalTo(head_title_size)
        }
        
        head_xinzi_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_title_label.snp.bottom).offset(20)
            make.left.equalTo(head_content_view.snp.left).offset(15)
            make.size.equalTo(head_xinzi_size)
        }
        
        head_h_line.snp.remakeConstraints { (make) in
            make.centerY.equalTo(head_xinzi_label.snp.centerY)
            make.left.equalTo(head_xinzi_label.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 1, height: head_xinzi_size.height - 2))
        }
        
        head_salory_type_label.snp.remakeConstraints { (make) in
            make.centerY.equalTo(head_xinzi_label.snp.centerY)
            make.left.equalTo(head_h_line.snp.right).offset(5)
            make.size.equalTo(head_xinzi_size)
        }
        
        head_update_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_xinzi_label.snp.bottom).offset(25)
            make.left.equalTo(head_content_view.snp.left).offset(15)
            make.size.equalTo(CGSize(width: (ScreenWidth - 30)/3.0, height: head_update_size.height))
        }
        
        head_look_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_xinzi_label.snp.bottom).offset(25)
            make.left.equalTo(head_update_label.snp.right)
            make.size.equalTo(CGSize(width: (ScreenWidth - 30)/3.0, height: head_update_size.height))
        }
        
        head_want_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_xinzi_label.snp.bottom).offset(25)
            make.left.equalTo(head_look_label.snp.right)
            make.size.equalTo(CGSize(width: (ScreenWidth - 30)/3.0, height: head_update_size.height))
        }
        
        head_1_line.snp.remakeConstraints { (make) in
            make.top.equalTo(head_want_label.snp.bottom).offset(15)
            make.left.equalTo(head_content_view.snp.left)
            make.size.equalTo(CGSize(width: ScreenWidth, height: 1))
        }
        
        head_work_time_title_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_1_line.snp.bottom).offset(15)
            make.left.equalTo(head_content_view.snp.left).offset(15)
            make.size.equalTo(head_work_time_title_size)
        }
        
        head_work_time_value_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_1_line.snp.bottom).offset(15)
            make.left.equalTo(head_work_time_title_label.snp.right)
            make.size.equalTo(head_work_time_value_size)
        }
        
        head_deadline_title_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_work_time_value_label.snp.bottom).offset(15)
            make.left.equalTo(head_content_view.snp.left).offset(15)
            make.size.equalTo(head_work_time_title_size)
        }
        
        head_deadline_value_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_work_time_value_label.snp.bottom).offset(15)
            make.left.equalTo(head_deadline_title_label.snp.right)
            make.size.equalTo(CGSize(width: ScreenWidth - 30 - head_work_time_title_size.width, height: head_work_time_title_size.height))
        }
        
        head_2_line.snp.remakeConstraints { (make) in
            make.top.equalTo(head_deadline_title_label.snp.bottom).offset(15)
            make.left.equalTo(head_content_view.snp.left)
            make.size.equalTo(CGSize(width: ScreenWidth, height: 1))
        }
        
        head_work_place_title_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_2_line.snp.bottom).offset(15)
            make.left.equalTo(head_content_view.snp.left).offset(15)
            make.size.equalTo(head_work_time_title_size)
        }
        
        head_work_place_value_label.snp.remakeConstraints { (make) in
            make.top.equalTo(head_2_line.snp.bottom).offset(15)
            make.left.equalTo(head_work_place_title_label.snp.right)
            make.size.equalTo(CGSize(width: ScreenWidth - 30 - head_work_time_title_size.width, height: head_work_time_title_size.height))
        }
       
        //MARK: - job_desc_content
        var job_desc_content_height: CGFloat = 20
        var job_desc_title_size: CGSize = "\(job_desc_title)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        job_desc_title_size.height += 2
        
        job_desc_content_height += job_desc_title_size.height
        job_desc_content_height += 20
        
        job_desc_content_height += 1
        job_desc_content_height += 20
        
        let job_desc_value_size: CGSize = job_desc_value_label.frame.size
        
        job_desc_content_height += job_desc_value_size.height
        job_desc_content_height += 10
        
        job_desc_content_view.snp.remakeConstraints { (make) in
            make.top.equalTo(head_content_view.snp.bottom).offset(13)
            make.left.equalTo(contentView.snp.left)
            make.size.equalTo(CGSize(width: ScreenWidth, height: job_desc_content_height))
        }
        
        job_desc_title_label.snp.remakeConstraints { (make) in
            make.top.equalTo(job_desc_content_view.snp.top).offset(20)
            make.left.equalTo(job_desc_content_view.snp.left).offset(15)
            make.size.equalTo(job_desc_title_size)
        }
        
        job_desc_line.snp.remakeConstraints { (make) in
            make.top.equalTo(job_desc_title_label.snp.bottom).offset(20)
            make.left.equalTo(job_desc_content_view.snp.left)
            make.size.equalTo(CGSize(width: ScreenWidth, height: 1))
        }
        
        job_desc_value_label.snp.remakeConstraints { (make) in
            make.top.equalTo(job_desc_line.snp.bottom).offset(20)
            make.left.equalTo(job_desc_content_view.snp.left).offset(15)
            make.right.equalTo(job_desc_content_view.snp.right).offset(-15)
            make.height.equalTo(job_desc_value_size.height)
        }
        
        //MARK: - compony_content_view
        var compony_content_height: CGFloat = 20
        
        var compony_title_size: CGSize = "\(compony_title)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_title_size.height += 2
        
        compony_content_height += compony_title_size.height
        compony_content_height += 20
        
        compony_content_height += 1
        compony_content_height += 20
        
        var compony_name_size: CGSize = "\(compony_name)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_name_size.height += 2
        
        compony_content_height += compony_name_size.height
        compony_content_height += 5
        
        compony_content_height += 23
        compony_content_height += 10
        
        compony_content_height += 15
        compony_content_height += 30
        
        var compony_guimo_size: CGSize = "\(compony_guimo)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_guimo_size.height += 2
        
        compony_content_height += compony_name_size.height
        compony_content_height += 15
        
        compony_content_height += compony_name_size.height
        compony_content_height += 15
        
        compony_content_height += compony_name_size.height
        compony_content_height += 30
        
        compony_content_height += 1
        compony_content_height += 20
        
        var compony_address_size: CGSize = "\(compony_address)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_address_size.height += 2
        
        compony_content_height += compony_name_size.height
        compony_content_height += 20
        
        var compony_jingyingfanwei_size: CGSize = "\(compony_jingyingfanwei)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_jingyingfanwei_size.height += 2
        
        compony_content_height += compony_jingyingfanwei_size.height
        
        compony_content_view.snp.remakeConstraints { (make) in
            make.top.equalTo(job_desc_content_view.snp.bottom).offset(13)
            make.left.equalTo(contentView.snp.left)
            make.size.equalTo(CGSize(width: ScreenWidth, height: compony_content_height))
        }
        
        compony_title_label.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_content_view.snp.top).offset(20)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(compony_title_size)
        }
        
        compony_1_line.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_title_label.snp.bottom).offset(20)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(CGSize(width: ScreenWidth, height: 1))
        }
        
        compony_name_label.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_1_line.snp.bottom).offset(15)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(compony_name_size)
        }
        
        compony_hyv_label.snp.remakeConstraints { (make) in
            make.centerY.equalTo(compony_name_label.snp.centerY)
            make.left.equalTo(compony_name_label.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        compony_qyzp_label.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_name_label.snp.bottom).offset(5)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(CGSize(width: 70, height: 23))
        }
        
        compony_qyrz_button.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_qyzp_label.snp.bottom).offset(10)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(CGSize(width: 100, height: 15))
        }
        
        compony_smrz_button.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_qyzp_label.snp.bottom).offset(10)
            make.left.equalTo(compony_qyrz_button.snp.right).offset(8)
            make.size.equalTo(CGSize(width: 100, height: 15))
        }
        
        compony_guimo_label.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_qyrz_button.snp.bottom).offset(30)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(compony_guimo_size)
        }
        
        compony_xingzhi_label.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_guimo_label.snp.bottom).offset(10)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(CGSize(width: ScreenWidth/2.0, height: compony_guimo_size.height))
        }
        
        compony_hangye_label.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_xingzhi_label.snp.bottom).offset(10)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(CGSize(width: ScreenWidth/2.0, height: compony_guimo_size.height))
        }
        
        compony_line.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_hangye_label.snp.bottom).offset(20)
            make.left.equalTo(compony_content_view.snp.left)
            make.size.equalTo(CGSize(width: ScreenWidth, height: 1))
        }
        
        compony_address_label.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_line.snp.bottom).offset(20)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(CGSize(width: ScreenWidth - 30, height: compony_guimo_size.height))
        }
        
        compony_jingyingfanwei_label.snp.remakeConstraints { (make) in
            make.top.equalTo(compony_address_label.snp.bottom).offset(20)
            make.left.equalTo(compony_content_view.snp.left).offset(15)
            make.size.equalTo(compony_jingyingfanwei_size)
        }
        
    }
    
    //MARK: - Cell默认属性
    static func layoutHeight(infoModel element: JobDetailResponseModel) -> CGFloat {
        
        var cell_height: CGFloat = 0
        
        // JOb 头部信息
        let head_title: String = element.titleAreaInfoModel?.title ?? ""
        let xinzi_type: [String] = element.titleAreaInfoModel?.unit?.components(separatedBy: CharacterSet.init(charactersIn: "，")) ?? ["元/天", "日结"]
        let head_xinzi: String = "\(element.titleAreaInfoModel?.price ?? "400")\(xinzi_type.first!)"
        let head_update: String = element.titleAreaInfoModel?.date ?? "更新：今天"
        let head_work_time_title: String = element.titleAreaInfoModel?.work_time?.0 ?? "工作时间"
        let head_work_time_value: String = element.titleAreaInfoModel?.work_time?.1 ?? "星期一、星期二、星期三、星期四、星期五、星期六、星期日"

        //MARK: - head_content
        var head_content_height: CGFloat = 10
        
        var head_title_size: CGSize = "\(head_title)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        head_title_size.height += 2
        
        head_content_height += head_title_size.height
        head_content_height += 20
        
        var head_xinzi_size: CGSize = "\(head_xinzi)".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        head_xinzi_size.height += 2
        
        head_content_height += head_xinzi_size.height
        head_content_height += 25
        
        var head_update_size: CGSize = "\(head_update)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10)])
        head_update_size.height += 2
        
        head_content_height += head_update_size.height
        head_content_height += 15
        
        head_content_height += 1
        head_content_height += 15
        
        var head_work_time_title_size: CGSize = "\(head_work_time_title)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        head_work_time_title_size.height += 2
        
        var head_work_time_value_size: CGSize = "\(head_work_time_value)  ".sizeWithAttributes(ScreenWidth - 30 - head_work_time_title_size.width, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        head_work_time_value_size.height += 2
        
        head_content_height += head_work_time_value_size.height
        head_content_height += 15
        
        head_content_height += head_work_time_title_size.height
        head_content_height += 15
        
        head_content_height += 1
        head_content_height += 15
        
        head_content_height += head_work_time_title_size.height
        head_content_height += 15
        
        cell_height += head_content_height
        cell_height += 13
        
        // JOb 职位描述
        let job_desc_title = element.jobAreaDescInfoModel?.desc_job?.0 ?? "职位描述"
        let job_desc_value = element.jobAreaDescInfoModel?.desc_job?.1 ?? "工作要求：18-32周岁，普通话标准，工作负责认真，有责任心；<br>工作时间：课余时间，平时，周末，可以做长期；<br>工作时间：4-6小时，周一至周日均可，支持长期工作。"
       
        //MARK: - job_desc_content
        var job_desc_content_height: CGFloat = 20
        var job_desc_title_size: CGSize = "\(job_desc_title)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        job_desc_title_size.height += 2
        
        job_desc_content_height += job_desc_title_size.height
        job_desc_content_height += 20
        
        job_desc_content_height += 1
        job_desc_content_height += 20
        
        let job_desc_value_data = job_desc_value.data(using: String.Encoding.unicode)!
        let attrStr: NSMutableAttributedString = try! NSMutableAttributedString.init(data: job_desc_value_data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        
        let new_job_desc_value:String = job_desc_value.replacingOccurrences(of: "<br>", with: "")
        
        let jobb_desc_value_list: [String] = job_desc_value.components(separatedBy: "<br>")
        for (_, value) in jobb_desc_value_list.enumerated() {
            let range = (new_job_desc_value as NSString).range(of: value)
            attrStr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], range: range)
        }
        
        let jobb_desc_value_rect = attrStr.boundingRect(with:  CGSize(width: ScreenWidth - 30, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil)
        
        
        job_desc_content_height += jobb_desc_value_rect.size.height
        job_desc_content_height += 10
        
        cell_height += job_desc_content_height
        cell_height += 13
        
        //MARK: - compony_content_view
        // JOb 公司信息
        let compony_title = element.jobComponyDescInfoModel?.title ?? "桐乡市欣月鞋材有限公司"
        let compony_name = element.jobComponyDescInfoModel?.componyInfoModel?.name ?? ""
        let compony_guimo = "规模：\(element.jobComponyDescInfoModel?.componyInfoModel?.size ?? "-")"
        let compony_address = "\(element.jobComponyDescInfoModel?.componyAddressInfoModel?.title ?? "公司地址：")：\(element.jobComponyDescInfoModel?.componyAddressInfoModel?.content == "" ? "-" : element.jobComponyDescInfoModel?.componyAddressInfoModel?.content ?? "-")"
        let compony_jingyingfanwei = element.jobComponyDescInfoModel?.componyAddressInfoModel?.companyDesc ?? ""
        
        
        var compony_content_height: CGFloat = 20
        
        var compony_title_size: CGSize = "\(compony_title)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_title_size.height += 2
        
        compony_content_height += compony_title_size.height
        compony_content_height += 20
        
        compony_content_height += 1
        compony_content_height += 20
        
        var compony_name_size: CGSize = "\(compony_name)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_name_size.height += 2
        
        compony_content_height += compony_name_size.height
        compony_content_height += 5
        
        compony_content_height += 23
        compony_content_height += 10
        
        compony_content_height += 15
        compony_content_height += 30
        
        var compony_guimo_size: CGSize = "\(compony_guimo)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_guimo_size.height += 2
        
        compony_content_height += compony_name_size.height
        compony_content_height += 15
        
        compony_content_height += compony_name_size.height
        compony_content_height += 15
        
        compony_content_height += compony_name_size.height
        compony_content_height += 30
        
        compony_content_height += 1
        compony_content_height += 20
        
        var compony_address_size: CGSize = "\(compony_address)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_address_size.height += 2
        
        compony_content_height += compony_name_size.height
        compony_content_height += 20
        
        var compony_jingyingfanwei_size: CGSize = "\(compony_jingyingfanwei)  ".sizeWithAttributes(ScreenWidth - 30, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        compony_jingyingfanwei_size.height += 2
        
        compony_content_height += compony_jingyingfanwei_size.height
        compony_content_height += 30
        
        cell_height += compony_content_height
        cell_height += 13
        
        return cell_height
    }
    
}
