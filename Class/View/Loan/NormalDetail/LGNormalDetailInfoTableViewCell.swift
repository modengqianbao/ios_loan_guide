//
//  LGNormalDetailInfoTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 05/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGNormalDetailInfoTableViewCell: UITableViewCell {
    static let identifier = "LGNormalDetailInfoTableViewCell"
    
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
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = kColorTitleText
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(20)
            make.top.equalTo(self!).offset(5)
            make.bottom.equalTo(self!).offset(-5)
        }
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentLabel.textColor = kColorAssistText
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right)
        }
    }
    
    func configCell(title: String?, content: String?) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
