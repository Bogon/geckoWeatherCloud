//
//  DatabaseInitlize.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

struct DatabaseInitlize {
    
    static internal let share = DatabaseInitlize()
    private init() {}
    
    //MARK: - 初始化数据库到用户沙盒路径
    /// 初始化数据库到用户沙盒路径
    ///
    /// - Returns: 无返回值
    func databaseInitlize() {
        /// 沙盒文档路径
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let filePath: String = Bundle.main.path(forResource: "CityCloudDatabase", ofType: "db")!
        let targetPath: String = "\(kSandDocumentPath)/CityCloudDatabase.db"
        
        print("用户信息数据路径：\(targetPath)")
        
        if !FileManager.default.fileExists(atPath: targetPath) {
            do{
                try FileManager.default.copyItem(atPath: filePath, toPath: targetPath)
            } catch {
                
            }
        }
    }
}
