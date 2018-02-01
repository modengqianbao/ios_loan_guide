//
//  LGNormalDetailApplyTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 01/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGNormalDetailApplyTableViewCell: UITableViewCell {
    static let identifier = "LGNormalDetailApplyTableViewCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = kColorBackground
        selectionStyle = .none
        
        // 按钮
        let applyButton = UIButton(type: .custom)
        applyButton.backgroundColor = kColorMainTone
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        applyButton.setTitleColor(UIColor.white, for: .normal)
        applyButton.setTitle("立即申请", for: .normal)
        applyButton.layer.cornerRadius = 2
        applyButton.layer.masksToBounds = true
        applyButton.addTarget(self, action: #selector(applyButtonOnClick), for: .touchUpInside)
        addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24))
            make.height.equalTo(45)
        }
    }
    
    @objc private func applyButtonOnClick() {
        
    }
}
