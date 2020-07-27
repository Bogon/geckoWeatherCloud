//
//  SettingViewModel.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import ObjectMapper

final class SettingViewModel {
    
    // 表格数据序列
    var tableData = BehaviorRelay<[SettingListSection]>(value: [])
    
    private var _disposeBag: DisposeBag?
    private var _networkService: SettingNetworkService?
    
    // ViewModel初始化（根据输入实现对应的输出）
    init(dependency: (
         disposeBag: DisposeBag,
         networkService: SettingNetworkService)) {
        
        _disposeBag = dependency.disposeBag
        _networkService = dependency.networkService
        
        // 设置数据
        let settingData = dependency.networkService.settingInfo()
        // 获取设置数据
        settingData.subscribe(onNext: { (items) in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
    }
    
    // 更新setting 数据
    func reload() {
        // 设置数据
        let settingData = _networkService?.reload()
        // 获取设置数据
        settingData!.subscribe(onNext: { (items) in
            self.tableData.accept(items)
        }).disposed(by: _disposeBag!)
    }
}

class SettingNetworkService {
        
    func settingInfo() -> Observable<[SettingListSection]> {

        let setting_value: [[String: Any]] = [
                                                ["type": SettingType.look, "is_refresh": false],
                                                ["type": SettingType.jion, "is_refresh": false],
                                                ["type": SettingType.colleciton, "is_refresh": false],
                                                ["type": SettingType.protocols, "is_refresh": false],
                                                ["type": SettingType.version, "is_refresh": false],
                                                ["type": SettingType.clear, "is_refresh": false]]
        
        let response: [SettingItemInfoModel] = setting_value.map { (value) -> SettingItemInfoModel in
            return SettingItemInfoModel.init(JSON: value)!
        }
        
        return Observable.just([SettingListSection.init(items: response)])
                    
    }
    
    func reload() -> Observable<[SettingListSection]> {

           let setting_value: [[String: Any]] = [
                                                   ["type": SettingType.look, "is_refresh": false],
                                                   ["type": SettingType.jion, "is_refresh": false],
                                                   ["type": SettingType.colleciton, "is_refresh": false],
                                                   ["type": SettingType.protocols, "is_refresh": false],
                                                   ["type": SettingType.version, "is_refresh": false],
                                                   ["type": SettingType.clear, "is_refresh": true]]
           
           let response: [SettingItemInfoModel] = setting_value.map { (value) -> SettingItemInfoModel in
               return SettingItemInfoModel.init(JSON: value)!
           }
           
           return Observable.just([SettingListSection.init(items: response)])
                       
       }
}

