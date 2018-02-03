//
//  LGMessageModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON

class LGMessageModel {
    /// 时间
    var dateString: String {
        get {
            let second = dateInt / 1000
            let date = Date(timeIntervalSince1970: TimeInterval(second))
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter.string(from: date)
        }
    }
    private var dateInt: Int
    
    /// 跳转URL
    var urlString: String
    
    /// 消息内容
    var content: String
    
    /// 消息标题
    var title: String
    
    init(json: JSON) {
        dateInt = json["createTime"].intValue
        urlString = json["msgUrl"].stringValue
        content = json["newContent"].stringValue
        title = json["newHead"].stringValue
    }
}
