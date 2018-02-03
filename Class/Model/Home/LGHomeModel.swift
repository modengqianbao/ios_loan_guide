//
//  Home.swift
//  LoanGuide
//
//  Created by 喂草。 on 02/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGHomeModel {
    var loanProductArray: [LGLoanProductModel]
    var loanProductCurrentPage: Int
    
    init() {
        loanProductArray = [LGLoanProductModel]()
        loanProductCurrentPage = 1
    }
    
    private let pageSize = 10
    
    /// 获取更多贷款产品
    func loadMoreLoanProduct(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        loanProductCurrentPage += 1
        LGHomeService.sharedService.getCreditGroom(count: pageSize, page: loanProductCurrentPage) { [weak self] (array, error) in
            if error == nil {
                self!.loanProductArray.append(contentsOf: array!)
                if array!.count < self!.pageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
    
    /// 刷新贷款产品
    func reloadLoanProduct(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        loanProductCurrentPage = 1
        LGHomeService.sharedService.getCreditGroom(count: pageSize, page: loanProductCurrentPage) { [weak self] (array, error) in
            if error == nil {
                self!.loanProductArray = array!
                if array!.count < self!.pageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
}
