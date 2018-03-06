//
//  LGLoanModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGLoanModel {
    var loanArray: [LGLoanProductModel]
    let returnTypeArray = ["不限", "随借随还", "分期付款"]
    var currentReturnType = 0
    var sortWithRate = true // 默认按贷款利率排序
    
    init() {
        loanArray = LGLoanService.sharedService.loadLoanArray()
    }
    
    /// 获取贷款列表
    func reloadLoanList(complete: @escaping (_ error: String?) -> Void) {
        LGLoanService.sharedService.getLoanList(quota: 0, repayment: currentReturnType, term: 0, time: !sortWithRate, rate: sortWithRate) { [weak self] array, error in
            if error == nil {
                self!.loanArray = array!
                
                // 持久化
                LGLoanService.sharedService.saveLoanArray(array: array!)
                
                complete(nil)
            } else {
                complete(error)
            }
        }
    }
}
