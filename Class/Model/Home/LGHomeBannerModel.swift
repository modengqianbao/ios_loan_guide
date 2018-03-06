//
//  LGHomeBannerModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 06/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
import SwiftyJSON

class LGHomeBannerModel {
    /// 产品ID
    var id: Int
    
    /// 图片url
    var imageURLString: String
    
    /// 产品名
    var name: String
    
    /// 产品类型：1申请也，2详情页
    var type: Int
    
    init(json: JSON) {
        id = json["id"].intValue
        imageURLString = json["imgUrl"].stringValue
        name = json["name"].stringValue
        type = json["type"].intValue
    }
    
    init(databaseModel model: LGBannerDatabaseModel) {
        id = model.id
        imageURLString = model.imageURLString
        name = model.bannerName
        type = model.type
    }
}
