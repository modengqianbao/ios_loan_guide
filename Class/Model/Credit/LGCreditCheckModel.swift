//
//  LGCreditCheckModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 14/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGCreditCheckModel {
    static let sharedModel = LGCreditCheckModel()
    
    private init() {}
    
    /// 是否得到授权
    var isAuthed = false
    
    /// 芝麻授权后返回参数
    var params: String?
    
    /// 芝麻授权后返回参数用户查询是否有支付宝
    var sign: String?
    
    /// 得到认证，储存
    func getZhimaAuth(params: String, sign: String) {
        self.params = params
        self.sign = sign
        
        isAuthed = true
    }
}
