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
}
