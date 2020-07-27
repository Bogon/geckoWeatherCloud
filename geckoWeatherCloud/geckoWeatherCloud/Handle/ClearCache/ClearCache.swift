//
//  ClearCache.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

struct ClearCache {
    
    
    
    internal static let share = ClearCache()
    private init() {}
    
    // 计算属性：计算缓存大小
    var cacheSize: String {
        
        // 取出cache文件夹路径
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let files = FileManager.default.subpaths(atPath: cachePath!)
        
        // 用于统计文件夹内所有文件大小
        var big = Int();
        
        // 快速枚举取出所有文件名
        for p in files!{
            // 把文件名拼接到路径中
            let path = cachePath!.appendingFormat("/\(p)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc,bcd) in floder {
                // 只去出文件大小进行拼接
                if abc == FileAttributeKey.size{
                    big += (bcd as AnyObject).integerValue
                }
            }
        }
        
        let memory: Double = big != 0 ? (Double(big)/(1024.0*1024.0)).roundTo(places: 1) : Double(0).roundTo(places: 0)
        return "\(memory)M"
    }
    
    // 清除缓存
    func clear() {
        // 取出cache文件夹路径
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let files = FileManager.default.subpaths(atPath: cachePath!)
        
        // 点击确定时开始删除
        for p in files!{
            // 拼接路径
            let path = cachePath!.appendingFormat("/\(p)")
            // 判断是否可以删除
            if(FileManager.default.fileExists(atPath: path)){
                // 删除
                try! FileManager.default.removeItem(atPath: path)
            }
        }
    }
    
}
