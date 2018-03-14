//
//  LGInviteCodeTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 13/03/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGInviteCodeTableViewCell: UITableViewCell {
    static let identifier = "LGInviteCodeTableViewCell"
    
    private var inviteCodeLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = kColorTitleText
        titleLabel.text = "经理人邀请码"
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(20)
            make.top.equalTo(self!).offset(12)
            make.bottom.equalTo(self!).offset(-12)
        }
        
        inviteCodeLabel = UILabel()
        inviteCodeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        inviteCodeLabel.textColor = kColorAssistText
        addSubview(inviteCodeLabel)
        inviteCodeLabel.snp.makeConstraints { [weak self] make in
            make.right.equalTo(self!).offset(-12)
            make.centerY.equalTo(self!)
        }
    }
    
    func configCell(inviteCode: String?) {
        if inviteCode != nil {
            inviteCodeLabel.text = inviteCode
        } else {
            inviteCodeLabel.text = "请输入邀请码"
        }
    }
}
