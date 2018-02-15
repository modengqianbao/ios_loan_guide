//
//  LGCreditBankModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 15/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGCreditBankModel {
    /// 银行名
    var name: String
    
    /// id
    var id: Int
    
    init(bankName: String, bankID: Int) {
        name = bankName
        id = bankID
    }
}
