//
//  LoginContentView.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

protocol LoginContentDelegate: NSObjectProtocol {
    func login()
    func signup()
}

class LoginContentView: UIView {

    weak var delegate: LoginContentDelegate?
    
    @IBOutlet weak var lc_title_label: UILabel!
    @IBOutlet weak var lc_email_content_view: UIView!
    @IBOutlet weak var lc_email_textField: JVFloatLabeledTextField!
    
    @IBOutlet weak var lc_password_content_view: UIView!
    @IBOutlet weak var lc_password_textField: JVFloatLabeledTextField!
    
    @IBOutlet weak var lc_login_button: UIButton!
    @IBOutlet weak var lc_create_button: UIButton!
    
    @IBOutlet weak var lc_e_validate_imageview: UIImageView!
    @IBOutlet weak var lc_p_validate_imageview: UIImageView!
    
    var nickname_result: ValidateResult = .empty {
        didSet {
            switch nickname_result {
            case .success(message: _):
                lc_e_validate_imageview.image = Asset.validateCorrect.image
            case .empty:
                lc_e_validate_imageview.image = nil
            case .failed(message: _):
                lc_e_validate_imageview.image = Asset.validateWrong.image
            }
        }
    }
    
    var password_result: ValidateResult = .empty {
        didSet {
            switch password_result {
            case .success(message: _):
                lc_p_validate_imageview.image = Asset.validateCorrect.image
            case .empty:
                lc_p_validate_imageview.image = nil
            case .failed(message: _):
                lc_p_validate_imageview.image = Asset.validateWrong.image
            }
        }
    }
    
    var login_isEnable: Bool = false {
        didSet {
            lc_login_button.isEnabled = login_isEnable
            lc_login_button.isUserInteractionEnabled = login_isEnable
        }
    }
    
    /// 获取输入框中的值
    var login_info: (String, String) {
        let email: String = lc_email_textField.text ?? ""
        let password: String = lc_password_textField.text ?? ""
        return (email.removeAllSapce, password)
    }
    
    // MARK:- 创建视图
    class func instance() -> LoginContentView? {
        let nibView = Bundle.main.loadNibNamed("LoginContentView", owner: nil, options: nil)
        if let view = nibView?.first as? LoginContentView {
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
        password_result = .empty
        
        lc_email_content_view.backgroundColor = .white
        lc_email_content_view.layer.cornerRadius = 10
        // shadowCode
        lc_email_content_view.layer.shadowColor = UIColor(hex: "#f1f1f1").cgColor
        lc_email_content_view.layer.shadowOffset = CGSize(width: 0, height: 0)
        lc_email_content_view.layer.shadowOpacity = 1
        lc_email_content_view.layer.shadowRadius = 5
        
        lc_email_textField.font = UIFont.systemFont(ofSize: 15)
        lc_email_textField.setAttributedPlaceholder(NSAttributedString(string: "请输入你的常用邮箱", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.darkGray]), floatingTitle: "输入邮箱…")
        lc_email_textField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        lc_email_textField.floatingLabelTextColor = UIColor(hex: "#cacaca")
        lc_email_textField.alwaysShowFloatingLabel = true
        lc_email_textField.floatingLabelActiveTextColor = UIColor(hex: "#cacaca")
        lc_email_textField.clearButtonMode = .whileEditing
        lc_email_textField.translatesAutoresizingMaskIntoConstraints = false
        lc_email_textField.keepBaseline = true
        
        
        
        lc_password_content_view.backgroundColor = .white
        lc_password_content_view.layer.cornerRadius = 10
        // shadowCode
        lc_password_content_view.layer.shadowColor = UIColor(hex: "#f1f1f1").cgColor
        lc_password_content_view.layer.shadowOffset = CGSize(width: 0, height: 0)
        lc_password_content_view.layer.shadowOpacity = 1
        lc_password_content_view.layer.shadowRadius = 5
        
        lc_password_textField.font = UIFont.systemFont(ofSize: 15)
        lc_password_textField.setAttributedPlaceholder(NSAttributedString(string: "请输入登录密码", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.darkGray]), floatingTitle: "输入密码…")
        lc_password_textField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        lc_password_textField.floatingLabelTextColor = UIColor(hex: "#cacaca")
        lc_password_textField.alwaysShowFloatingLabel = true
        lc_password_textField.floatingLabelActiveTextColor = UIColor(hex: "#cacaca")
        lc_password_textField.clearButtonMode = .whileEditing
        lc_password_textField.translatesAutoresizingMaskIntoConstraints = false
        lc_password_textField.keepBaseline = true
        lc_password_textField.isSecureTextEntry = true
        
        lc_login_button.layer.masksToBounds = true
        lc_login_button.layer.cornerRadius = 45/2.0
        lc_login_button.isEnabled = false
        let disable_image: UIImage = UIImage.getImage(WithColor: UIColor(hex: "#f2f2f2"), size: CGSize(width: ScreenWidth - 30 - 45, height: 44))
        lc_login_button.setBackgroundImage(disable_image, for: UIControl.State.disabled)
        lc_login_button.setTitleColor(UIColor(hex: "#333333"), for: UIControl.State.disabled)
        
        let enable_image: UIImage = UIImage.getImage(WithColor: UIColor(hex: "#436eee"), size: CGSize(width: ScreenWidth - 30 - 45, height: 44))
        lc_login_button.setBackgroundImage(enable_image, for: UIControl.State.normal)
        lc_login_button.setTitleColor(UIColor(hex: "#ffffff"), for: UIControl.State.normal)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*
         @IBOutlet weak var lc_title_label: UILabel!
         @IBOutlet weak var lc_email_content_view: UIView!
         @IBOutlet weak var lc_email_textField: JVFloatLabeledTextField!
         */
        lc_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 30))
        }
        
        lc_email_content_view.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(lc_title_label.snp.bottom).offset(55)
            make.size.equalTo(CGSize(width: ScreenWidth - 30, height: 10 + 44 + 15))
        }
        
        lc_e_validate_imageview.snp.remakeConstraints { (make) in
            make.right.equalTo(lc_email_content_view.snp.right).offset(-15)
            make.centerY.equalTo(lc_email_content_view.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        lc_email_textField.snp.remakeConstraints { (make) in
            make.left.equalTo(lc_email_content_view.snp.left).offset(15)
            make.right.equalTo(lc_e_validate_imageview.snp.right).offset(-20)
            make.top.equalTo(lc_email_content_view.snp.top).offset(17)
            make.height.equalTo(44)
        }
        
        /*
         @IBOutlet weak var lc_password_content_view: UIView!
         @IBOutlet weak var lc_password_textField: JVFloatLabeledTextField!
         */
        
        lc_password_content_view.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(lc_email_content_view.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: ScreenWidth - 30, height: 10 + 44 + 15))
        }
        
        lc_p_validate_imageview.snp.remakeConstraints { (make) in
            make.right.equalTo(lc_password_content_view.snp.right).offset(-15)
            make.centerY.equalTo(lc_password_content_view.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        lc_password_textField.snp.remakeConstraints { (make) in
            make.left.equalTo(lc_password_content_view.snp.left).offset(15)
            make.right.equalTo(lc_p_validate_imageview.snp.right).offset(-20)
            make.top.equalTo(lc_password_content_view.snp.top).offset(17)
            make.height.equalTo(44)
        }
        
        lc_create_button.snp.remakeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.top.equalTo(lc_password_content_view.snp.bottom)
            make.size.equalTo(CGSize(width: 80, height: 60))
            
        }
        
        lc_login_button.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(lc_create_button.snp.bottom).offset(55)
            make.size.equalTo(CGSize(width: ScreenWidth - 60, height: 45))
            
        }
    }
    
    static var layoutHeight: CGFloat {
        return ScreenHeight
    }

}
