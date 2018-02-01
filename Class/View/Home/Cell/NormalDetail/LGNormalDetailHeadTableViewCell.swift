//
//  LGNormailDetailHeadTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 01/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

class LGNormalDetailHeadTableViewCell: UITableViewCell {
    static let identifier = "LGNormalDetailHeadTableViewCell"
    
    private var iconImageView: UIImageView!
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
        
        // 背景图
        let backgoundImageView = UIImageView(image: UIImage(named: "bg_detail2"))
        addSubview(backgoundImageView)
        backgoundImageView.snp.makeConstraints { [weak self] make in
            make.left.right.top.bottom.equalTo(self!)
        }
        
        // 导航块
        let naviView = UIView()
        naviView.backgroundColor = UIColor.clear
        addSubview(naviView)
        naviView.snp.makeConstraints { [weak self] make in
            make.left.right.equalTo(self!)
            make.height.equalTo(44)
            make.top.equalTo(self!).offset(20)
        }
        
        // 返回
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "nav_back_white"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonOnClick), for: .touchUpInside)
        naviView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(naviView).offset(4)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(naviView)
        }
        
        // 分享
        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "nav_share"), for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonOnClick), for: .touchUpInside)
        naviView.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(naviView)
            make.right.equalTo(naviView).offset(-12)
        }
        
        // 标题
        let iconRadius = CGFloat(30)
        iconImageView = UIImageView()
        iconImageView.backgroundColor = UIColor.red
        iconImageView.layer.cornerRadius = iconRadius
        iconImageView.layer.masksToBounds = true
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.size.equalTo(CGSize(width: iconRadius * 2,
                                     height: iconRadius * 2))
            make.top.equalTo(self!).offset(32)
        }
        
        titleLabel = UILabel()
        titleLabel.text = "拍拍贷"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView)
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
        }
        
        // 详情
        let font = UIFont.systemFont(ofSize: 13, weight: .regular)
        let color = UIColor.white
        let limitLabel = UILabel()
        limitLabel.textColor = color
        limitLabel.font = font
        limitLabel.text = "贷款额度"
        addSubview(limitLabel)
        limitLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        let rateRangeLabel = UILabel()
        rateRangeLabel.font = font
        rateRangeLabel.textColor = color
        rateRangeLabel.text = "利率范围"
        addSubview(rateRangeLabel)
        rateRangeLabel.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(limitLabel)
            make.left.equalTo(self!.snp.centerX).offset(20)
        }
        
        let methodLabel = UILabel()
        methodLabel.font = font
        methodLabel.textColor = color
        methodLabel.text = "还款方式"
        addSubview(methodLabel)
        methodLabel.snp.makeConstraints { make in
            make.left.equalTo(limitLabel)
            make.top.equalTo(limitLabel.snp.bottom).offset(12)
        }
        
        let timeRangeLabel = UILabel()
        timeRangeLabel.font = font
        timeRangeLabel.textColor = color
        timeRangeLabel.text = "期限范围"
        addSubview(timeRangeLabel)
        timeRangeLabel.snp.makeConstraints { make in
            make.left.equalTo(rateRangeLabel)
            make.top.equalTo(rateRangeLabel.snp.bottom).offset(12)
        }
    }
    
    @objc private func backButtonOnClick() {
        
    }
    
    @objc private func shareButtonOnClick() {
        
    }
}
