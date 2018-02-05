//
//  LGLoanFlowModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON

class LGLoanFlowModel {
    /// 产品ID
    var productID: Int
    
    /// 贷款ID
    var loanID: Int
    
    /// 流程名字
    var name: String
    
    /// 流程顺序
    var order: Int
    
    /// 是否显示
    var isShow: Bool {
        get {
            return isShowInt == 1
        }
    }
    private var isShowInt: Int
    
    /// 流程图url
    var urlString: String
    
    init(json: JSON) {
        productID = json["id"].intValue
        loanID = json["loanId"].intValue
        name = json["programName"].stringValue
        order = json["programOrder"].intValue
        isShowInt = json["programShow"].intValue
        urlString = json["programUrl"].stringValue
    }
}
