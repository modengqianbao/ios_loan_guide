//
//  LGCreditService.swift
//  LoanGuide
//
//  Created by 喂草。 on 12/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGCreditService {
    static let sharedService = LGCreditService()
    
    private init() {}
    
    private let service = LGHttpService.sharedService
    
    /// 获取芝麻信用授权页URL
    func getAuthorizationURL(idNumber: String, name: String, phone: String, complete: @escaping (_ urlString: String?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("cacsi_auth")
        let parameters = ["idCard": idNumber,
                          "name": name,
                          "phone": phone]
        service.post(urlString: urlString, parameters: parameters) { json, error in
            if error == nil {
                let url = json!["data"]["url"].stringValue
                complete(url, nil)
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 提交查询个人风险信息
    func queryPersonalData(idNumber: String, name: String, phone: String, params: String, sign: String, complete: @escaping (_ queryID: String?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("query_personal_data")
        let parameters = ["idCard": idNumber,
                          "name": name,
                          "phone": phone,
                          "params": params,
                          "sign": sign]
        service.post(urlString: urlString, parameters: parameters) { json, error in
            if error == nil {
                let queryID = json!["data"]["id"].stringValue
                complete(queryID, nil)
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 查询个人信用报告
    func getCreditReport(queryID: String, complete: @escaping (_ reportModel: LGCreditReportModel?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("query_result")
        let parameters = ["id": queryID]
        service.post(urlString: urlString, parameters: parameters) { json, error in
            if error == nil {
                let jsonItem = json!["data"]
                let model = LGCreditReportModel(json: jsonItem)
                complete(model, nil)
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 获取历史报告id
    func getHistoryReportID(complete: @escaping (_ id: String?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("history_report")
        service.post(urlString: urlString, parameters: nil) { json, error in
            if error == nil {
                let jsonArray = json!["data"]["reportList"].arrayValue
                if let jsonItem = jsonArray.first {
                    complete(jsonItem["id"].stringValue, nil)
                } else {
                    complete(nil, nil)
                }
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 获取支付金额
    func getPayMoney(complete: @escaping (_ money: String?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("pay_money")
        service.post(urlString: urlString, parameters: nil) { json, error in
            if error == nil {
                let money = json!["data"]["money"].stringValue
                complete(money, nil)
            } else {
                complete(nil, error)
            }
        }
    }
}
