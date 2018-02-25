//
//  LGRecommendDetailCreditTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 31/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGRecommendDetailCreditTableViewCell: UITableViewCell {
    static let identifier = "LGRecommendDetailCreditTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = kColorBackground
        
        let titleLabel = UILabel()
        titleLabel.textColor = kColorTitleText
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.text = "信用知多少"
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(24)
            make.top.equalTo(self!).offset(20)
            make.bottom.equalTo(self!).offset(-20)
        }
        
        let arrowImageView = UIImageView(image: UIImage(named: "detail_arrow_r"))
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { [weak self] make in
            make.right.equalTo(self!).offset(-8)
            make.centerY.equalTo(self!)
        }
        
        let checkLabel = UILabel()
        checkLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        checkLabel.textColor = kColorAssistText
        checkLabel.text = "查看报告"
        addSubview(checkLabel)
        checkLabel.snp.makeConstraints { make in
            make.centerY.equalTo(arrowImageView)
            make.right.equalTo(arrowImageView.snp.left).offset(-12)
        }
    }
}
