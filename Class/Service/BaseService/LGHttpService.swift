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
    
    private init() {
        loadCookies()
    }
    
    func get(urlString: String, parameters: [String: Any]?, complete: @escaping (_ json: JSON?, _ error: String?) -> Void) {
        guard let url = URL(string: urlString) else {
            complete(nil, "url error")
            return
        }
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                if json["msg"].stringValue.isEmpty {
                    complete(json, nil)
                } else {
                    complete(nil, json["msg"].stringValue)
                }
            } else {
                complete(nil, "请检查网络连接")
            }
        }
    }
    
    func post(urlString: String, parameters: [String: Any]?, complete: @escaping (_ data: JSON?, _ error: String?) -> Void) {
        guard let url = URL(string: urlString) else {
            complete(nil, "url error")
            return
        }
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            // 持久化cookie
            self.saveCookies(response: response)
            
            if let data = response.result.value {
                let json = JSON(data)
                if json["msg"].stringValue.isEmpty {
                    complete(json, nil)
                } else {
                    complete(nil, json["msg"].stringValue)
                }
            } else {
                complete(nil, "请检查网络连接")
            }
        }
    }
    
    private func saveCookies(response: DataResponse<Any>) {
        if let headerFields = response.response?.allHeaderFields as? [String: String] {
            let url = response.response?.url
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
            var cookieArray = [[HTTPCookiePropertyKey: Any]]()
            for cookie in cookies {
                cookieArray.append(cookie.properties!)
            }
            if cookieArray.count > 0 {
                UserDefaults.standard.set(cookieArray, forKey: "savedCookies")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    private func loadCookies() {
        guard let cookieArray = UserDefaults.standard.array(forKey: "savedCookies") as? [[HTTPCookiePropertyKey: Any]] else { return }
        for cookieProperties in cookieArray {
            if let cookie = HTTPCookie(properties: cookieProperties) {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
    }
    
    func clearCookies() {
        UserDefaults.standard.set(nil, forKey: "savedCookies")
        UserDefaults.standard.synchronize()
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for each in cookies {
                HTTPCookieStorage.shared.deleteCookie(each)
            }
        }
    }
}
