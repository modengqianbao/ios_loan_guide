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
    
    /// 信用卡产品推荐
    func getCreditGroom(count: Int, page: Int, complete:@escaping (_ data: [LGLoanProductModel]?, _ error: String?) -> Void) {
        let urlString = domain.appending("loan_groom")
        let parameters = ["count": 10,
                          "page": 1]
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
    
    ///
}
