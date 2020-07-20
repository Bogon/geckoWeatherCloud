//
//  SevenDayWeatherViewModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/26.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import PromiseKit
import Moya
import ObjectMapper


enum SevenDayeBindingType: Int {
    case TomorrowHeader
    case TomorrowList
}

extension SevenDayeBindingType {}

final class SevenDayWeatherViewModel {
    
//    internal static let shared = SevenDayWeatherViewModel()
//    private init() {}
    
    private let bag = DisposeBag()
    
    private let disposeBag = DisposeBag()
    private let provider:MoyaProvider = MoyaProvider<RealTimeWeatherInfoAPI>.init(endpointClosure: MoyaProvider<RealTimeWeatherInfoAPI>.defaultEndpointMapping, requestClosure: MoyaProvider<RealTimeWeatherInfoAPI>.defaultRequestMapping, stubClosure: MoyaProvider<RealTimeWeatherInfoAPI>.neverStub, callbackQueue: nil, session:  MoyaProvider<RealTimeWeatherInfoAPI>.defaultAlamofireSession(), plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)
    
    /// 保存天气数据
    private var response: CityWeatherInfoResponseModel? = nil
    private weak var controller: SevenDayWeatherInfoController?
    
    //MARK: -  统一的业务跳转逻辑
    /// 控制器和ViewModel实现数据绑定
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns: 无返回值
    func binding(controller value: SevenDayWeatherInfoController, bindingType: SevenDayeBindingType) {
        controller = value
        
        switch bindingType {
            case .TomorrowHeader:
                bindingHeader(target: controller!.tomorrowListHeader.tomorrowDetailWeatherV)
            case .TomorrowList:
                bindingList()
            
        }

    }
    
    //MARK: - 明日天气业务处理
    /// 明日天气表单数据绑定
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns: 无返回值
    private func bindingList() {
        guard let infoModel = response else {
            weatherInfo(WithParameters: controller!.paramaters, isCache: true).done { [weak self] (response) in
                self?.bindingListTo(response)
            }.catch { (error) in
                print(error)
            }
            return
        }
        
        bindingListTo(infoModel)
    }
    
    /// 明日天气数据表单绑定
    ///
    /// - Parameter value: 绑定的数据
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns:  APP首页全部数据Model
    private func bindingListTo(_ value: CityWeatherInfoResponseModel) {
        
        /// 将数据单向绑定到view上
        let senvenDayListValue: ([DayWeatherInfoModel], CGFloat, CGFloat) = value.fifteenInfoModel!.getSenvenDayWeatherInfo()
        let senvenDayList: [DayWeatherInfoModel] = senvenDayListValue.0
        let min: CGFloat = senvenDayListValue.1
        let max: CGFloat = senvenDayListValue.2
        
        let senvenDayListObservable = Observable.just(senvenDayList)
        senvenDayListObservable.bind(to: controller!.contentTableView.rx.items(cellIdentifier: "DayDetailWeatherTableCell", cellType: DayDetailWeatherTableCell.self)) { (row, element, cell) in
            cell.week = element.dateStr ?? "周？"
            cell.AQI = element.weatherQualityStr ?? "优"
            cell.skycon = element.skycon ?? "UNKONWN"
            cell.max_current = element.currentMax ?? 0
            cell.min_current = element.currentMin ?? 0
            cell.min = min
            cell.max = max
            
        }.disposed(by: bag)
        
        controller!.contentTableView.rx.itemSelected.bind { [weak self] indexPath in
            self?.controller!.contentTableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: bag)
        
        controller!.contentTableView.rx.setDelegate(controller!).disposed(by: bag)
    }
    
    //MARK: - 明日天气业务处理
    /// 明日天气数据绑定
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns: 无返回值
    private func bindingHeader(target view: TomorrowDetailWeatherView) {
        guard let infoModel = response else {
            weatherInfo(WithParameters: controller!.paramaters, isCache: true).done { [weak self] (response) in
                self?.bindingHeaderTo(response, view: view)
            }.catch { (error) in
                print(error)
            }
            return
        }
        
        bindingHeaderTo(infoModel, view: view)
    }
    
    /// 明日天气数据绑定
    ///
    /// - Parameter value: 绑定的数据
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns:  APP首页全部数据Model
    private func bindingHeaderTo(_ value: CityWeatherInfoResponseModel, view: TomorrowDetailWeatherView) {
        
        /// 将数据单向绑定到view上
        let tomorrowValue: DayWeatherInfoModel = (value.fifteenInfoModel?.getSomeDayWeatherInfo(WithSomeDay: .tomorrow, realTimeModel: nil))!
        
        view.skycon = tomorrowValue.skycon!
        view.week = tomorrowValue.dateStr!
        view.maxTemparaature = tomorrowValue.currentMax!
        view.minTemparaature = tomorrowValue.currentMin!
        
        view.windSpeed = tomorrowValue.wind!
        view.humidity = tomorrowValue.humidity!
        view.visibility = tomorrowValue.ultraviolet!
        view.AQI = tomorrowValue.weatherQualityStr!
        

        view.layoutIfNeeded()

    }
    
    //MARK: - 当前页面网络数据获取接口
    /// APP首页需要的全部数据接口
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Returns:  APP首页全部数据Model
    private func weatherInfo(WithParameters value: [String: Any], isCache: Bool) -> Promise<CityWeatherInfoResponseModel> {
        return Promise { seal in
            provider.requestJson(.weatherInfo(value: value), isCache: isCache)
                    .mapObject(type:CityWeatherInfoResponseModel.self)
                    .subscribe(onNext: { [weak self] model in
                        self?.response = model  /// 保存数据
                        seal.fulfill(model)
                    }, onError: {
                        seal.reject($0)
                    }).disposed(by: disposeBag)
        }
    }
}
