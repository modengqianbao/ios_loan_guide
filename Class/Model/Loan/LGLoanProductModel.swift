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
    let introduction: String
    let isRecommended: Bool
    /// 标签
    let labelString: String
    /// logo图片地址
    let logoString: String
    /// 最大额度
    let loanMax: Int
    /// 最小额度
    let loanMin: Int
    /// 名称
    let name: String
    /// 利率单位，1-天，2-月
    let loanSign: Int
    /// 产品特点
    let loanSpec: String
    /// 最大利率
    let rateMax: Float
    /// 最小利率
    let rateMin: Float
    /// 产品状态 1，马上抢 2，可申请 3.已抢光
    let status: Int
    
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
    }
    
    func getDetail(complete: @escaping (_ error: String?) -> Void) {
        LGLoanService.sharedService.getLoanDetail(loanItem: self) { error in
            complete(error)
        }
    }
}
