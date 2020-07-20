//
//  SettingTableViewCell.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var svc_title_label: UILabel!
    
    // MARK: - 添加属性监听器，修改控件上的值
    var value: String = "" {
        didSet {
            svc_title_label.text = value
        }
    }
    
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
        
        /// svc_title_label
        svc_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(25)
        }
    }
    
    //MARK: - Cell默认属性
    static var layoutHeight: CGFloat {
        return 48
    }
    
}
