//
//  Define.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

//MARK:- 应用
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

//MARK:- 颜色
/// 主色调
let kColorMainTone = UIColor("#448EEC")

/// 置灰的按钮
let kColorGrey = UIColor("#C8CDD2")

/// 主背景色
let kColorBackground = UIColor("#FFFFFF")

/// 分隔背景色
let kColorSeperatorBackground = UIColor("#F5F7FA")

/// 分割线和边框颜色
let kColorBorder = UIColor("#E1E1E1")

/// 下拉框选中色
let kColorSelected = UIColor("#EDF3FB")

/// 主要标题问题
let kColorTitleText = UIColor("#333")

/// 辅助性文字
let kColorAssistText = UIColor("#999")

/// 提示文字
let kColorHintText = UIColor("#C3C3C3")

/// 框框红色
let kColorExtraBorder = UIColor(red:0.85, green:0.13, blue:0.16, alpha:1.00)

//MARK:- 字体
///

//MARK:- URL
///
var isTesting = true
/// 域名
let domain = isTesting ? "http://creditproduct.test.cdecube.com/api/android/" : "http://wallet.cdxiaoshudian.com/api/android/"
