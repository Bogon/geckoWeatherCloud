//
//  LoginViewModel.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {
    
    //output:
    let emailUsable: Driver<ValidateResult>
    let passwordUsable: Driver<ValidateResult>
    let loginButtonEnabled: Driver<Bool>
    
    init(input: (email: Driver<String>, password: Driver<String>),
         validationService: ValidationService) {

        /// 验证邮箱是否可用
        emailUsable = input.email
            .map{ email in
                return validationService.validateEmail(email: email)
        }
        
        /// 密码是否可用
        passwordUsable = input.password
            .map { password in
                return validationService.validatePassword(password: password)
        }
        
        /// 登录按钮是否可用
        loginButtonEnabled = Driver.combineLatest(emailUsable, passwordUsable){ username, password in
                username.isValid && password.isValid
            }.distinctUntilChanged()
        
    }
}
