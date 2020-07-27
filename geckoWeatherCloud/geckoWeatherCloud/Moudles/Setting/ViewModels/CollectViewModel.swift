//
//  CollectViewModel.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import ObjectMapper
import RxCocoa
import RxSwift

final class CollectViewModel {
    
    // 表格数据序列
    var tableData = BehaviorRelay<[HotJobListSection]>(value: [])
    
    // ViewModel初始化（根据输入实现对应的输出）
    init(storeJobType value: StoreJobType, dependency: (
         disposeBag: DisposeBag,
         networkService: CollectNetworkService)) {
        
        // 设置数据
        let settingData = dependency.networkService.settingInfo(storeJobType: value)
        // 获取设置数据
        settingData.subscribe(onNext: { (items) in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
    }
}

class CollectNetworkService {
        
    func settingInfo(storeJobType value: StoreJobType) -> Observable<[HotJobListSection]> {
        
        let response: [HotJobItemInfoModel] = JobInfoHandle.share.selecteJobList(storeJobType: value)
        return Observable.just([HotJobListSection.init(items: response)])
                    
    }
    
}
