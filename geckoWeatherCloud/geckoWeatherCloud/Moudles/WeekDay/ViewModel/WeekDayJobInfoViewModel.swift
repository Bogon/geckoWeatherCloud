//
//  WeekDayJobInfoViewModel.swift
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

final class WeekDayJobInfoViewModel {
    
    // 表格数据序列
    var tableData = BehaviorRelay<[HotJobListSection]>(value: [])
     
    // 停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>
    
    // 停止尾部刷新状态
    let endFooterRefreshing: Driver<Bool>
    
    // ViewModel初始化（根据输入实现对应的输出）
    init(input: (
         headerRefresh: Driver<Void>,
         footerRefresh: Driver<Void> ),
         dependency: (
         disposeBag: DisposeBag,
         networkService: WeekDayJobNetworkService)) {
        
        // 下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(()) //初始化时会先自动加载一次数据
            .flatMapLatest{  //也可考虑使用flatMapFirst
                return dependency.networkService.hotJobInfo()
            }
        
        // 上拉结果序列
        let footerRefreshData = input.footerRefresh
            .flatMapLatest{  //也可考虑使用flatMapFirst
                return dependency.networkService.nextPage()
            }
        
        // 生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        
        // 生成停止尾部刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { items in
            self.tableData.accept(self.tableData.value + items)
        }).disposed(by: dependency.disposeBag)
        
    }
}

class WeekDayJobNetworkService {
     
    private var page: Int = 1

    private let provider:MoyaProvider = MoyaProvider<HotJobInfoAPI>.init(endpointClosure: MoyaProvider<HotJobInfoAPI>.defaultEndpointMapping, requestClosure: MoyaProvider<HotJobInfoAPI>.defaultRequestMapping, stubClosure: MoyaProvider<HotJobInfoAPI>.neverStub, callbackQueue: nil, session:  MoyaProvider<HotJobInfoAPI>.defaultAlamofireSession(), plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)
    
    func hotJobInfo() -> Driver<[HotJobListSection]> {
        page = 1
        let params: [String: Any] = ["recType": 2,
                                     "catename": "jianzhi",
                                     "pagesize": 15,
                                     "localname": "sh",
                                     "format": "json",
                                     "page": page,
                                     "isBigPage": 1]
        return provider.requestJson(.hotJobInfo(value: params), isCache: true)
            .mapObject(type:HotJobInfoResponseModel.self).flatMap({ (response) -> Observable<[HotJobListSection]> in
                let jobInfoList: [HotJobItemInfoModel] = (response.result?.jobInfoList!)!
                return Observable.just([HotJobListSection.init(items: jobInfoList)])
            }).asDriver(onErrorDriveWith: Driver.empty())
                    
    }
    
    //MARK: - 获取下一页热门兼职的信息
    /// 热门兼职信息列表-下一页
    ///
    /// - Parameter value: 无
    /// - Returns:  热门兼职信息
    func nextPage() -> Driver<[HotJobListSection]> {
        
        page += 1
        let params: [String: Any] = ["recType": 2,
                                     "catename": "jianzhi",
                                     "pagesize": 15,
                                     "localname": "sh",
                                     "format": "json",
                                     "page": page,
                                     "isBigPage": 1]
        return provider.requestJson(.hotJobInfo(value: params), isCache: true)
                    .mapObject(type:HotJobInfoResponseModel.self).flatMap({ (response) -> Observable<[HotJobListSection]> in
                        let jobInfoList: [HotJobItemInfoModel] = (response.result?.jobInfoList!)!
                        return Observable.just([HotJobListSection.init(items: jobInfoList)])
                    }).asDriver(onErrorDriveWith: Driver.empty())
    }
}
