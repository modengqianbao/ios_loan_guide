//
//  LGCreditCardTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 01/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LGCreditCardTableViewCell: UITableViewCell {
    static let identifier = "LGCreditCardTableViewCell"
    
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var contentLabel: UILabel!
    private var extraLabel: UILabel!
    private var extraLabelBorderView: UIView!
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
//        selectionStyle = .none
        
        // 图片
        iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(8)
            make.size.equalTo(CGSize(width: 80, height: 60))
            make.centerY.equalTo(self!)
        }
        
        // 标题
        titleLabel = UILabel()
        titleLabel.textColor = kColorTitleText
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(iconImageView.snp.right).offset(8)
            make.top.equalTo(self!).offset(14)
        }
        
        // 内容
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        contentLabel.textColor = kColorAssistText
        contentLabel.numberOfLines = 0
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        // 额外内容
        extraLabelBorderView = UIView()
        extraLabel = UILabel()
        addSubview(extraLabelBorderView)
        addSubview(extraLabel)
        
        extraLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        extraLabel.textColor = kColorExtraBorder
        extraLabel.snp.makeConstraints { [weak self] make in
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
            make.left.equalTo(contentLabel).offset(4)
            make.bottom.equalTo(self!).offset(-14)
        }
        
        extraLabelBorderView.layer.borderColor = kColorExtraBorder.cgColor
        extraLabelBorderView.backgroundColor = UIColor.clear
        extraLabelBorderView.layer.borderWidth = 1
        extraLabelBorderView.layer.cornerRadius = 3
        extraLabelBorderView.layer.masksToBounds = true
        extraLabelBorderView.snp.makeConstraints { make in
            make.top.equalTo(extraLabel).offset(-2)
            make.bottom.equalTo(extraLabel).offset(2)
            make.left.equalTo(extraLabel).offset(-4)
            make.right.equalTo(extraLabel).offset(4)
        }
        
        // 申请按钮
        applyButton = UIButton(type: .custom)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        applyButton.layer.cornerRadius = 2
        applyButton.backgroundColor = kColorMainTone
        applyButton.layer.masksToBounds = true
        applyButton.setTitle("申请", for: .normal)
        applyButton.addTarget(self, action: #selector(applyButtonOnClick), for: .touchUpInside)
        addSubview(applyButton)
        applyButton.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.right.equalTo(self!).offset(-12)
            make.size.equalTo(CGSize(width: 50, height: 30))
            make.left.equalTo(contentLabel.snp.right).offset(8)
        }
        applyButton.isHidden = true
        
        // 分割线
        let lineView = UIView()
        lineView.backgroundColor = kColorSeperatorBackground
        addSubview(lineView)
        lineView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(1)
        }
    }
    
    @objc private func applyButtonOnClick() {
        
    }
    
    func configCell(iconURLString: String, title: String, content: String, extra: String?) {
        let url = URL(string: iconURLString)
        iconImageView.kf.setImage(with: url)

        titleLabel.text = title
        contentLabel.text = content
        extraLabel.text = extra
        if extra != nil && !extra!.isEmpty {
            extraLabelBorderView.isHidden = false
        } else {
            extraLabelBorderView.isHidden = true
        }
    }
}
