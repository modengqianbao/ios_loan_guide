//
//  LGCreditProductDatabaseModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 06/03/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import RealmSwift

class LGCreditProductDatabaseModel: Object {
    @objc dynamic var name = "creditProduct"
    
    /// 是否首页使用
    @objc dynamic var isForHome: Bool = false
    
    /// logo图片地址
    @objc dynamic var logoURL: String = ""
    
    /// 名称
    @objc dynamic var creditName:String = ""
    
    /// 链接地址
    @objc dynamic var urlString: String = ""
    
    /// ID
    @objc dynamic var id: Int = 0
    
    /// 简介
    @objc dynamic var introduce: String = ""
    
    /// 标签（ad）
    @objc dynamic var label: String? = nil
    
    /// 状态 1，马上抢 2，可申请 3.已抢光
    @objc dynamic var status: Int = 1
    
    /// 日期时间
    @objc dynamic var timeInt: Int = 0
    
    func setup(isForHome: Bool, model: LGCreditProductModel) {
        self.isForHome = isForHome
        logoURL = model.logoURL
        creditName = model.name
        urlString = model.urlString
        id = model.id
        introduce = model.introduce
        label = model.label
        status = model.status
        timeInt = model.timeInt
    }
}
