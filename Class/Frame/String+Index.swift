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
}
