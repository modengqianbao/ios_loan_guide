//
//  String+Index.swift
//  LoanGuide
//
//  Created by 喂草。 on 11/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    /// 把部分转换成星号
    func hide(fromIndex: Int, toIndex: Int) -> String {
        let startString = self[0..<fromIndex]
        let endString = self[toIndex..<count]
        let starString = String(repeating: "*", count: toIndex - fromIndex)
        return startString.appending(starString).appending(endString)
        
//        idNumber = LGUserModel.currentUser.idNumber!
//        let startString = idNumber![0..<6]
//        let endString = idNumber![(idNumber!.count - 2)..<idNumber!.count]
//        let starString = String(repeating: "*", count: idNumber!.count - 8)
//        idNumber! = startString.appending(starString).appending(endString)
    }
    
//    var urlParameters: [String: AnyObject]? {
//        // 判断是否有参数
//        guard let start = self.range(of: "?") else {
//            return nil
//        }
//        
//        var params = [String: AnyObject]()
//        // 截取参数
//        let index = self.index(start, offsetBy: 1)
////        let index = start.startIndex.advancedBy(1)
//        let paramsString = substringFromIndex(index)
//        
//        // 判断参数是单个参数还是多个参数
//        if paramsString.containsString("&") {
//            
//            // 多个参数，分割参数
//            let urlComponents = paramsString.componentsSeparatedByString("&")
//            
//            // 遍历参数
//            for keyValuePair in urlComponents {
//                // 生成Key/Value
//                let pairComponents = keyValuePair.componentsSeparatedByString("=")
//                let key = pairComponents.first?.stringByRemovingPercentEncoding
//                let value = pairComponents.last?.stringByRemovingPercentEncoding
//                // 判断参数是否是数组
//                if let key = key, value = value {
//                    // 已存在的值，生成数组
//                    if let existValue = params[key] {
//                        if var existValue = existValue as? [AnyObject] {
//                            
//                            existValue.append(value)
//                        } else {
//                            params[key] = [existValue, value]
//                        }
//                        
//                    } else {
//                        
//                        params[key] = value
//                    }
//                    
//                }
//            }
//            
//        } else {
//            
//            // 单个参数
//            let pairComponents = paramsString.componentsSeparatedByString("=")
//            
//            // 判断是否有值
//            if pairComponents.count == 1 {
//                return nil
//            }
//            
//            let key = pairComponents.first?.stringByRemovingPercentEncoding
//            let value = pairComponents.last?.stringByRemovingPercentEncoding
//            if let key = key, value = value {
//                params[key] = value
//            }
//            
//        }
//        
//        
//        return params
//    }
}
