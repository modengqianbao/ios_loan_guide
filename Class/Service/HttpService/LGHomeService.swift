//
//  HomeService.swift
//  LoanGuide
//
//  Created by 喂草。 on 02/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class LGHomeService {
    static let sharedService = LGHomeService()
    
    private let service = LGHttpService.sharedService
    
    private init () {}
    
    /// 贷款产品推荐
    func getLoanGroom(count: Int, page: Int, complete:@escaping (_ data: [LGLoanProductModel]?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("loan_groom")
        let parameters = ["count": count,
                          "page": page]
        service.post(urlString: urlString, parameters: parameters) { (json, error) in
            if error == nil {
                let jsonArray = json!["data"]["loans"].arrayValue
                var array = [LGLoanProductModel]()
                for jsonItem in jsonArray {
                    let item = LGLoanProductModel(json: jsonItem)
                    array.append(item)
                }
                complete(array, nil)
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 信用卡产品推荐
    func getCreditGroom(count: Int, page: Int, complete:@escaping (_ data: [LGCreditProductModel]?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("credit_groom1")
        let parameters = ["count": count,
                          "page": page]
        service.post(urlString: urlString, parameters: parameters) { (json, error) in
            if error == nil {
                let jsonArray = json!["data"]["credits"].arrayValue
                var array = [LGCreditProductModel]()
                for jsonItem in jsonArray {
                    let item = LGCreditProductModel(json: jsonItem)
                    array.append(item)
                }
                complete(array, nil)
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 获取首页banner
    func getHomeBanner(complete: @escaping (_ array: [LGHomeBannerModel]?,_ error: String?) -> Void) {
        let urlString = kDomain.appending("home_page")
        service.post(urlString: urlString, parameters: nil) { json, error in
            if error == nil {
                let jsonArray = json!["data"]["productList"].arrayValue
                var array = [LGHomeBannerModel]()
                for jsonItem in jsonArray {
                    let item = LGHomeBannerModel(json: jsonItem)
                    array.append(item)
                }
                complete(array, nil)
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 获取本地首页缓存贷款数据
    func loadHomeLoanArray() -> [LGLoanProductModel] {
        let realm = try! Realm()
        let loanDatabaseArray = realm.objects(LGLoanProductDatabaseModel.self).filter("isForHome == true")
        var loanArray = [LGLoanProductModel]()
        for databaseItem in loanDatabaseArray {
            let item = LGLoanProductModel(databaseModel: databaseItem)
            loanArray.append(item)
        }
        
        return loanArray
    }
    
    /// 获取本地首页缓存banner
    func loadHomeBannerArray() -> [LGHomeBannerModel] {
        let realm = try! Realm()
        let bannerDatabaseArray = realm.objects(LGBannerDatabaseModel.self)
        var bannerArray = [LGHomeBannerModel]()
        for databaseItem in bannerDatabaseArray {
            let item = LGHomeBannerModel(databaseModel: databaseItem)
            bannerArray.append(item)
        }
        
        return bannerArray
    }
    
    /// 获取本地首页缓存信用卡
    func loadHomeCreditArray() -> [LGCreditProductModel] {
        let realm = try! Realm()
        let creditDatabaseArray = realm.objects(LGCreditProductDatabaseModel.self).filter("isForHome == true")
        var creditArray = [LGCreditProductModel]()
        for databaseItem in creditDatabaseArray {
            let item = LGCreditProductModel(databaseModel: databaseItem)
            creditArray.append(item)
        }
        
        return creditArray
    }
    
    /// 保存首页缓存贷款数据
    func saveHomeLoanArray(array: [LGLoanProductModel]) {
        let realm = try! Realm()
        let loanDatabaseArray = realm.objects(LGLoanProductDatabaseModel.self).filter("isForHome == true")
        if loanDatabaseArray.count > 0 {
            try! realm.write {
                realm.delete(loanDatabaseArray)
            }
        }
        
        for item in array {
            let databaseItem = LGLoanProductDatabaseModel()
            databaseItem.setup(isForHome: true, model: item)
        
            try! realm.write {
                realm.add(databaseItem)
            }
        }
    }
    
    /// 保存首页缓存信用卡数据
    func saveHomeCreditArray(array: [LGCreditProductModel]) {
        let realm = try! Realm()
        let creditDatabaseArray = realm.objects(LGCreditProductDatabaseModel.self).filter("isForHome == true")
        if creditDatabaseArray.count > 0 {
            try! realm.write {
                realm.delete(creditDatabaseArray)
            }
        }
        
        for item in array {
            let databaseItem = LGCreditProductDatabaseModel()
            databaseItem.setup(isForHome: true, model: item)
            
            try! realm.write {
                realm.add(databaseItem)
            }
        }
    }
    
    /// 保存首页缓存banner
    func saveHomeBannerArray(array: [LGHomeBannerModel]) {
        let realm = try! Realm()
        let bannerDatabaseArray = realm.objects(LGBannerDatabaseModel.self)
        if bannerDatabaseArray.count > 0 {
            try! realm.write {
                realm.delete(bannerDatabaseArray)
            }
        }
        
        for item in array {
            let databaseItem = LGBannerDatabaseModel()
            databaseItem.setup(model: item)
            
            try! realm.write {
                realm.add(databaseItem)
            }
        }
    }
}
