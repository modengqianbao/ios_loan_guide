//
//  LGQuestionModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON

class LGQuestionModel {
    /// 回答
    var content: String
    
    /// 头标
    var header: String
    
    /// 问题
    var matter: String
    
    init(json: JSON) {
        content = json["content"].stringValue
        header = json["herder"].stringValue
        matter = json["matter"].stringValue
    }
}
