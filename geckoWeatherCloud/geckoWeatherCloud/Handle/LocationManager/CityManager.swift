//
//  CityManager.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import Foundation

struct CityManager {
    
    /// 创建操作城市数据库单例
    static let share: CityManager = CityManager()
    
    private init() {}
    
    //所有地区model
    var allDistrictModel: [CityModel] = [CityModel]()
    
    /// 根据areaCode获取当前的城市数据模型
    func getCityInfoByAreaCode(WithAreaCode areaCode: String) -> CityModel? {
        let globalHelper = CityModel.getUsingLKDBHelper()
        /// 获取关注城市
        let selectedsql: String = "select * from CityModel where area_code='\(areaCode)'"
        let selectedList: [CityModel] = globalHelper.search(withSQL: selectedsql, to: CityModel.self) as! [CityModel]
        return selectedList.first
        
    }
    
    /// 查询所有城市的信息
    func getAllCityModel() -> [CityModel]? {
        /// 进行中的题目
        let globalHelper = CityModel.getUsingLKDBHelper()
        let sql: String = "select * from CityModel"
        let allCityModelList: [CityModel] = globalHelper.search(withSQL: sql, to: CityModel.self) as! [CityModel]
        return allCityModelList
    }
    
    /** 获取定位城市和已添加收藏城市 */
    func getCollecitonCityList() -> [CityModel]? {
        let globalHelper = CityModel.getUsingLKDBHelper()
        /** 数据中包含顺序：定位城市、默认北京，推荐城市*/
        var recommendCityList: [CityModel] = [CityModel]()
        /// 获取定位城市
        let positioningsql: String = "select * from CityModel where isPositioning=1"
        let positioningList: [CityModel] = globalHelper.search(withSQL: positioningsql, to: CityModel.self) as! [CityModel]
        /// 获取关注城市
        let selectedsql: String = "select * from CityModel where isSelected=1"
        let selectedList: [CityModel] = globalHelper.search(withSQL: selectedsql, to: CityModel.self) as! [CityModel]
        //关注城市排序
        let resultArray = selectedList.sorted {$0.selectedTimeScamp > $1.selectedTimeScamp}
        
        recommendCityList = positioningList + resultArray
        var array: [CityModel] = []
        var indexArray: [Int] = []
        //关注城市和定位城市可能重复，需要去重
        for (_, model) in recommendCityList.enumerated() {
            if !indexArray.contains(model.id) {
                indexArray.append(model.id)
                array.append(model)
            }
        }
        return array
    }
    
    /** 获取搜索页面所有的推荐城市数据 */
    func getRecommendCityList() -> [CityModel]? {
        let globalHelper = CityModel.getUsingLKDBHelper()
        /** 数据中包含顺序：定位城市，推荐城市*/
        var recommendCityList: [CityModel] = [CityModel]()
        
        /// 获取定位城市
        let positioningsql: String = "select * from CityModel where isPositioning=1;"
        let positioningList: [CityModel] = globalHelper.search(withSQL: positioningsql, to: CityModel.self) as! [CityModel]
        
        /// 获取推荐城市
        let recommendsql: String = "select * from CityModel where isRecommend=1;"
        let recommendList: [CityModel] = globalHelper.search(withSQL: recommendsql, to: CityModel.self) as! [CityModel]
        recommendCityList = positioningList + recommendList
        return recommendCityList
    }
    
    /** 添加关注城市 */
    func addCity(_ cityId: Int) -> Bool {
        let globalHelper = CityModel.getUsingLKDBHelper()
        //获取添加的时间戳
        let timeScamp = Int(Date().timeIntervalSince1970)
        return globalHelper.update(toDB: CityModel.self, set: "isSelected=1, selectedTimeScamp=\(timeScamp)", where: "id=\(cityId)")
    }
    
    /** 删除关注城市 */
    func deleteCity(_ cityId: Int) -> Bool {
        let globalHelper = CityModel.getUsingLKDBHelper()

        return globalHelper.update(toDB: CityModel.self, set: "isSelected=0", where: "id=\(cityId)")
    }
    
    /** 设置默认城市 */
    func addDefaultCity(_ city: String) -> Bool {
        let globalHelper = CityModel.getUsingLKDBHelper()
        /// 获取默认城市
        let defaultsql: String = "select * from XNWeatherCityModel where isDefalut=1"
        let defaultList: [CityModel] = globalHelper.search(withSQL: defaultsql, to: CityModel.self) as! [CityModel]
        /// 修改当前默认城市不可用
        let previousCity: CityModel = defaultList.first!
        globalHelper.update(toDB: CityModel.self, set: "isDefalut=0", where: "district= \"\(previousCity.district!)\"")
        /// 设置城市已选中
        /// let selectedsql: String = "update XNWeatherCityModel set isSelected=true where district= \"\(city)\""
        return globalHelper.update(toDB: CityModel.self, set: "isDefalut=1", where: "district= \"\(city)\"")
    }
    
    
    /** 更新定位城市 */
    func updateLocationCity(_ province: String, district: String, higherCity: String, latitude: Double, longitude: Double) {
        
        let globalHelper = CityModel.getUsingLKDBHelper()
        /// 获取定位城市
        let positioningsql: String = "select * from CityModel where isPositioning=1"
        let positioningList: [CityModel] = globalHelper.search(withSQL: positioningsql, to: CityModel.self) as! [CityModel]
        /// 修改当前定位城市不可用
        let previousCity = positioningList.first
        if positioningList.count == 0 {
            //无定位城市
        } else {
            //有定位城市,先将其isPositioning=0,并且更新对应的坐标
            globalHelper.update(toDB: CityModel.self, set: "isPositioning=0", where: "district= \"\(previousCity!.district!)\"")
        }
        
        //因为高德返回的disrict可能与数据库中存在误差,所以先模糊匹配找出对应的城市,再更新
        let resultArray = CityManager.share.getAllCityModel()!.filter { (model) -> Bool in
            //拼接汉字和拼音,实现汉字拼音搜索
            return district.contains(model.district ?? "") && (higherCity.contains(model.city!) || province.contains(model.province!))
        }
        //如果匹配不上默认北京
        if resultArray.count == 0 {
            globalHelper.update(toDB: CityModel.self, set: "isPositioning=1", where: "district='北京'")
        } else {
            let id = resultArray.first?.id
            globalHelper.update(toDB: CityModel.self, set: "isPositioning=1, longitude='\(longitude)', latitude='\(latitude)'", where: "id=\(id ?? 10000)")
        }
    }
    
    /** 构造请求天气数据 */
    func getCityWeather(_ cityID: NSInteger) -> [String: Any] {
        let globalHelper = CityModel.getUsingLKDBHelper()
        /// 获取定位城市
        let positioningsql: String = "select * from CityModel where id=\"\(cityID)\""
        let positioningList: [CityModel] = globalHelper.search(withSQL: positioningsql, to: CityModel.self) as! [CityModel]
        /// 修改当前定位城市不可用
        let previousCity: CityModel = positioningList.first!
        if previousCity.isPositioning {
            return ["areaCode": previousCity.area_code!, "longitude": previousCity.longitude, "latitude": previousCity.latitude]
        } else {
            return ["areaCode": previousCity.area_code!]
        }
    }
    
    /** 构造请求天气数据: 默认城市优先 */
    func getDefaultCityInfo() -> [String: Any] {
        let globalHelper = CityModel.getUsingLKDBHelper()
        let positioningsqlDefalut: String = "select * from CityModel where isPositioning=1"
        let positioningListDefalut: [CityModel] = globalHelper.search(withSQL: positioningsqlDefalut, to: CityModel.self) as! [CityModel]
        /// 修改当前定位城市不可用
        guard let previousCity = positioningListDefalut.first else {
            return ["areaCode": "121010300"]
        }
        return previousCity.areaCode
    }
    
    /** 构造请求天气数据: 默认城市优先 */
    func locationCity() -> CityModel {
        let globalHelper = CityModel.getUsingLKDBHelper()
        /// 获取定位城市
        let positioningsql: String = "select * from CityModel where isPositioning=1"
        let positioningList: [CityModel] = globalHelper.search(withSQL: positioningsql, to: CityModel.self) as! [CityModel]
        /// 修改当前定位城市不可用
        let previousCity: CityModel = positioningList.first!
        return previousCity
    }
    
    /** 构造请求天气数据: 默认城市优先 */
    func getDefaultCityModel() -> CityModel {
        let globalHelper = CityModel.getUsingLKDBHelper()
        /// 获取定位城市
        let positioningsql: String = "select * from CityModel where district = '北京'"
        let positioningList: [CityModel] = globalHelper.search(withSQL: positioningsql, to: CityModel.self) as! [CityModel]
        /// 修改当前定位城市不可用
        let previousCity: CityModel = positioningList.first!
        return previousCity
    }
    
    /** 根据区县信息获取整个城市信息 */
    func getCityInfo(_ city: String) -> CityModel? {
        let globalHelper = CityModel.getUsingLKDBHelper()
        /// 获取定位城市
        let positioningsql: String = "select * from CityModel where district='\(city)'"
        let positioningList: [CityModel] = globalHelper.search(withSQL: positioningsql, to: CityModel.self) as! [CityModel]
        /// 修改当前定位城市不可用
        guard let previousCity = positioningList.first else {
            return nil
        }
        return previousCity
    }

    /** 更改城市数据在app中的位置 */
    func initCityData() {
        /// 沙盒文档路径
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let filePath: String = Bundle.main.path(forResource: "CityCloudDatabase", ofType: "db")!
        let targetPath: String = "\(kSandDocumentPath)/CityCloudDatabase.db"
        if !FileManager.default.fileExists(atPath: targetPath) {
            do{
                try FileManager.default.copyItem(atPath: filePath, toPath: targetPath)
            } catch {
                
            }
        }
    }
    
    //获取所有的国内省份
    func getAllChinaProvince(with type: Int) -> [String] {
        let globalHelper = CityModel.getUsingLKDBHelper()
        //获取省份这一列的数据
        let resultArray = globalHelper.search(CityModel.self, column: "province", where: "city_type=\(type)", orderBy: nil, offset: 0, count: 0) as! [String]
        //再去重
        var provinceArray : [String] = []
        for (_, item) in resultArray.enumerated() {
            if !provinceArray.contains(item) {
                provinceArray.append(item)
            }
        }
        return provinceArray
    }
    //根据上级城市查询市
    func getChildCityFormHigherCity(higherCityName: String) -> ([String], [CityModel]) {
        let globalHelper = CityModel.getUsingLKDBHelper()
        let sql = "select * from CityModel where province=\"\(higherCityName)\""
        let allModelList: [CityModel] = globalHelper.search(withSQL: sql, to: CityModel.self) as! [CityModel]
        var cityArray : [String] = []
        var cityModelArray: [CityModel] = []
        for (_, item) in allModelList.enumerated() {
            if !cityArray.contains(item.city ?? "") {
                cityArray.append(item.city!)
            }
            if !cityModelArray.contains(item) {
                cityModelArray.append(item)
            }
        }
        return (cityArray, cityModelArray)
    }
    //根据上级城市查询县
    func getChildDistrictFormHigherCity(higherCityName: String) -> [CityModel] {
        let globalHelper = CityModel.getUsingLKDBHelper()
        let sql = "select * from CityModel where city=\"\(higherCityName)\""
        let allModelList: [CityModel] = globalHelper.search(withSQL: sql, to: CityModel.self) as! [CityModel]
        return allModelList
    }
    
    // 根据省市区查询
    func getCityModelFrom(province : String, cityName : String, district : String) -> [CityModel] {
        let globalHelper = CityModel.getUsingLKDBHelper()
        var myProvince = province
        var myDistrict = district
        var myCity = cityName
        if province.contains("省") || province.contains("市") {
            myProvince = province.substring(to: province.count - 2)
        }
        if cityName.contains("市") {
            myCity = cityName.substring(to: province.count - 2)
        }
        if district.contains("区") {
            myDistrict = district.substring(to: province.count - 2)
        }
        
        let sql = "select * from CityModel where province= '\(myProvince)' and district = '\(myDistrict)' and city = '\(myCity)';"
        
        let resultModelArr = globalHelper.search(withSQL: sql, to: CityModel.self) as! [CityModel]
        return resultModelArr
    }
    
}
