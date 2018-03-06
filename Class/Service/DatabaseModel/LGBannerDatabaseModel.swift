//
//  LGBannerDatabaseModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 06/03/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import RealmSwift

class LGBannerDatabaseModel: Object {
    @objc dynamic var name = "banner"
    
    /// 产品ID
    @objc dynamic var id: Int = 0
    
    /// 图片url
    @objc dynamic var imageURLString: String = ""
    
    /// 产品名
    @objc dynamic var bannerName: String = ""
    
    /// 产品类型：1申请也，2详情页
    @objc dynamic var type: Int = 0
    
    func setup(model: LGHomeBannerModel) {
        id = model.id
        imageURLString = model.imageURLString
        bannerName = model.name
        type = model.type
    }
}
