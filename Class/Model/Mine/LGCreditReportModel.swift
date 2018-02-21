//
//  LGCreditReportModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 21/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON

class LGCreditReportModel {
//    /// 查询详情id
//    var queryID: String?
//    
//    /// 是否已经获取详情
//    var isDetail: Bool
    
    /// 逾期笔数
    let overdueCount: String
    
    /// 最长逾期期数
    let overduePeriod: String
    
    /// 身份认证状态，true已认证
    let idAuth: Bool
    
    /// 身份证
    let idNumber: String
    
    /// 身份证归属地
    let idNumberLocation: String
    
    /// 姓名
    let name: String
    
    /// 手机号
    let phone: String
    
    /// 手机号归属地
    let phoneLocation: String
    
    /// 芝麻分
    let mark: String
    
    /// 查询时间
    private let queryTimeInt: Int
    var queryTime: String {
        get  {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月dd日"
            let date = Date(timeIntervalSince1970: TimeInterval(queryTimeInt))
            return formatter.string(from: date)
        }
    }
    
    /// 芝麻等级
    let markLevel: String
    
    /// 个人风险状态，true存在个人风险
    let riskStatus: Bool
    
    /// 个人风险情况
    let riskArray: [String]
    
    /// 失信状态，true存在失信
    let faithStatus: Bool
    
    /// 多平台借贷记录状态 1：正常 2：较少 3：较多 4：过多
    let loanStatus: Int
    
    /// 多平台借贷一个月
    let loanMonth: LGCreditReportLoanModel
    
    /// 多平台借贷三个月
    let loan3Month: LGCreditReportLoanModel
    
    /// 多平台借贷一周
    let loanWeek: LGCreditReportLoanModel
    
//    init(queryID: String) {
//        isDetail = false
//        self.queryID = queryID
//
//        // 芝麻相关
//        mark = "0"
//        queryTimeInt = 0
//        markLevel = "-"
//
//        // 失信记录
//        faithStatus = false
//
//        // 个人信息
////        let idJSON = json["identifyingInformation"]
//        idAuth = false
//        idNumber = "-"
//        idNumberLocation = "-"
//        name = "-"
//        phone = "-"
//        phoneLocation = "-"
//
//        // 个人风险
////        let riskJSON = json["personalRisk"]
//        riskStatus = false
////        let infoJSONArray = riskJSON["riskInfo"].arrayValue
////        var infoArray = [String]()
////        for infoJSON in infoJSONArray {
////            infoArray.append(infoJSON.stringValue)
////        }
//        riskArray = [String]()
//
//        // 逾期记录
////        let overdueJSON = json["overdue"]
//        overdueCount = "0"
//        overduePeriod = "0"
//
//        // 多平台借贷记录
////        let loanJSON = json["multiPlatform"]
//        loanStatus = 0
//        loanWeek = LGCreditReportLoanModel()
//        loanMonth = LGCreditReportLoanModel()
//        loan3Month = LGCreditReportLoanModel()
//    }
    
    init(json: JSON) {
//        isDetail = true
        // 芝麻相关
        mark = json["mark"].stringValue
        queryTimeInt = json["queryTime"].intValue
        markLevel = json["sesameGrade"].stringValue
        
        // 失信记录
        faithStatus = json["breakFaith"]["faithStatus"].boolValue
        
        // 个人信息
        let idJSON = json["identifyingInformation"]
        idAuth = idJSON["idAuth"].boolValue
        idNumber = idJSON["idcard"].stringValue
        idNumberLocation = idJSON["idcardkuaidial"].stringValue
        name = idJSON["name"].stringValue
        phone = idJSON["phone"].stringValue
        phoneLocation = idJSON["phoneKuaidial"].stringValue
        
        // 个人风险
        let riskJSON = json["personalRisk"]
        riskStatus = riskJSON["riskStatus"].boolValue
        let infoJSONArray = riskJSON["riskInfo"].arrayValue
        var infoArray = [String]()
        for infoJSON in infoJSONArray {
            infoArray.append(infoJSON.stringValue)
        }
        riskArray = infoArray
        
        // 逾期记录
        let overdueJSON = json["overdue"]
        overdueCount = overdueJSON["overdueNum"].stringValue
        overduePeriod = overdueJSON["overduePeriod"].stringValue
        
        // 多平台借贷记录
        let loanJSON = json["multiPlatform"]
        loanStatus = loanJSON["loanStatus"].intValue
        loanWeek = LGCreditReportLoanModel(json: loanJSON["applicationPlatformWeek"])
        loanMonth = LGCreditReportLoanModel(json: loanJSON["applicationPlatformMonth"])
        loan3Month = LGCreditReportLoanModel(json: loanJSON["applicationPlatformTMonth"])
    }
    
//    func getDetail(complete: (_ error: String?) -> Void) {
//        LGCreditService.sharedService.getCreditReport(queryID: queryID!) { <#LGCreditReportModel?#>, <#String?#>) in
//            <#code#>
//        }
//    }
}

class LGCreditReportLoanModel {
    /// 银行类
    let bankCount: Int
    
    /// 非银行类
    let noBankCount: Int
    
    /// 平台总数
    let allCount: Int
    
    init(json: JSON) {
        bankCount = json["bankTerrace"].intValue
        noBankCount = json["commonTerrace"].intValue
        allCount = json["terracevValue"].intValue
    }
    
    init() {
        bankCount = 0
        noBankCount = 0
        allCount = 0
    }
}
