//
//  LGDropMenuTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 31/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGDropMenuTableViewCell: UITableViewCell {
    static let identifier = "LGDropMenuTableViewCell"
    
    private var titleLabel: UILabel!
    private var contentLabel: UILabel!
    
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
        
        // 标签
        titleLabel = UILabel()
        titleLabel.textColor = kColorTitleText
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(10)
            make.top.equalTo(self!).offset(12)
            make.bottom.equalTo(self!).offset(-12)
        }
        
        // 内容
        contentLabel = UILabel()
        contentLabel.textColor = kColorAssistText
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.right.equalTo(self!).offset(-8)            
        }
    }
    
    func configCell(title: String, content: String?) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
