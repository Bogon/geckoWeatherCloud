//
//  WeatherInfoViewModel.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import PromiseKit
import Moya
import ObjectMapper

final class WeatherInfoViewModel {
    
    private let bag = DisposeBag()
    
    private let disposeBag = DisposeBag()
    private let provider:MoyaProvider = MoyaProvider<RealTimeWeatherInfoAPI>.init(endpointClosure: MoyaProvider<RealTimeWeatherInfoAPI>.defaultEndpointMapping, requestClosure: MoyaProvider<RealTimeWeatherInfoAPI>.defaultRequestMapping, stubClosure: MoyaProvider<RealTimeWeatherInfoAPI>.neverStub, callbackQueue: nil, session:  MoyaProvider<RealTimeWeatherInfoAPI>.defaultAlamofireSession(), plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)
    
    
    /// 保存天气数据
    var response: CityWeatherInfoResponseModel? = nil
    private weak var controller: RealTimeForcastController?
    
    //MARK: -  统一的业务跳转逻辑
    /// 控制器和ViewModel实现数据绑定
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns: 无返回值
    func binding(controller value: RealTimeForcastController, bindingType: RealTimeBindingType) {
        if controller == nil {
            controller = value
        }
        
        switch bindingType {
            case .RealTime:
                bindingRealTime(WithParameters: controller!.paramaters, view: controller!.realTimeWeaInfoV)
            case .Hourly:
                bindingHourly(target: controller!.hourlyWeatherInfoV)
            case .Tomorrow:
                bindingTomorrow(target: controller!.tomorrowWeatherInfoV)
//            case .SenvenDay:
//                controller?.hourlyToolBar.htb_next_button.rx.tap.subscribe(onNext: { [weak self] in
//                    self?.bindingSenvenDay(target: (self?.controller!.hourlyToolBar)! )
//                }).disposed(by: disposeBag)
        }

    }
    
    //MARK: - 明日小时级别天气业务处理
    /// 明日小时级别天气变化绑定
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns: 无返回值
    private func bindingTomorrow(target view: TomorrowWeatherInfoView) {
        guard let infoModel = response else {
            weatherInfo(WithParameters: controller!.paramaters, isCache: true).done { [weak self] (response) in
                self?.bindingTomorrowTo(response, view: view)
            }.catch { (error) in
                print(error)
            }
            return
        }
        
        bindingTomorrowTo(infoModel, view: view)
    }
    
    /// 明日时级别天气数据绑定
    ///
    /// - Parameter value: 绑定的数据
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns:  APP首页全部数据Model
    private func bindingTomorrowTo(_ value: CityWeatherInfoResponseModel, view: TomorrowWeatherInfoView) {
        
        /// 将数据单向绑定到view上
        let hourList: [HourWeatherTimeModel]? =  value.senventyTwoInfoModel?.getSeventyTwoHourlyInfoList(WithSeventyTwo: .tomorrow, realTimeModel: nil)
        view.addTomorrowItemList(hourList)
        
        view.layoutIfNeeded()

    }
    
    //MARK: - 小时级别天气业务处理
    /// 小时级别天气变化绑定
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns: 无返回值
    private func bindingHourly(target view: HourlyWeatherInfoView) {
        guard let infoModel = response else {
            weatherInfo(WithParameters: controller!.paramaters, isCache: true).done { [weak self] (response) in
                self?.bindingHourlyTo(response, view: view)
            }.catch { (error) in
                print(error)
            }
            return
        }
        
        bindingHourlyTo(infoModel, view: view)
    }
    
    /// 时级别天气数据绑定
    ///
    /// - Parameter value: 绑定的数据
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns:  APP首页全部数据Model
    private func bindingHourlyTo(_ value: CityWeatherInfoResponseModel, view: HourlyWeatherInfoView) {
        
        /// 将数据单向绑定到view上
        let hourList: [HourWeatherTimeModel]? =  (value.senventyTwoInfoModel?.getSomeDayHourlyInfoList(WithSomeDay: .today))
        view.addHourItemList(hourList)
        
        view.layoutIfNeeded()

    }
    
    //MARK: - 未来七天天气业务处理
    /// 未来七天天气变化绑定
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns: 无返回值
    private func bindingSenvenDay(target view: HourlyWeatherToolBar) {
        guard let infoModel = response else {
            weatherInfo(WithParameters: controller!.paramaters, isCache: true).done { [weak self] (response) in
                self?.bindingSenvenDayTo(response)
            }.catch { (error) in
                print(error)
            }
            return
        }
        
        bindingSenvenDayTo(infoModel)
    }
    
    /// 未来七天页面逻辑绑定
    private func bindingSenvenDayTo(_ value: CityWeatherInfoResponseModel) {
        /// 跳转到未来七天的页面
        controller?.navigationController?.pushViewController(SevenDayWeatherInfoController(value: response), animated: true)
    }
    
    //MARK: - 实时天气业务处理
    /// 实时天气页面与请求的网络数据绑定
    ///
    /// - Parameter value: 必填字段：areaCode
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns: 无返回值
    private func bindingRealTime(WithParameters value: [String: Any], view: RealTimeWeatherInfoView) {
        weatherInfo(WithParameters: value, isCache: true).done { [weak self] (response) in
            self?.bindingRealTimeTo(WithData: response, view: view)
        }.catch { (error) in
            print(error)
        }
    }
    
    /// 实时天气页面与请求的网络数据绑定
    ///
    /// - Parameter value: 绑定的数据
    /// - Parameter view: 需要绑定的视图对象
    /// - Returns:  APP首页全部数据Model
    private func bindingRealTimeTo(WithData value: CityWeatherInfoResponseModel, view: RealTimeWeatherInfoView) {
        /// 实时天气
        guard let infoModel = value.realTimeInfoModel else { return }
        
        /// 将数据单向绑定到view上
        view.weatherImage.image = UIImage.init(named: "\(infoModel.skycon!)-C")
        let weatherDescp: String = Skycon2WeatherDescription.shared.weatherDescription(infoModel.skycon!)
        let dateStr: String = Date().dateConvertString("MM月dd日")
        view.real_weather_detail_label.text = "\(weatherDescp), \(dateStr)"
        view.real_temparature_label.text = "\(Int(infoModel.temperature!))"
        view.lblTitle?.text = "\(infoModel.remindContent!)"
        let sunset: String = infoModel.sunsetValue
        view.real_feel_sunset_label.text = "体感: \(Int(infoModel.apparent_temperature!))℃，日落时间: \(sunset)"
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
