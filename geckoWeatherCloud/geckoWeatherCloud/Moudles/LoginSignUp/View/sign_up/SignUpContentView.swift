//
//  SignUpContentView.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

protocol SignUpContentDelegate: NSObjectProtocol {
    func login()
    func signup()
}

class SignUpContentView: UIView {

    weak var delegate: SignUpContentDelegate?

    @IBOutlet weak var sc_title_label: UILabel!
    
    @IBOutlet weak var sc_nickname_content_view: UIView!
    @IBOutlet weak var sc_nickname_textFiled: JVFloatLabeledTextField!
    @IBOutlet weak var sc_n_validate_imagview: UIImageView!
    
    @IBOutlet weak var sc_email_content_view: UIView!
    @IBOutlet weak var sc_email_textFiled: JVFloatLabeledTextField!
    @IBOutlet weak var sc_e_validate_imagview: UIImageView!
    
    
    @IBOutlet weak var sc_password_content_view: UIView!
    @IBOutlet weak var sc_password_textFiled: JVFloatLabeledTextField!
    @IBOutlet weak var sc_p_validate_imagview: UIImageView!
    
    
    @IBOutlet weak var sc_login_buttton: UIButton!
    @IBOutlet weak var sc_signup_button: UIButton!
    
    
    var nickname_result: ValidateResult = .empty {
        didSet {
            switch nickname_result {
            case .success(message: _):
                sc_n_validate_imagview.image = Asset.validateCorrect.image
            case .empty:
                sc_n_validate_imagview.image = nil
            case .failed(message: _):
                sc_n_validate_imagview.image = Asset.validateWrong.image
            }
        }
    }
    
    var email_result: ValidateResult = .empty {
        didSet {
            switch email_result {
            case .success(message: _):
                sc_e_validate_imagview.image = Asset.validateCorrect.image
            case .empty:
                sc_e_validate_imagview.image = nil
            case .failed(message: _):
                sc_e_validate_imagview.image = Asset.validateWrong.image
            }
        }
    }
    
    var password_result: ValidateResult = .empty {
        didSet {
            switch password_result {
            case .success(message: _):
                sc_p_validate_imagview.image = Asset.validateCorrect.image
            case .empty:
                sc_p_validate_imagview.image = nil
            case .failed(message: _):
                sc_p_validate_imagview.image = Asset.validateWrong.image
            }
        }
    }
    
    var signup_isEnable: Bool = false {
        didSet {
            sc_signup_button.isEnabled = signup_isEnable
            sc_signup_button.isUserInteractionEnabled = signup_isEnable
        }
    }
    
    /// 获取输入框中的值
    var signup_info: (String, String, String) {
        let nickname: String = sc_nickname_textFiled.text ?? ""
        let email: String = sc_email_textFiled.text ?? ""
        let password: String = sc_password_textFiled.text ?? ""
        return (nickname, email.removeAllSapce, password)
    }
    
    // MARK:- 创建视图
    class func instance() -> SignUpContentView? {
        let nibView = Bundle.main.loadNibNamed("SignUpContentView", owner: nil, options: nil)
        if let view = nibView?.first as? SignUpContentView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }
    
    @IBAction func login_action(_ sender: UIButton) {
        delegate?.login()
    }
    
    @IBAction func create_account_action(_ sender: UIButton) {
        delegate?.signup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nickname_result = .empty
        email_result = .empty
        password_result = .empty
       
        /*
         @IBOutlet weak var sc_nickname_content_view: UIView!
         @IBOutlet weak var sc_nickname_textFiled: JVFloatLabeledTextField!
         @IBOutlet weak var sc_n_validate_imagview: UIImageView!
         */
        
        sc_nickname_content_view.backgroundColor = .white
        sc_nickname_content_view.layer.cornerRadius = 10
        // shadowCode
        sc_nickname_content_view.layer.shadowColor = UIColor(hex: "#f1f1f1").cgColor
        sc_nickname_content_view.layer.shadowOffset = CGSize(width: 0, height: 0)
        sc_nickname_content_view.layer.shadowOpacity = 1
        sc_nickname_content_view.layer.shadowRadius = 5
        
        sc_nickname_textFiled.font = UIFont.systemFont(ofSize: 15)
        sc_nickname_textFiled.setAttributedPlaceholder(NSAttributedString(string: "请输入昵称", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.darkGray]), floatingTitle: "请设置昵称(至少5个字符)…")
        sc_nickname_textFiled.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        sc_nickname_textFiled.floatingLabelTextColor = UIColor(hex: "#cacaca")
        sc_nickname_textFiled.alwaysShowFloatingLabel = true
        sc_nickname_textFiled.floatingLabelActiveTextColor = UIColor(hex: "#cacaca")
        sc_nickname_textFiled.clearButtonMode = .whileEditing
        sc_nickname_textFiled.translatesAutoresizingMaskIntoConstraints = false
        sc_nickname_textFiled.keepBaseline = true
        
        /*
         @IBOutlet weak var sc_email_content_view: UIView!
            @IBOutlet weak var sc_email_textFiled: JVFloatLabeledTextField!
            @IBOutlet weak var sc_e_validate_imagview: UIImageView!
         */
        
        sc_email_content_view.backgroundColor = .white
        sc_email_content_view.layer.cornerRadius = 10
        // shadowCode
        sc_email_content_view.layer.shadowColor = UIColor(hex: "#f1f1f1").cgColor
        sc_email_content_view.layer.shadowOffset = CGSize(width: 0, height: 0)
        sc_email_content_view.layer.shadowOpacity = 1
        sc_email_content_view.layer.shadowRadius = 5
        
        sc_email_textFiled.font = UIFont.systemFont(ofSize: 15)
        sc_email_textFiled.setAttributedPlaceholder(NSAttributedString(string: "请输入你的常用邮箱", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.darkGray]), floatingTitle: "请设置邮箱…")
        sc_email_textFiled.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        sc_email_textFiled.floatingLabelTextColor = UIColor(hex: "#cacaca")
        sc_email_textFiled.alwaysShowFloatingLabel = true
        sc_email_textFiled.floatingLabelActiveTextColor = UIColor(hex: "#cacaca")
        sc_email_textFiled.clearButtonMode = .whileEditing
        sc_email_textFiled.translatesAutoresizingMaskIntoConstraints = false
        sc_email_textFiled.keepBaseline = true
        
        /*
         @IBOutlet weak var sc_password_content_view: UIView!
         @IBOutlet weak var sc_password_textFiled: JVFloatLabeledTextField!
         @IBOutlet weak var sc_p_validate_imagview: UIImageView!
         */
        
        sc_password_content_view.backgroundColor = .white
        sc_password_content_view.layer.cornerRadius = 10
        // shadowCode
        sc_password_content_view.layer.shadowColor = UIColor(hex: "#f1f1f1").cgColor
        sc_password_content_view.layer.shadowOffset = CGSize(width: 0, height: 0)
        sc_password_content_view.layer.shadowOpacity = 1
        sc_password_content_view.layer.shadowRadius = 5
        
        sc_password_textFiled.font = UIFont.systemFont(ofSize: 15)
        sc_password_textFiled.setAttributedPlaceholder(NSAttributedString(string: "请输入登录密码", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.darkGray]), floatingTitle: "输入密码(至少8个字符)…")
        sc_password_textFiled.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        sc_password_textFiled.floatingLabelTextColor = UIColor(hex: "#cacaca")
        sc_password_textFiled.alwaysShowFloatingLabel = true
        sc_password_textFiled.floatingLabelActiveTextColor = UIColor(hex: "#cacaca")
        sc_password_textFiled.clearButtonMode = .whileEditing
        sc_password_textFiled.translatesAutoresizingMaskIntoConstraints = false
        sc_password_textFiled.keepBaseline = true
        sc_password_textFiled.isSecureTextEntry = true
        
        
        /*
          @IBOutlet weak var sc_signup_button: UIButton!
         */
        sc_signup_button.layer.masksToBounds = true
        sc_signup_button.layer.cornerRadius = 45/2.0
        sc_signup_button.isEnabled = false
        let disable_image: UIImage = UIImage.getImage(WithColor: UIColor(hex: "#f2f2f2"), size: CGSize(width: ScreenWidth - 30 - 45, height: 44))
        sc_signup_button.setBackgroundImage(disable_image, for: UIControl.State.disabled)
        sc_signup_button.setTitleColor(UIColor(hex: "#333333"), for: UIControl.State.disabled)
        
        let enable_image: UIImage = UIImage.getImage(WithColor: UIColor(hex: "#436eee"), size: CGSize(width: ScreenWidth - 30 - 45, height: 44))
        sc_signup_button.setBackgroundImage(enable_image, for: UIControl.State.normal)
        sc_signup_button.setTitleColor(UIColor(hex: "#ffffff"), for: UIControl.State.normal)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*
         @IBOutlet weak var sc_title_label: UILabel!
         */
        sc_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 30))
        }
        
        /*
        @IBOutlet weak var sc_nickname_content_view: UIView!
        @IBOutlet weak var sc_nickname_textFiled: JVFloatLabeledTextField!
        @IBOutlet weak var sc_n_validate_imagview: UIImageView!
        */
        sc_nickname_content_view.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(sc_title_label.snp.bottom).offset(55)
            make.size.equalTo(CGSize(width: ScreenWidth - 30, height: 10 + 44 + 15))
        }
        
        sc_n_validate_imagview.snp.remakeConstraints { (make) in
            make.right.equalTo(sc_nickname_content_view.snp.right).offset(-15)
            make.centerY.equalTo(sc_nickname_content_view.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        sc_nickname_textFiled.snp.remakeConstraints { (make) in
            make.left.equalTo(sc_nickname_content_view.snp.left).offset(15)
            make.right.equalTo(sc_n_validate_imagview.snp.right).offset(-20)
            make.top.equalTo(sc_nickname_content_view.snp.top).offset(17)
            make.height.equalTo(44)
        }
        
        /*
        @IBOutlet weak var sc_email_content_view: UIView!
        @IBOutlet weak var sc_email_textFiled: JVFloatLabeledTextField!
        @IBOutlet weak var sc_e_validate_imagview: UIImageView!
        */
        sc_email_content_view.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(sc_nickname_content_view.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: ScreenWidth - 30, height: 10 + 44 + 15))
        }
        
        sc_e_validate_imagview.snp.remakeConstraints { (make) in
            make.right.equalTo(sc_email_content_view.snp.right).offset(-15)
            make.centerY.equalTo(sc_email_content_view.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        sc_email_textFiled.snp.remakeConstraints { (make) in
            make.left.equalTo(sc_email_content_view.snp.left).offset(15)
            make.right.equalTo(sc_e_validate_imagview.snp.right).offset(-20)
            make.top.equalTo(sc_email_content_view.snp.top).offset(17)
            make.height.equalTo(44)
        }
        
        /*
        @IBOutlet weak var sc_password_content_view: UIView!
        @IBOutlet weak var sc_password_textFiled: JVFloatLabeledTextField!
        @IBOutlet weak var sc_p_validate_imagview: UIImageView!
        */
        sc_password_content_view.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(sc_email_content_view.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: ScreenWidth - 30, height: 10 + 44 + 15))
        }
        
        sc_p_validate_imagview.snp.remakeConstraints { (make) in
            make.right.equalTo(sc_password_content_view.snp.right).offset(-15)
            make.centerY.equalTo(sc_password_content_view.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        sc_password_textFiled.snp.remakeConstraints { (make) in
            make.left.equalTo(sc_password_content_view.snp.left).offset(15)
            make.right.equalTo(sc_p_validate_imagview.snp.right).offset(-20)
            make.top.equalTo(sc_password_content_view.snp.top).offset(17)
            make.height.equalTo(44)
        }
        
        /*
         @IBOutlet weak var sc_login_buttton: UIButton!
         @IBOutlet weak var sc_signup_button: UIButton!
         */
        
        sc_login_buttton.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.top.equalTo(sc_password_content_view.snp.bottom)
            make.size.equalTo(CGSize(width: 120, height: 60))
            
        }
        
        sc_signup_button.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(sc_login_buttton.snp.bottom).offset(55)
            make.size.equalTo(CGSize(width: ScreenWidth - 60, height: 45))
            
        }
        
    }
    
    static var layoutHeight: CGFloat {
        return ScreenHeight
    }
    
}
