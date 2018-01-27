//
//  LGMineTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 27/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGMineTableViewCell: UITableViewCell {
    static let identifier = "LGMineTableViewCell"
    
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var separatorLine: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 图标
        iconImageView = UIImageView()
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.left.equalTo(self!).offset(12)
        }
        
        // 标签
        titleLabel = UILabel()
        titleLabel.textColor = kColorAssistText
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.sizeToFit()
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.left.equalTo(self!.iconImageView.snp.right).offset(12)
        }
        
        // 分割线
        separatorLine = UIView()
        separatorLine.backgroundColor = kColorSeperatorBackground
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { [weak self] make in
            make.bottom.left.right.equalTo(self!)
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(icon: UIImage?, title: String, hideSeparator: Bool) {
        iconImageView.image = icon
        titleLabel.text = title
        separatorLine.isHidden = hideSeparator
    }
}
