//
//  LGMessageTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGMessageTableViewCell: UITableViewCell {
    static let identifier = "LGMessageTableViewCell"
    
    private var dateLabel: UILabel!
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
        backgroundColor = kColorSeperatorBackground
        selectionStyle = .none
        
        // 日期
        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = kColorAssistText
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.top.equalTo(self!).offset(12)
        }
        
        // 横线
        let leftLineView = UIView()
        let rightLineView = UIView()
        leftLineView.backgroundColor = kColorHintText
        rightLineView.backgroundColor = kColorHintText
        addSubview(leftLineView)
        addSubview(rightLineView)
        leftLineView.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(dateLabel)
            make.left.equalTo(self!)
            make.right.equalTo(dateLabel.snp.left).offset(-8)
            make.height.equalTo(1)
        }
        rightLineView.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(dateLabel)
            make.right.equalTo(self!)
            make.left.equalTo(dateLabel.snp.right).offset(8)
            make.height.equalTo(1)
        }
        
        // 内容背景
        let whiteView = UIView()
        whiteView.backgroundColor = kColorBackground
        whiteView.layer.cornerRadius = 5
        whiteView.layer.masksToBounds = true
        addSubview(whiteView)
        whiteView.snp.makeConstraints { [weak self] make in
            make.bottom.equalTo(self!)
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.left.equalTo(self!).offset(12)
            make.right.equalTo(self!).offset(-12)
        }
        
        // 标题
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = kColorTitleText
        whiteView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(whiteView).offset(10)
            make.top.equalTo(whiteView).offset(14)
        }
        
        // 内容
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentLabel.textColor = kColorAssistText
        contentLabel.numberOfLines = 0
        whiteView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(whiteView).offset(10)
            make.right.equalTo(whiteView).offset(-10)
            make.bottom.equalTo(whiteView).offset(-14)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    func configCell(dateString: String, title: String?, content: String?) {
        dateLabel.text = dateString
        titleLabel.text = title
        contentLabel.text = content
    }
}
