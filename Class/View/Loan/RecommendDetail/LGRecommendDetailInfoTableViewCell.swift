//
//  LGRecommendDetailInfoTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 30/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGRecommendDetailInfoTableViewCell: UITableViewCell {
    static let identifier = "LGRecommendDetailInfoTableViewCell"
    
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var checkImageView: UIImageView!
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
        
        // 图标
        iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "detail_personal_end")
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(20)
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalTo(self!).offset(12)
            make.bottom.equalTo(self!).offset(-12)
        }
        
        // 标题
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = kColorTitleText
        titleLabel.text = "个人信息"
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(8)
        }
        
        // 已认证/未认证
        let arrowImageView = UIImageView(image: UIImage(named: "detail_arrow_r"))
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(self!).offset(-12)
        }
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        contentLabel.text = "已认证"
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(arrowImageView.snp.left).offset(-12)
        }
        
        checkImageView = UIImageView(image: UIImage(named: "report_verified"))
        addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(contentLabel.snp.left).offset(-6)
        }
    }
    
    func configCell(isVerified: Bool) {
        if !isVerified {
            checkImageView.image = UIImage(named: "report_alert")
            contentLabel.text = "未认证"
        } else {
            checkImageView.image = UIImage(named: "report_verified")
            contentLabel.text = "已认证"
        }
    }
}
