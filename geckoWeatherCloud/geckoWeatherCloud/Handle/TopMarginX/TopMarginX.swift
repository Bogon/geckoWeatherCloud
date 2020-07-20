//
//  TopMarginX.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import DeviceKit

struct TopMarginX {
    
    static var topMargin: CGFloat {
        
        var margin: CGFloat = 64
        
        let device: Device = Device.current
        if device.isOneOf([Device.iPhoneX, Device.iPhoneXR, Device.iPhoneXS, Device.iPhoneXSMax, Device.iPhone11, Device.iPhone11Pro, Device.iPhone11ProMax]) {
             margin = 88
        } else if device.isOneOf([Device.simulator(Device.iPhoneX),Device.simulator(Device.iPhoneXR),Device.simulator(Device.iPhoneXR),Device.simulator(Device.iPhoneXSMax),Device.simulator(Device.iPhone11),Device.simulator(Device.iPhone11Pro),Device.simulator(Device.iPhone11ProMax)]){
              margin = 88
        }
        return margin
    }
}
