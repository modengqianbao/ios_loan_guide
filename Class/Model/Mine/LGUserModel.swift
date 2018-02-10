//
//  LGUserModel.swift
//  LoanGuide
//
//  Created by 喂草。 on 02/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

class LGUserModel {
    static let currentUser = LGUserModel()
    
    private let keyPhone = "phone"
    private let keyStatus = "status"
    private let keyIDNumber = "idNumber"
    private let keyName = "name"
    private let keyMark = "mark"
    
    private init() {
        isVerified = false
        
        loadUserData()
    }
    
    /// 是否已登录
    var isLogin: Bool {
        get {
            return phone != nil
        }
    }
    
    /// 用户手机号
    var phone: String?    
    
    /// 是否已认证
    var isVerified: Bool
    
    /// 用户身份证
    var idNumber: String?
    
    /// 用户姓名
    var name: String?
    
    /// 芝麻分
    var mark: String?
    
    /// 用户登录成功
    func login(phoneNumber: String) {
        phone = phoneNumber
        saveValue(phoneNumber, forKey: keyPhone)
    }
    
    /// 用户已认证
    func verificated(idNumber: String, mark: String, name: String) {
        isVerified = true
        
        self.idNumber = idNumber
        self.mark = mark
        self.name = name
        
        saveValue(isVerified, forKey: keyStatus)
        saveValue(idNumber, forKey: keyIDNumber)
        saveValue(mark, forKey: keyMark)
        saveValue(name, forKey: keyName)
    }
    
    /// 用户退出登录
    func logout() {
        phone = nil
        isVerified = false
        idNumber = nil
        name = nil
        mark = nil
        
        // 清空本地数据
        deleteValueFor(key: keyPhone)
        deleteValueFor(key: keyStatus)
        deleteValueFor(key: keyIDNumber)
        deleteValueFor(key: keyMark)
        deleteValueFor(key: keyName)
    }
    
    private func loadUserData() {
        // 用户数据
        phone = loadValueFor(key: keyPhone) as? String
        
        if loadValueFor(key: keyStatus) == nil {
            isVerified = false
        } else {
            isVerified = true
        }
    
        idNumber = loadValueFor(key: keyIDNumber) as? String
        mark = loadValueFor(key: keyMark) as? String
        name = loadValueFor(key: keyName) as? String
    }    
    
    /// 储存用户数据
    private func saveValue(_ value: Any, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    /// 读取用户数据
    private func loadValueFor(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    /// 清楚用户数据
    private func deleteValueFor(key: String) {
        UserDefaults.standard.set(nil, forKey: key)
    }
}
