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
}
