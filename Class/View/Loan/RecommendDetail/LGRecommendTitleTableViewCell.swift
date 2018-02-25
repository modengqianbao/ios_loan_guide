//
//  LGRecommendTitleTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 30/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGRecommendTitleTableViewCell: UITableViewCell {
    static let identifier = "LGRecommendTitleTableViewCell"
    
    private var titleLabel: UILabel!
    
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
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = kColorTitleText
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(20)
            make.top.bottom.equalTo(self!)
            make.height.equalTo(30)
        }
        
        // 分割线
        let lineView = UIView()
        lineView.backgroundColor = kColorSeperatorBackground
        addSubview(lineView)
        lineView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(1)
        }
    }
    
    func configCell(title: String) {
        titleLabel.text = title
    }
}
