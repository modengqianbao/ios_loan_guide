//
//  LGMineModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGMineModel {
    // 常见问题
    var questionArray: [[LGQuestionModel]]?
    var questionHeaderArray: [String]?
    
    // 消息中心
    var messageArray: [LGMessageModel]?
    var messagePage = 1
    var messagePageSize = 10
    
    init() {

    }
    
    // 加载消息
    func loadMoreMessages(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        messagePage += 1
        LGMineService.sharedService.getMessage(page: messagePage, count: messagePageSize) { [weak self] array, error in
            if error == nil {
                if self!.messageArray != nil {
                    self!.messageArray!.append(contentsOf: array!)
                } else {
                    self!.messageArray = array
                }
                if array!.count < self!.messagePageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
    
    func reloadMessages(complete: @escaping (_ hasMore: Bool, _ error: String?) -> Void) {
        messagePage = 1
        LGMineService.sharedService.getMessage(page: messagePage, count: messagePageSize) { [weak self] array, error in
            if error == nil {
                self!.messageArray = array
                if array!.count < self!.messagePageSize {
                    complete(false, nil)
                } else {
                    complete(true, nil)
                }
            } else {
                complete(false, error)
            }
        }
    }
}
