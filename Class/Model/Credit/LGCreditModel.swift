//
//  LGCreditModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGCreditModel {
    var creditCardArray = [LGCreditProductModel]()
    
    let bankTypeArray = ["全部银行", "招商银行", "浦发银行", "兴业银行", "民生银行"]
    var selectedBankType = 0
    
    let levelTypeArray = ["全部等级", "普通卡", "金卡", "白金卡"]
    let levelContentArray = ["", "额度普遍在1000-30000元之间", "额度普遍在5000-50000元之间", "白金级消费待遇"]
    var selectedLevelType = 0
    
    let usageTypeArray = ["全部用途", "标准卡", "特色主题卡", "网络联名卡", "酒店/商旅/航空卡", "现取卡"]
    let usageContentArray = ["", "银行标准服务", "特色主题专享", "qq，淘宝等联名专属优惠", "酒店出行、航空等超值优惠", "超高取现比例"]
    var selectedUsageType = 0
    
    /// 获取信用卡列表
    func getCreditCardArray(complete: @escaping (_ error: String?) -> Void) {
        LGCreditCarService.sharedService.getCreditCarList(bank: selectedBankType, grade: selectedLevelType, purpose: selectedUsageType) { [weak self] array, error in
            if error == nil {
                self!.creditCardArray = array!
                complete(nil)
            } else {
                complete(error)
            }
        }
    }
}
