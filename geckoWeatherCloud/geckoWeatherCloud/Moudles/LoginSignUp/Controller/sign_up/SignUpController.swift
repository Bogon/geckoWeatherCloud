//
//  SignUpController.swift
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

class SignUpController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    let bag = DisposeBag()
       
    var viewModel: SignUpViewModel?
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
   
    override var prefersStatusBarHidden: Bool {
        return false
    }
   
   /// 注册视图
   var signUpContentView: SignUpContentView = SignUpContentView.instance()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = ""
        
        viewModel = SignUpViewModel(input: (nickname: signUpContentView.sc_nickname_textFiled.rx.text.orEmpty.asDriver(), email: signUpContentView.sc_email_textFiled.rx.text.orEmpty.asDriver(), password: signUpContentView.sc_password_textFiled.rx.text.orEmpty.asDriver()), validationService: ValidationService())
        
        viewModel?.nicknameUsable.drive(onNext: { [weak self] result in
            self?.signUpContentView.nickname_result = result
        }).disposed(by: bag)
        
        viewModel?.emailUsable.drive(onNext: { [weak self] result in
            self?.signUpContentView.email_result = result
        }).disposed(by: bag)
        
        viewModel?.passwordUsable.drive(onNext: { [weak self] result in
            self?.signUpContentView.password_result = result
        }).disposed(by: bag)
        
        viewModel?.signupButtonEnabled.drive(onNext: { [weak self] isEnable in
            self?.signUpContentView.signup_isEnable = isEnable
        }).disposed(by: bag)
        
        
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 导航栏跟随滑动视图滚动
    //        if let navigationController = self.navigationController as? ScrollingNavigationController {
    //            if let tabBarController = tabBarController {
    //                navigationController.followScrollView(settingTableView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
    //            } else {
    //                navigationController.followScrollView(settingTableView, delay: 0.0, scrollSpeedFactor: 2)
    //            }
    //            navigationController.scrollingNavbarDelegate = self
    //            navigationController.expandOnActive = false
    //        }
    }

}

extension SignUpController: SignUpContentDelegate {
    
    /// 1.返回登录界面
    func login() {
        navigationController?.popViewController(animated: true)
    }
    
    /// 2.注册
    func signup() {
        /// 1.获取登录信息
        let userinfo: (String, String, String) = signUpContentView.signup_info
        /// 2.注册
        let nickname: String = userinfo.0
        let email: String = userinfo.1
        let password: String = userinfo.2
        
        let signup_user: UserInfoModel = UserInfoModel(nickname: nickname, _password: password, _email: email, is_login: true)
        UserInfoHandle.share.insert(userInfo: signup_user)
        
        MBProgressHUD.showMessage("注册成功", to: view)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
