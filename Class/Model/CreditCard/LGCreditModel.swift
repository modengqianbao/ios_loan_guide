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
    
    var bankTypeArray: [LGCreditBankModel]
    var selectedBankType = 0
    
    let levelTypeArray = ["全部等级", "普通卡", "金卡", "白金卡"]
    let levelContentArray = ["", "额度普遍在1000-30000元之间", "额度普遍在5000-50000元之间", "白金级消费待遇"]
    var selectedLevelType = 0
    
    let usageTypeArray = ["全部用途", "标准卡", "特色主题卡", "网络联名卡", "酒店/商旅/航空卡", "现取卡"]
    let usageContentArray = ["", "银行标准服务", "特色主题专享", "qq，淘宝等联名专属优惠", "酒店出行、航空等超值优惠", "超高取现比例"]
    var selectedUsageType = 0
    
    init() {
        let bank0 = LGCreditBankModel(bankName: "全部银行", bankID: 0)
//        let bank1 = LGCreditBankModel(bankName: "招商银行", bankID: 1)
//        let bank2 = LGCreditBankModel(bankName: "浦发银行", bankID: 2)
//        let bank3 = LGCreditBankModel(bankName: "兴业银行", bankID: 3)
//        let bank4 = LGCreditBankModel(bankName: "民生银行", bankID: 4)
        bankTypeArray = [bank0]//, bank1, bank2, bank3, bank4]
    }
    
    /// 获取信用卡列表
    func getCreditCardArray(complete: @escaping (_ error: String?) -> Void) {
        let bankItem = bankTypeArray[selectedBankType]
        LGCreditCarService.sharedService.getCreditCarList(bank: bankItem.id, grade: selectedLevelType, purpose: selectedUsageType) { [weak self] array, error in
            if error == nil {
                self!.creditCardArray = array!
                
                complete(nil)
            } else {
                complete(error)
            }
        }
    }
    
    /// 获取银行列表
    func getCreditBankArray(complete: ((_ error: String?) -> Void)?) {
        LGCreditCarService.sharedService.getBankList { [weak self] array, error in
            if error == nil {
                self!.bankTypeArray = array!
                let bank0 = LGCreditBankModel(bankName: "全部银行", bankID: 0)
                self!.bankTypeArray.insert(bank0, at: 0)
                complete?(nil)
            } else {
                complete?(error)
            }
        }
    }
}
