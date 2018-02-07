//
//  HomeService.swift
//  LoanGuide
//
//  Created by 喂草。 on 02/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON

class LGHomeService {
    static let sharedService = LGHomeService()
    
    private let service = LGHttpService.sharedService
    
    private init () {}
    
    /// 贷款产品推荐
    func getLoanGroom(count: Int, page: Int, complete:@escaping (_ data: [LGLoanProductModel]?, _ error: String?) -> Void) {
        let urlString = domain.appending("loan_groom")
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
        let urlString = domain.appending("credit_groom1")
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
        let urlString = domain.appending("home_page")
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
}
