//
//  LGReportProfileTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 17/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGReportProfileTableViewCell: UITableViewCell {
    static let identifier = "LGReportProfileTableViewCell"
    
    private var nameLabel: UILabel!
    private var idLabel: UILabel!
    private var phoneLabel: UILabel!
    private var statusLabel: UILabel!
    
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
        
        // 蓝色底
        let backBlueView = UIView()
        backBlueView.backgroundColor = UIColor(red:0.29, green:0.70, blue:0.98, alpha:1.00)
        addSubview(backBlueView)
        backBlueView.snp.makeConstraints { [weak self] make in
            make.left.right.top.equalTo(self!)
            make.height.equalTo(30)
        }
        
        // 内容框
        let whiteView = UIView()
        whiteView.backgroundColor = kColorBackground
        whiteView.layer.cornerRadius = 5
        whiteView.layer.shadowColor = UIColor.black.cgColor
        whiteView.layer.shadowRadius = 1
        whiteView.layer.shadowOpacity = 0.2
        whiteView.layer.shadowOffset = CGSize(width: 0, height: 1)
        addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 4, left: 12, bottom: 12, right: 12))
        }
        
        // 名字
        nameLabel = UILabel()
        nameLabel.textColor = kColorTitleText
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        nameLabel.text = "李克喂"
        whiteView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(whiteView).offset(10)
            make.top.equalTo(whiteView).offset(12)
        }
        
        // 身份证号
        idLabel = UILabel()
        idLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        idLabel.textColor = kColorAssistText
//        idLabel.text = "身份证号：123456789123456789（福建 泉州）"
        whiteView.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.right.equalTo(whiteView).offset(-4)
        }
        
        // 手机号
        phoneLabel = UILabel()
        phoneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        phoneLabel.textColor = kColorAssistText
//        phoneLabel.text = "手机号：12345678912（四川 成都）"
        whiteView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.left.equalTo(idLabel)
            make.top.equalTo(idLabel.snp.bottom).offset(8)
            make.bottom.equalTo(whiteView).offset(-12)
        }
        
        // 是否已验证
        statusLabel = UILabel()
//        statusLabel.text = "已验证"
        whiteView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(whiteView).offset(-12)
        }
    }
    
    private func setupVerifyStatuLabel(isVerified: Bool) {
        if isVerified {
            let string = " 已验证"
            let imageAttachment = NSTextAttachment()
            let icon = UIImage(named: "report_verified")!
            imageAttachment.image = icon
            imageAttachment.bounds = CGRect(x: 0,
                                            y: -1,
                                            width: icon.size.width,
                                            height: icon.size.height)
            
            let textAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13, weight: .regular),
                                  NSAttributedStringKey.foregroundColor: UIColor(red:0.31, green:0.67, blue:0.32, alpha:1.00)]
            let attributedString = NSMutableAttributedString(string: string,
                                                             attributes: textAttributes)
            attributedString.insert(NSAttributedString(attachment: imageAttachment), at: 0)
            statusLabel.attributedText = attributedString
        } else {
            let string = " 未验证"
            let imageAttachment = NSTextAttachment()
            let icon = UIImage(named: "report_alert")!
            imageAttachment.image = icon
            imageAttachment.bounds = CGRect(x: 0,
                                            y: -1,
                                            width: icon.size.width,
                                            height: icon.size.height)
            
            let textAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13, weight: .regular),
                                  NSAttributedStringKey.foregroundColor: UIColor(red:0.88, green:0.17, blue:0.26, alpha:1.00)]
            let attributedString = NSMutableAttributedString(string: string,
                                                             attributes: textAttributes)
            attributedString.insert(NSAttributedString(attachment: imageAttachment), at: 0)
            statusLabel.attributedText = attributedString
        }
    }
    
    func configCell(name: String?, isVerified: Bool, idNumber: String, idLocation: String, phone: String, phoneLocation: String) {
        nameLabel.text = name
        setupVerifyStatuLabel(isVerified: isVerified)
        idLabel.text = "身份证号：\(idNumber)（\(idLocation)）"
        phoneLabel.text = "手机号：\(phone)（\(phoneLocation)）"
    }
}
