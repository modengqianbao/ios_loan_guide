//
//  LGReportRecommendTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 18/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

class LGReportRecommendTableViewCell: UITableViewCell {
    static let identifier = "LGReportRecommendTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        let recommendLabel = UILabel()
        recommendLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        recommendLabel.textColor = kColorAssistText
        recommendLabel.text = "为您推荐"
        recommendLabel.textAlignment = .center
        addSubview(recommendLabel)
        recommendLabel.snp.makeConstraints { [weak self] make in
            make.center.equalTo(self!)
            make.top.equalTo(self!).offset(4)
            make.bottom.equalTo(self!).offset(-4)
        }
        
        let leftLineView = UIView()
        let rightLineView = UIView()
        leftLineView.backgroundColor = kColorHintText
        rightLineView.backgroundColor = kColorHintText
        addSubview(leftLineView)
        addSubview(rightLineView)
        leftLineView.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!)
            make.right.equalTo(recommendLabel.snp.left)
            make.centerY.equalTo(recommendLabel)
            make.height.equalTo(1)
        }
        rightLineView.snp.makeConstraints { [weak self] make in
            make.left.equalTo(recommendLabel.snp.right)
            make.centerY.equalTo(recommendLabel)
            make.right.equalTo(self!)
            make.height.equalTo(1)
        }
    }
}
