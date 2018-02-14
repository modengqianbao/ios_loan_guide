//
//  LGUserService.swift
//  LoanGuide
//
//  Created by 喂草。 on 02/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGUserService {
    static let sharedService = LGUserService()
    
    private let service = LGHttpService.sharedService
    
    private init() {}
    
    /// 登录
    func login(withPhone phone: String, password: String, complete: @escaping (_ error: String?) -> Void) {
        let urlString = kDomain.appending("login_in")
        let parameters = ["phone": phone,
                          "password": password]
        service.post(urlString: urlString, parameters: parameters) { (json, error) in
            complete(error)
        }
    }
    
    /// 发送验证码, 1登录，2评测验证，3活动
    func sendSMSCode(phoneNumber: String, type: Int, complete: @escaping (_ smsToken: String?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("sms_code")
        let parameters: [String: Any] = ["phoneNum": phoneNumber,
                          "bizType": type]
        service.get(urlString: urlString, parameters: parameters) { (json, error) in
            if error == nil {
                let token = json!["data"]["smsToken"].string
                complete(token, nil)
            } else {
                complete(nil, error)
            }
        }        
    }
    
    /// 注册
    func signup(withPhone phone: String, password: String, smsCode: String, smsToken: String, complete: @escaping (_ error: String?) -> Void) {
        let urlString = kDomain.appending("register")
        let parameters = ["phone": phone,
                         "password": password,
                         "smsCode": smsCode,
                         "smsToken": smsToken]
        service.post(urlString: urlString, parameters: parameters) { (json, error) in
            complete(error)
        }
    }
    
    /// 修改密码
    func changePassword(with phone: String, newPassword password: String, smsCode: String, smsToken: String, complete: @escaping (_ error: String?) -> Void) {
        let urlString = kDomain.appending("change_password")
        let parameters = ["phone": phone,
                          "password": password,
                          "smsCode": smsCode,
                          "smsToken": smsToken]
        service.post(urlString: urlString, parameters: parameters) { (json, error) in
            complete(error)
        }
    }
    
    /// 实名认证
    func verification(idNumber: String, name: String, phone: String, complete: @escaping (_ error: String?) -> Void) {
        let urlString = kDomain.appending("idcard_auth")
        let parameters = ["idCard": idNumber,
                          "name": name,
                          "phone": phone]
        service.post(urlString: urlString, parameters: parameters) { _, error in
            complete(error)
        }
    }
    
    /// 获取用户认证信息
    func getVerificationInfo(complete: @escaping (_ status: Bool, _ idNumber: String?, _ name: String?, _ mark: String?, _ error: String?) -> Void) {
        let urlString = kDomain.appending("is_attestation")
        service.post(urlString: urlString, parameters: nil) { json, error in
            if error == nil {
                let idNumber = json!["data"]["idCard"].stringValue
                let name = json!["data"]["name"].stringValue
                let mark = json!["data"]["mark"].stringValue
                let status = json!["data"]["status"].intValue
                complete(status == 2, idNumber, name, mark, nil)
            } else {
                complete(false, nil, nil, nil, error)
            }
        }
    }
    
    /// 记录用户浏览
    /// 1：贷款，2：信用卡
    func recordBrowse(productType: Int, productID: Int, complete: ((_ error: String?) -> Void)?) {
        let urlString = kDomain.appending("record_history")
        let parameters = ["id": productID,
                          "type": productType]
        service.get(urlString: urlString, parameters: parameters) { _, error in
            complete?(error)
        }
    }
    
    /// 记录用户行为
    func recordBehavior(behavior: LGUserBehaviorType, complete: ((_ error: String?) -> Void)?) {
        let urlString = kDomain.appending("user_behavior")
        let parameters = ["behavior": behavior.rawValue]
        service.get(urlString: urlString, parameters: parameters) { _, error in
            complete?(error)
        }
    }
}
