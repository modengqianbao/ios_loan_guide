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
    var creditProductArray: [LGCreditProductModel]
    var loanProductCurrentPage: Int
    var creditProductCurrentPage: Int
    var bannerArray: [LGHomeBannerModel]
    
    private var loanReady: Bool!
    private var creditReady: Bool!
    private var bannerReady: Bool!
    
    init() {
        loanProductArray = [LGLoanProductModel]()
        creditProductArray = [LGCreditProductModel]()
        loanProductCurrentPage = 1
        creditProductCurrentPage = 1
        bannerArray = [LGHomeBannerModel]()
    }
    
    private let pageSize = 10
    
    /// 获取首页数据
    func getHomeData(complete: @escaping (_ error: String?) -> Void) {
        loanReady = false
        creditReady = false
        bannerReady = false
        getBanner { [weak self] error in
            if error == nil {
                self!.bannerReady = true
                if self!.checkReady() {
                    complete(nil)
                }
            } else {
                complete(error)
            }
        }
        
        getCredit { [weak self] error in
            if error == nil {
                self!.creditReady = true
                if self!.checkReady() {
                    complete(nil)
                }
            } else {
                complete(error)
            }
        }
        
        getLoanProduct { [weak self] error in
            if error == nil {
                self!.loanReady = true
                if self!.checkReady() {
                    complete(nil)
                }
            } else {
                complete(error)
            }
        }
    }
    
    private func checkReady() -> Bool {
        return creditReady && loanReady && bannerReady
    }
    
    /// 获取更多贷款产品
//    func loadMoreLoanProduct(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
//        loanProductCurrentPage += 1
//        LGHomeService.sharedService.getCreditGroom(count: pageSize, page: loanProductCurrentPage) { [weak self] (array, error) in
//            if error == nil {
//                self!.loanProductArray.append(contentsOf: array!)
//                if array!.count < self!.pageSize {
//                    complete(false, nil)
//                } else {
//                    complete(true, nil)
//                }
//            } else {
//                complete(false, error)
//            }
//        }
//    }
    
    /// 获取贷款推荐
    private func getLoanProduct(complete: @escaping (_ error: String?) -> Void) {
        loanProductCurrentPage = 1
        LGHomeService.sharedService.getLoanGroom(count: pageSize, page: loanProductCurrentPage) { [weak self] array, error in
            if error == nil {
                self!.loanProductArray = array!
//                if array!.count < self!.pageSize {
//                    complete(false, nil)
//                } else {
//                    complete(true, nil)
//                }
                complete(nil)
            } else {
                complete(error)
            }
        }
    }
    
    /// 获取信用卡推荐
    private func getCredit(complete: @escaping (_ error: String?) -> Void) {
        creditProductCurrentPage = 1
        LGHomeService.sharedService.getCreditGroom(count: pageSize, page: creditProductCurrentPage) { [weak self] array, error in
            if error == nil {
                self!.creditProductArray = array!
                complete(nil)
            } else {
                complete(error)
            }
        }
    }
    
    /// 获取banner
    private func getBanner(complete: @escaping (_ error: String?) -> Void) {
        LGHomeService.sharedService.getHomeBanner { [weak self] array, error in
            if error == nil {
                self!.bannerArray = array!
                complete(nil)
            } else {
                complete(error)
            }
        }
    }
}
