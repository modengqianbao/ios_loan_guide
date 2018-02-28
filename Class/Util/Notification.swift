//
//  Notification.swift
//  LoanGuide
//
//  Created by 喂草。 on 02/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation

/// 退出登录通知
let kNotificationLogout = Notification(name: Notification.Name("logout"))

/// 登录通知
let kNotificationLogin = Notification(name: Notification.Name("login"))

/// 身份认证成功
let kNotificationVerification = Notification(name: Notification.Name("verification"))

/// 登录过期
let kNotificationLoginExpired = Notification(name: Notification.Name("loginExpired"))
