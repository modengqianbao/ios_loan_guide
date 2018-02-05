//
//  LGLoanService.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGLoanService {
    static let sharedService = LGLoanService()
    
    private init() {}
    
    private let service = LGHttpService.sharedService
    
    /// 获取贷款列表
    /// - parameter quota:    贷款金额: 0: 不限 1: 100-5000, 2: 5000-10000, 3: 1万-3万 4: 3-5万，5: 5万以上
    /// - parameter repayment:    还款方式: 还款方式(1：随借随还2：分期还款)
    /// - parameter term:    贷款期限: 0: 不限 1: 7-30天, 2: １-３月, 3: 3-6月 4: ６-12月，5: 1-3年
    /// - parameter time:    放款速度: true：选中，按照最快放款速度排序
    /// - parameter rate:    利率: rate：选中，按照最低利率排序
    func getLoanList(quota: Int, repayment: Int, term: Int, time: Bool, rate: Bool, complete: @escaping (_ array:[LGLoanProductModel]?, _ error: String?) -> Void) {
        let urlString = domain.appending("loan_search")
        let parameters = ["loanQuota": quota,
                          "loanRepayment": repayment,
                          "loanTerm": term,
                          "loanTime": time ? 1 : 0,
                          "rate": rate ? 1 : 0]
        service.post(urlString: urlString, parameters: parameters) { json, error in
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
    
    /// 获取贷款产品详情
    func getLoanDetail(loanItem: LGLoanProductModel, complete: @escaping (_ error: String?) -> Void) {
        let urlString = domain.appending("loan_detail")
        let parameters = ["id": loanItem.id]
        service.post(urlString: urlString, parameters: parameters) { json, error in
            if error == nil {
                let jsonItem = json!["data"]["loanDetail"]
                loanItem.condition = jsonItem["loanCondition"].stringValue
                loanItem.cycle = jsonItem["loanCycle"].stringValue
                loanItem.loanTime = jsonItem["loanTime"].intValue
                loanItem.loanTimeinfo = jsonItem["loanTimeInfo"].stringValue
                loanItem.repayment = jsonItem["loanRepayment"].intValue
                loanItem.termMin = jsonItem["loanTermMin"].intValue
                loanItem.termMax = jsonItem["loanTermMax"].intValue
                loanItem.mode = jsonItem["loanMode"].stringValue
                let jsonArray = jsonItem["loanFlows"].arrayValue
                var array = [LGLoanFlowModel]()
                for jsonItem in jsonArray {
                    let flowItem = LGLoanFlowModel(json: jsonItem)
                    array.append(flowItem)
                }
                loanItem.flowArray = array
                loanItem.isDetailed = true
                complete(nil)
            } else {
                complete(error)
            }
        }
    }
}
