//
//  LGLogoutTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGLogoutTableViewCell: UITableViewCell {
    static let identifier = "LGLogoutTableViewCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = kColorBackground
        
        let logoutLabel = UILabel()
        logoutLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        logoutLabel.textColor = kColorExtraBorder
        logoutLabel.text = "退出登录"
        addSubview(logoutLabel)
        logoutLabel.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.top.equalTo(self!).offset(16)
            make.bottom.equalTo(self!).offset(-16)
        }
    }
}
