//
//  LGMineService.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

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
}
