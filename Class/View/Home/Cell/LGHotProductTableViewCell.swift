//
//  LGHotProductTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 27/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import Kingfisher

class LGHotProductTableViewCell: UITableViewCell {
    static let identifier = "LGHotProductTableViewCell"
    
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var adLabel: UILabel!
    private var adBorderView: UIView!
    private var moneyLabel: UILabel!
    private var describeLabel: UILabel!
    private var applyButton: UIButton!
    
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
        let iconRadius = CGFloat(25)
        iconImageView = UIImageView()
        iconImageView.layer.cornerRadius = iconRadius
        iconImageView.layer.masksToBounds = true
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.left.equalTo(self!).offset(12)
            make.size.equalTo(CGSize(width: iconRadius * 2,
                                     height: iconRadius * 2))
        }
        
        // 标题
        titleLabel = UILabel()
        titleLabel.textColor = kColorTitleText
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(iconImageView.snp.right).offset(8)
            make.top.equalTo(self!).offset(12)
        }
        
        // 广告和广告框框
        let redColor = kColorExtraBorder
        adLabel = UILabel()
        adLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        adLabel.textColor = redColor
        addSubview(adLabel)
        adLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(8)
        }
        
        adBorderView = UIView()
        adBorderView.backgroundColor = UIColor.clear
        adBorderView.layer.cornerRadius = 3
        adBorderView.layer.borderColor = redColor.cgColor
        adBorderView.layer.borderWidth  = 1
        adBorderView.layer.masksToBounds = true
        adLabel.addSubview(adBorderView)
        adBorderView.snp.makeConstraints { make in
            make.top.equalTo(adLabel).offset(-2)
            make.bottom.equalTo(adLabel).offset(2)
            make.left.equalTo(adLabel).offset(-4)
            make.right.equalTo(adLabel).offset(4)
        }
        
        // 利率
        moneyLabel = UILabel()
        moneyLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        moneyLabel.textColor = kColorHintText
        addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        // 申请按钮
        applyButton = UIButton(type: .custom)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        applyButton.layer.cornerRadius = 3
        applyButton.backgroundColor = kColorMainTone
        applyButton.layer.masksToBounds = true
        applyButton.setTitle("申请", for: .normal)
        addSubview(applyButton)
        applyButton.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.right.equalTo(self!).offset(-12)
            make.size.equalTo(CGSize(width: 50, height: 30))
        }
        
        // 介绍
        describeLabel = UILabel()
        describeLabel.textColor = kColorAssistText
        describeLabel.setContentHuggingPriority(.init(200), for: .horizontal)
        describeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        addSubview(describeLabel)
        describeLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(moneyLabel.snp.bottom).offset(4)
            make.bottom.equalTo(self!).offset(-12)
            make.right.lessThanOrEqualTo(applyButton.snp.left).offset(-12)
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

    func configCell(iconURLString: String?, title: String, adString: String?, moneyString: String, describeString: String) {
        if iconURLString != nil {
            let url = URL(string: iconURLString!)
            iconImageView.kf.setImage(with: url)
        }
        titleLabel.text = title
        adLabel.text = adString
        if adString != nil && !adString!.isEmpty {
            adBorderView.isHidden = false
        } else {
            adBorderView.isHidden = true
        }
        moneyLabel.text = moneyString
        describeLabel.text = describeString        
    }
}
