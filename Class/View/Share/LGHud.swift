//
//  LGHud.swift
//  LoanGuide
//
//  Created by 喂草。 on 02/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import MBProgressHUD

class LGHud {
    class func show(in view: UIView, animated: Bool, text: String?) {
        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        hud.mode = .text
        hud.label.text = text
        hud.label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        hud.label.numberOfLines = 0
        hud.hide(animated: true, afterDelay: 2)
    }
}
