//
//  UIImage+Extention.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import DeviceKit

extension UIImage {

    /// 根据传入参数生成指定大小和颜色的图片
    ///
    /// - parameter color: 生成图片的颜色
    /// - parameter size: 生成图片的尺寸
    ///
    /// - returns: 一个UIImage实例.
    static func getImage(WithColor color: UIColor, size: CGSize) -> UIImage {
       
        let rect: CGRect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        // 开启位图上下文
        UIGraphicsBeginImageContext(rect.size)
        // 获取位图上下文
        let context: CGContext = UIGraphicsGetCurrentContext()!
        // 使用color演示填充上下文
        context.setFillColor(color.cgColor)
        // 渲染上下文
        context.fill(rect)
        // 从上下文中获取图片
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // 结束上下文
        UIGraphicsEndImageContext()
        
        return image
    }
}
