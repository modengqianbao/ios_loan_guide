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
        let urlString = domain.appending("login_in")
        let parameters = ["phone": phone,
                          "password": password]
        service.post(urlString: urlString, parameters: parameters) { (json, error) in
            complete(error)
        }
    }
    
    /// 发送验证码, 1登录，2评测验证，3活动
    func sendSMSCode(phoneNumber: String, type: Int, complete: @escaping (_ smsToken: String?, _ error: String?) -> Void) {
        let urlString = domain.appending("sms_code")
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
        let urlString = domain.appending("register")
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
        let urlString = domain.appending("change_password")
        let parameters = ["phone": phone,
                          "password": password,
                          "smsCode": smsCode,
                          "smsToken": smsToken]
        service.post(urlString: urlString, parameters: parameters) { (json, error) in
            complete(error)
        }
    }
}
