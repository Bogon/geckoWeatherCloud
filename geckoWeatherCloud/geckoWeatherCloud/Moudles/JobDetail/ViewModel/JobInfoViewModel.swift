//
//  JobInfoViewModel.swift
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

final class JobInfoViewModel {
    
    // 表格数据序列
    var tableData = BehaviorRelay<[HotJobDetailListSection]>(value: [])
     
    // 停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>
    
    // ViewModel初始化（根据输入实现对应的输出）
    init(headerRefresh: Driver<Void>,
         dependency: (
         disposeBag: DisposeBag,
         networkService: JobNetworkService)) {
        
        // 下拉结果序列
        let headerRefreshData = headerRefresh
            .startWith(()) //初始化时会先自动加载一次数据
            .flatMapLatest{  //也可考虑使用flatMapFirst
                return dependency.networkService.jobInfo()
            }
        
        
        // 生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        
        
        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)

        
    }
}

class JobNetworkService {

    private let provider:MoyaProvider = MoyaProvider<JobInfoAPI>.init(
        endpointClosure: MoyaProvider<JobInfoAPI>.defaultEndpointMapping,
        requestClosure: MoyaProvider<JobInfoAPI>.defaultRequestMapping,
        stubClosure: MoyaProvider<JobInfoAPI>.neverStub,
        callbackQueue: nil,
        session:  MoyaProvider<JobInfoAPI>.defaultAlamofireSession(),
        plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)
    
    private var url: String = ""
    
    init(url value: String) {
        url = value
    }
    
    func jobInfo() -> Driver<[HotJobDetailListSection]> {

        let params: [String: Any] = ["format": "json",
                                     "platform": "ios",
                                     "localname": "sh",
                                     "version": "10.1.1",]
        return provider.requestJson(.jobInfo(url: url, value: params), isCache: true)
            .mapObject(type:JobDetailResponseModel.self)
            .flatMap({ (response) -> Observable<[HotJobDetailListSection]> in
                return Observable.just([HotJobDetailListSection.init(items: [response])])
            }).asDriver(onErrorDriveWith: Driver.empty())
                    
    }
}
