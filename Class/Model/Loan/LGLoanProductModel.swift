//
//  LoanProductModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 02/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

//import UIKit
import SwiftyJSON

class LGLoanProductModel {
    let id: Int
    /// 简介
    var introduction: String
    var isRecommended: Bool
    /// 标签
    var labelString: String
    /// logo图片地址
    var logoString: String
    /// 最大额度
    var loanMax: Int
    /// 最小额度
    var loanMin: Int
    /// 名称
    var name: String
    /// 利率单位，1-天，2-月
    var loanSign: Int
    /// 产品特点
    var loanSpec: String
    /// 最大利率
    var rateMax: Float
    /// 最小利率
    var rateMin: Float
    /// 产品状态 1，马上抢 2，可申请 3.已抢光
    var status: Int
    /// 记录时间
    var timeInt: Int?
    
    /*-------------------------------------------------------*/
    // 详情
    var isDetailed = false
    /// 申请条件
    var condition: String?
    /// 审核周期
    var cycle: String?
    /// 审核方式
    var mode: String?
    /// 申请流程
    var flowArray: [LGLoanFlowModel]?
    /// 放款时间(分)
    var loanTime: Int?
    /// 放款时间描述
    var loanTimeinfo: String?
    /// 还款方式：1随借随还，2分期还款
    var repayment: Int?
    /// 最小期限
    var termMin: Int?
    /// 最大期限
    var termMax: Int?
    /// 贷款链接
    var url: String?
    
    init(json: JSON) {
        id = json["id"].intValue
        introduction = json["introduce"].stringValue
        isRecommended = json["isRecommend"].boolValue
        labelString = json["label"].stringValue
        logoString = json["loanLogo"].stringValue
        loanMax = json["loanMax"].intValue
        loanMin = json["loanMin"].intValue
        name = json["loanName"].stringValue
        loanSign = json["loanSign"].intValue
        loanSpec = json["loanSpec"].stringValue
        rateMax = json["rateMax"].floatValue
        rateMin = json["rateMin"].floatValue
        status = json["status"].intValue
        timeInt = json["time"].int
    }
    
    init(databaseModel model: LGLoanProductDatabaseModel) {
        id = model.id
        name = model.loanName
        isRecommended = model.isRecommended
        introduction = model.introduction
        labelString = model.labelString
        logoString = model.logoString
        loanMax = model.loanMax
        loanMin = model.loanMin
        loanSign = model.loanSign
        loanSpec = model.loanSpec
        rateMax = model.rateMax
        rateMin = model.rateMin
        status = model.status
    }
    
    init(bannerModel: LGHomeBannerModel) {
        id = bannerModel.id
        name = bannerModel.name
        isRecommended = bannerModel.type == 1
        introduction = ""
        labelString = ""
        logoString = ""
        loanMax = 0
        loanMin = 0
        loanSign = 0
        loanSpec = ""
        rateMax = 0
        rateMin = 0
        status = 0
    }
    
    func getDetail(complete: @escaping (_ error: String?) -> Void) {
        LGLoanService.sharedService.getLoanDetail(loanItem: self) { error in
            complete(error)
        }
    }
}
