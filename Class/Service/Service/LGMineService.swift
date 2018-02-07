//
//  LGMineService.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON

class LGMineService {
    static let sharedService = LGMineService()
    
    private init() {}
    
    private var service = LGHttpService.sharedService
    
    /// 意见反馈
    func sendFeedBack(content: String, complete: @escaping (_ error: String?) -> Void) {
        let urlString = domain.appending("send_suggestion")
        let parameters = ["info": content]
        service.post(urlString: urlString, parameters: parameters) { _, error in
            complete(error)
        }
    }
    
    /// 获取问题
    func getQuestions(complete: @escaping (_ array: [LGQuestionModel]?, _ error: String?) -> Void) {
        let urlString = domain.appending("questions")
        service.post(urlString: urlString, parameters: nil) { json, error in
            if error == nil {
                let jsonArray = json!["data"]["askList"].arrayValue
                var array = [LGQuestionModel]()
                for jsonItem in jsonArray {
                    let item = LGQuestionModel(json: jsonItem)
                    array.append(item)
                }
                complete(array, nil)
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 获取消息
    func getMessage(page: Int, count: Int, complete: @escaping (_ array: [LGMessageModel]?, _ error: String?) -> Void) {
        let urlString = domain.appending("new_center")
        let parameters = ["count": count,
                          "page": page]
        service.post(urlString: urlString, parameters: parameters) { json, error in
            if error == nil {
                let jsonArray = json!["data"]["newList"].arrayValue
                var array = [LGMessageModel]()
                for jsonItem in jsonArray {
                    let item = LGMessageModel(json: jsonItem)
                    array.append(item)
                }
                complete(array, nil)
            } else {
                complete(nil, error)
            }
        }
    }
    
    /// 获取贷款记录
    func getLoanRecord(page: Int, pageSize: Int, complete: @escaping (_ array: [LGLoanProductModel]?, _ error: String?) -> Void) {
        let urlString = domain.appending("loan_browse")
        let parameters = ["currentPage": page,
                          "pageSize": pageSize]
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
    
    /// 获取信用卡记录
    func getCreditRecord(page: Int, pageSize: Int, complete: @escaping (_ array: [LGCreditProductModel]?, _ error: String?) -> Void){
        let urlString = domain.appending("credit_browse")
        let parameters = ["currentPage": page,
                          "pageSize": pageSize]
        service.post(urlString: urlString, parameters: parameters) { json, error in
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
