//
//  LocationManager.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//
import Foundation
import AMapLocationKit

/// 定位成功的回调
typealias locationCompleteHandle = (String, String, String, Double, Double) ->()
typealias locationErrorHandle = (Error) -> ()

final class LocationManager: NSObject {
    /// 高德SDK，APPKey
    fileprivate let AMapAppKey: String = "51c4f8b326516d67e3d784e9298e6a89"
    // 保存具体的道路定位信息
    fileprivate let storeLocationAddress: String = "kStoreLocationAddress"
    
    internal static let shared = LocationManager()
    private override init() {}

    var completeHandle : locationCompleteHandle!
    var errorHandle: locationErrorHandle!
    
    /** 定位对象 */
    var locationManager: AMapLocationManager? = AMapLocationManager()
    
    /** 定位初始化设置 */
    func configLocation() {
        /** 配置高德地图apikey */
        AMapServices.shared()?.apiKey = AMapAppKey
        /** 设置期望定位精度 */
        self.locationManager?.delegate = self
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager!.locationTimeout = 6
        self.locationManager!.reGeocodeTimeout = 6
    }
    
    /** 获取定位到的街道 */
    func getLocationStreet() -> String {
        /* 在UserDefault没有设置相应key的value情况下，有可能为空，强制取value会导致崩溃 */
        guard let strAddress = UserDefaults.standard.value(forKey: storeLocationAddress) as? String else { return "" }
        return strAddress;
    }
    
    /// 开启定位设置，开始定位
    ///
    /// - Parameter successHandler: 定位成功返回：province：省份, city：城市, district：区县； 定位失败返回默认城市：北京，北京，北京
    func locationComplete(withLocationCompleteHandle completeHandler : @escaping locationCompleteHandle, errorHandle: @escaping locationErrorHandle) {
        self.completeHandle = completeHandler
        self.errorHandle = errorHandle
        self.requestLocation()
        
    }

    func requestLocation() {
        self.locationManager!.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in

            /** 定位失败，默认城市北京 */
            var province: String = "北京"
            var city: String = "北京"
            var district: String = "北京"
            
            if error != nil {
                self!.errorHandle(error!)
                return
            }

            let lat = location?.coordinate.latitude.roundTo(places: 6)
            let lon = location?.coordinate.longitude.roundTo(places: 6)
            
            if let reGeocode = reGeocode {
                //let country: String = reGeocode.country         /// 国家
                guard let province1 = reGeocode.province else {
                    self!.completeHandle(province ,city ,district, lat ?? 0.000000, lon ?? 0.000000)
                    return
                }
                province = province1                /// 省份
                city = reGeocode.city               /// 城市
                district = reGeocode.district       /// 区县
                var streets: String = ""

                /// 优先展示定位展示的aoiName
                if (reGeocode.aoiName != nil) {
                    streets = reGeocode.aoiName
                } else {
                    /// aoiName不存在时，在使用poiName
                    if (reGeocode.poiName != nil) {
                        streets = reGeocode.poiName
                    } else {
                        /// poiName不存在时，在使用street
                        if (reGeocode.street != nil) {
                           streets = reGeocode.street
                        } else {
                            streets = ""
                        }
                        
                    }
                }
                
                UserDefaults.standard.set(streets, forKey: self!.storeLocationAddress)
                CityManager.share.updateLocationCity(province, district: city, higherCity: district, latitude: lat ?? 0.000000, longitude: lon ?? 0.000000)
                self!.completeHandle(province ,city, district, lat ?? 0.000000, lon ?? 0.000000)
            }
        })
    }
    
}

extension LocationManager: AMapLocationManagerDelegate {
    //定位信息更新时更新数据库
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        if let reGeocode = reGeocode {
            //let country: String = reGeocode.country         /// 国家
            let province = reGeocode.province       /// 省份
            let city = reGeocode.city               /// 城市
            let district = reGeocode.district       /// 区县
            let lat = location?.coordinate.latitude.roundTo(places: 6)
            let lon = location?.coordinate.longitude.roundTo(places: 6)
            CityManager.share.updateLocationCity(province ?? "", district: district ?? "", higherCity: city ?? "", latitude: lat ?? 0.000000, longitude: lon ?? 0.000000)

        }
    }
    
    //定位失败
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        
    }
    
    //解决iOS9以下不弹出定位权限的问题
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
}

