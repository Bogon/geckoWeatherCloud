//
//  ValidationService.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

struct ValidationService: ValidationServiceProcotol {
    
    private let minCharactersCount = 8
    
    //MARK: - 验证昵称是否有效
    /// 验证昵称是否有效
    ///
    /// - Parameter value: 昵称，必填字段
    /// - Returns: ValidateResult：是否有效
    func validateNickname(nickname value: String) -> ValidateResult {
        if value.count == 0 {
            return .empty
        }
        
        if value.count < 5 {
            return .failed(message: "昵称至少需要5位…")
        }
        
        return .success(message: "")
    }
    
    //MARK: - 验证邮箱是否有效
    /// 验证昵称是否有效
    ///
    /// - Parameter value: 邮箱，必填字段
    /// - Returns: ValidateResult：是否有效
    func validateEmail(email value: String) -> ValidateResult {
        if value.count == 0 {
            return .empty
        }
        
        let is_validate:Bool = validateEmail(email: value)
        if !is_validate {
            return .failed(message: "邮箱不合法…")
        }
        
        return .success(message: "")
    }
    
    func validatePassword(password value: String) -> ValidateResult {
        if value.count == 0 {
            return .empty
        }
        
        if value.count < minCharactersCount {
            return .failed(message: "密码至少需要八位…")
        }
        
        return .success(message: "")
    }
    
    
    //MARK: - 验证邮箱正则表达式
    /// 验证邮箱正则表达式
    ///
    /// - Parameter value: email，必填字段
    /// - Returns: Bool：是否有效
    private func validateEmail(email value: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: value)
    }
    
    
}
