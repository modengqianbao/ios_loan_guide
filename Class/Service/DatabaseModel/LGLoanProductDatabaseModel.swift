//
//  LGLoanProductDatabaseModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 06/03/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import RealmSwift

class LGLoanProductDatabaseModel: Object {
    @objc dynamic var name = "loanProduct"
    
    /// 首页使用或贷款页使用
    @objc dynamic var isForHome = true
    
    @objc dynamic var id: Int = 0
    /// 简介
    @objc dynamic var introduction: String = ""
    @objc dynamic var isRecommended: Bool = false
    /// 标签
    @objc dynamic var labelString: String = ""
    /// logo图片地址
    @objc dynamic var logoString: String = ""
    /// 最大额度
    @objc dynamic var loanMax: Int = 0
    /// 最小额度
    @objc dynamic var loanMin: Int = 0
    /// 名称
    @objc dynamic var loanName: String = ""
    /// 利率单位，1-天，2-月
    @objc dynamic var loanSign: Int = 1
    /// 产品特点
    @objc dynamic var loanSpec: String = ""
    /// 最大利率
    @objc dynamic var rateMax: Float = 0
    /// 最小利率
    @objc dynamic var rateMin: Float = 0
    /// 产品状态 1，马上抢 2，可申请 3.已抢光
    @objc dynamic var status: Int = 0
    /// 记录时间
//    @objc dynamic var timeInt: Int?
    
    func setup(isForHome: Bool, model: LGLoanProductModel) {
        self.isForHome = isForHome
        
        id = model.id
        introduction = model.introduction
        isRecommended = model.isRecommended
        labelString = model.labelString
        logoString = model.logoString
        loanMax = model.loanMax
        loanMin = model.loanMin
        loanName = model.name
        loanSign = model.loanSign
        loanSpec = model.loanSpec
        rateMax = model.rateMax
        rateMin = model.rateMin
        status = model.status
    }
}
