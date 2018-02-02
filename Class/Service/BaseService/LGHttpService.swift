//
//  LGHttpService.swift
//  LoanGuide
//
//  Created by 喂草。 on 01/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LGHttpService {
    static let sharedService = LGHttpService()
    
    private init() {}
    
    func get(urlString: String, parameters: [String: Any]?, complete: @escaping (_ data: JSON?, _ error: String?) -> Void) {
        guard let url = URL(string: urlString) else {
            complete(nil, "url error")
            return
        }
        let header = ["fsd": "fdshkl"]
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                complete(json, nil)
            } else {
                complete(nil, "request error")
            }
        }
    }
    
    func post(urlString: String, parameters: [String: Any]?, complete: @escaping (_ data: JSON?, _ error: String?) -> Void) {
        guard let url = URL(string: urlString) else {
            complete(nil, "url error")
            return
        }
        
        let header = ["fsd": "fdshkl"]
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                complete(json, nil)
            } else {
                complete(nil, "request error")
            }
        }
    }
}
