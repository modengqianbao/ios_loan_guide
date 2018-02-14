//
//  LGCreditCarService.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGCreditCarService {
    static let sharedService = LGCreditCarService()
    
    private init() {}
    
    private let service = LGHttpService.sharedService
    
    /// 获取信用卡产品列表
    /// parameter - bank: 银行ID
    /// parameter - grade: 卡片等级(1：普卡    2：金卡3：白金卡)
    /// parameter - purpose: 卡片用途(1:标准卡2：特色主题卡3：网络联名卡4：酒店/商旅/航空卡5：取现卡    )
    func getCreditCarList(bank: Int, grade: Int, purpose: Int, complete: @escaping (_ array: [LGCreditProductModel]?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("credit_search")
        let parameters = ["creditnaBank": bank,
                          "creditnaGrade": grade,
                          "creditnaPurpose": purpose]
        service.get(urlString: urlString, parameters: parameters) { json, error in
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
}
