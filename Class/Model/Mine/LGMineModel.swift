//
//  LGMineModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGMineModel {
    // 常见问题
    var questionArray: [[LGQuestionModel]]?
    var questionHeaderArray: [String]?
    
    // 消息中心
    var messageArray: [LGMessageModel]?
    var messagePage = 1
    let messagePageSize = 10
    
    // 申请记录
    private var loanRawArray: [LGLoanProductModel]?
    var loanArray: [[LGLoanProductModel]]?
    var loanPage = 1
    let loanPageSize = 10
    var loanDateStringArray: [String]?
    private var creditRawArray: [LGCreditProductModel]?
    var creditArray: [[LGCreditProductModel]]?
    var creditPage = 1
    let creditPageSize = 10
    var creditDateStringArray: [String]?
    
    init() {}
    
    // 加载消息
    func loadMoreMessages(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        messagePage += 1
        LGMineService.sharedService.getMessage(page: messagePage, count: messagePageSize) { [weak self] array, error in
            if error == nil {
                if self!.messageArray != nil {
                    self!.messageArray!.append(contentsOf: array!)
                } else {
                    self!.messageArray = array
                }
                if array!.count < self!.messagePageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
    
    func reloadMessages(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        messagePage = 1
        LGMineService.sharedService.getMessage(page: messagePage, count: messagePageSize) { [weak self] array, error in
            if error == nil {
                self!.messageArray = array
                if array!.count < self!.messagePageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
    
    /// 获取贷款
    func loadLoanProduct(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        loanPage += 1
        LGMineService.sharedService.getLoanRecord(page: loanPage, pageSize: loanPageSize) { [weak self] array, error in
            if error == nil {
                if self!.loanRawArray != nil {
                    self!.loanRawArray!.append(contentsOf: array!)
                } else {
                    self!.loanRawArray = array
                }
                self?.manageLoanData()
                if array!.count < self!.loanPageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
    
    /// 刷新贷款列表
    func reloadLoanProduct(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        loanPage = 1
        LGMineService.sharedService.getLoanRecord(page: loanPage, pageSize: loanPageSize) { [weak self] array, error in
            if error == nil {
                self!.loanRawArray = array
                self!.manageLoanData()
                if array!.count < self!.loanPageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
    
    /// 获取信用卡
    func loadCreditProduct(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        creditPage += 1
        LGMineService.sharedService.getCreditRecord(page: creditPage, pageSize: creditPageSize) { [weak self] array, error in
            if error == nil {
                if self!.creditRawArray != nil {
                    self!.creditRawArray!.append(contentsOf: array!)
                } else {
                    self!.creditRawArray = array
                }
                self!.manageCreditData()
                if array!.count < self!.creditPageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
    
    /// 刷新信用卡
    func reloadCreditProduct(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        creditPage = 1
        LGMineService.sharedService.getCreditRecord(page: creditPage, pageSize: creditPageSize) { [weak self] array, error in
            if error == nil {
                self!.creditRawArray = array
                self!.manageCreditData()
                if array!.count < self!.creditPageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
    
    private func dateStringForDayCount(_ day: Int) -> String {
        let dateInt = day * 86400
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    /// 按日期整理贷款
    private func manageLoanData() {
        loanDateStringArray = [String]()
        loanArray = [[LGLoanProductModel]]()
        var tempDay = 0
        var tempArray = [LGLoanProductModel]()
        for index in 0..<loanRawArray!.count {
            let item = loanRawArray![index]
            let day = item.timeInt! / 1000 / 86400
            if tempDay == day {
                tempArray.append(item)
            } else {
                if index != 0 {
                    // 结束上一列表
                    loanArray!.append(tempArray)
                    let dateString = dateStringForDayCount(tempDay)
                    loanDateStringArray!.append(dateString)
                }
                // 创建新列
                tempDay = day
                tempArray = [LGLoanProductModel]()
                tempArray.append(item)
            }
            if index == loanRawArray!.count - 1 {
                loanArray!.append(tempArray)
                let dateString = dateStringForDayCount(tempDay)
                loanDateStringArray!.append(dateString)
            }
        }
    }
    
    /// 按日期整理信用卡
    private func manageCreditData() {
        creditDateStringArray = [String]()
        creditArray = [[LGCreditProductModel]]()
        var tempDay = 0
        var tempArray = [LGCreditProductModel]()
        for index in 0..<creditRawArray!.count {
            let item = creditRawArray![index]
            let day = item.timeInt / 1000 / 86400
            if tempDay == day {
                tempArray.append(item)
            } else {
                if index != 0 {
                    // 结束上一列表
                    creditArray!.append(tempArray)
                    let dateString = dateStringForDayCount(tempDay)
                    creditDateStringArray!.append(dateString)
                }
                // 创建新列
                tempDay = day
                tempArray = [LGCreditProductModel]()
                tempArray.append(item)
            }
            if index == creditRawArray!.count - 1 {
                creditArray!.append(tempArray)
                let dateString = dateStringForDayCount(tempDay)
                creditDateStringArray!.append(dateString)
            }
        }
    }
}
