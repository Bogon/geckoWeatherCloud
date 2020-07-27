//
//  SettingHeaderView.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

protocol SettingHeaderLoginDelegate: NSObjectProtocol {
    func login_sign_up()
}


class SettingHeaderView: UIView {

    weak var delegate: SettingHeaderLoginDelegate?
    
    @IBOutlet weak var setting_head_bg_imageview: UIImageView!
    @IBOutlet weak var setting_head_avatar_imageview: UIImageView!
    @IBOutlet weak var setting_nickname_label: UILabel!
    @IBOutlet weak var setting_h_look_button: UIButton!
    @IBOutlet weak var setting_h_join_button: UIButton!
    @IBOutlet weak var setting_h_collcetion_button: UIButton!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var setting_h_login_button: UIButton!
    @IBOutlet weak var setting_h_title_label: UILabel!
    
    var nickname: String = "awdiq23123" {
        didSet {
            setting_nickname_label.text = nickname
        }
    }
    
    
    var look_count: String = "-" {
        didSet {
            setting_h_look_button.setTitle("浏览：\(look_count)个", for: UIControl.State.normal)
        }
    }
    
    var join_count: String = "-" {
        didSet {
            setting_h_join_button.setTitle("报名：\(join_count)个", for: UIControl.State.normal)
        }
    }
    
    var collection_count: String = "-" {
        didSet {
            setting_h_collcetion_button.setTitle("收藏：\(collection_count)个", for: UIControl.State.normal)
        }
    }
    
    var is_login: Bool = false {
        didSet {
            if is_login {
                setting_h_login_button.isHidden = true
                setting_h_title_label.isHidden = true
                setting_nickname_label.isHidden = false
                
                setting_head_avatar_imageview.image = Asset.avatarLogin.image
            } else {
                setting_h_login_button.isHidden = false
                setting_h_title_label.isHidden = false
                setting_nickname_label.isHidden = true
                
                look_count = "-"
                join_count = "-"
                collection_count = "-"
                
                setting_head_avatar_imageview.image = Asset.avatarDefault.image
            }
        }
    }
    
    
    // MARK:- 创建视图
    class func instance() -> SettingHeaderView? {
        let nibView = Bundle.main.loadNibNamed("SettingHeaderView", owner: nil, options: nil)
        if let view = nibView?.first as? SettingHeaderView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        clipsToBounds = true
        
        // 默认设置
        setting_h_login_button.isHidden = false
        setting_h_title_label.isHidden = false
        setting_nickname_label.isHidden = true
        
        look_count = "-"
        join_count = "-"
        collection_count = "-"
        
        setting_head_avatar_imageview.image = Asset.avatarDefault.image
        
        setting_head_avatar_imageview.layer.masksToBounds = true
        setting_head_avatar_imageview.layer.cornerRadius = 25
        setting_head_avatar_imageview.layer.borderColor = UIColor(hex: "f2f2f2").cgColor
        setting_head_avatar_imageview.layer.borderWidth = 1.5
        
    }
    
    @IBAction func loginSignUpAction(_ sender: UIButton) {
        delegate?.login_sign_up()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        setting_head_bg_imageview.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(200)
        }
        
        setting_head_avatar_imageview.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.top.equalTo(self.snp.top).offset(15)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        setting_nickname_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.snp.top).offset(15)
            make.size.equalTo(CGSize(width: ScreenWidth - 30 - 50 - 15, height: 20))
        }
        
        let setting_h_button_width: CGFloat = (ScreenWidth - 30)/3.0
        
        setting_h_look_button.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.bottom.equalTo(self.snp.bottom).offset(-15)
            make.size.equalTo(CGSize(width: setting_h_button_width, height: 20))
        }
        
        setting_h_join_button.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-15)
            make.size.equalTo(CGSize(width: setting_h_button_width, height: 20))
        }
        
        setting_h_collcetion_button.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.bottom.equalTo(self.snp.bottom).offset(-15)
            make.size.equalTo(CGSize(width: setting_h_button_width, height: 20))
        }
        
        line.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(self.snp.bottom)
            make.size.equalTo(CGSize(width: ScreenWidth, height: 1))
        }
        
        setting_h_login_button.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.snp.top).offset(15)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        setting_h_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(setting_h_login_button.snp.bottom)
            make.size.equalTo(CGSize(width: ScreenWidth - 30 - 50 - 15, height: 18))
        }
    }
    
    static var layoutHeight: CGFloat {
       
        let contentHeight: CGFloat = 160
        return contentHeight
    }

}
