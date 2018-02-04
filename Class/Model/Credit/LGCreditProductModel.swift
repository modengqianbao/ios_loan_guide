//
//  LGCreditProductModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON

class LGCreditProductModel {
    /// logo图片地址
    var logoURL: String
    
    /// 名称
    var name:String
    
    /// 链接地址
    var urlString: String
    
    /// ID
    var id: Int
    
    /// 简介
    var introduce: String
    
    /// 标签（ad）
    var label: String?
    
    /// 状态 1，马上抢 2，可申请 3.已抢光
    var status: Int
    
    /// 日期时间
    var timeInt: Int
    
    init(json: JSON) {
        logoURL = json["creditLogo"].stringValue
        name = json["creditName"].stringValue
        urlString = json["h5Url"].stringValue
        id = json["id"].intValue
        introduce = json["introduce"].stringValue
        label = json["label"].stringValue
        status = json["status"].intValue
        timeInt = json["time"].intValue
    }
}
