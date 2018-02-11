//
//  Enum.swift
//  LoanGuide
//
//  Created by 喂草。 on 11/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

enum LGUserBehaviorType: Int {
    /// 点击贷款产品
    case clickLoanProduct = 1
    
    /// 输入贷款额度
    case selectLoanLimit = 2
    
    /// 选择贷款期限
    case selectLoanTerm = 3
    
    /// 选择贷款利率
    case selectLoanRate = 4
    
    /// 选择放款速度
    case selectLoanSpeed = 5
    
    /// 选择还款方式
    case selectReturnType = 6
    
    /// 点击推荐banner
    case clickBanner = 7
    
    /// 点击推荐模块
    case clickRecommend = 8
    
    /// 点击推荐贷款
    case clickRecommendLoan = 9
    
    /// 点击推荐信用卡
    case clickRecommendCreditCard = 10
    
    /// 选择信用卡银行
    case selectBank = 11
    
    /// 选择银行卡用途
    case selectCreditCardUsage = 12
    
    /// 选择信用卡等级
    case selectCreditCardLevel = 13
    
    /// 输入手机号
    case typeinPhone = 14
    
    /// 获取手机验证码
    case getSMSCode = 15
    
    /// 点击登录
    case clickLogin = 16
}

