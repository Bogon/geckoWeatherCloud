//
//  LoginController.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import RxCocoa
import RxSwift
import JVFloatLabeledTextField

class LoginController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    let bag = DisposeBag()
    
    var viewModel: LoginViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    /// 登录视图
    var loginContentView: LoginContentView = LoginContentView.instance()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = ""
        
        viewModel = LoginViewModel(input: (email: loginContentView.lc_email_textField.rx.text.orEmpty.asDriver(), password: loginContentView.lc_password_textField.rx.text.orEmpty.asDriver()), validationService: ValidationService())
        
        viewModel?.emailUsable.drive(onNext: { [weak self] result in
            self?.loginContentView.nickname_result = result
        }).disposed(by: bag)
        
        viewModel?.passwordUsable.drive(onNext: { [weak self] result in
            self?.loginContentView.password_result = result
        }).disposed(by: bag)
        
        viewModel?.loginButtonEnabled.drive(onNext: { [weak self] isEnable in
            self?.loginContentView.login_isEnable = isEnable
        }).disposed(by: bag)
        
    }

}


extension LoginController: LoginContentDelegate {

    /// 1.登录
    func login() {
        /// 1.获取登录信息
        let userinfo: (String, String) = loginContentView.login_info
        /// 2.登录
        let isLogined: Bool = UserInfoHandle.share.login(email: userinfo.0, password: userinfo.1)

        if isLogined {
            MBProgressHUD.showMessage("登录成功", to: view)
            self.dismiss(animated: true, completion: nil)
        } else {
            MBProgressHUD.showError("用户名或密码错误", to: view)
        }
    }

    /// 2.注册
    func signup() {
        let signUpController: SignUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
}
