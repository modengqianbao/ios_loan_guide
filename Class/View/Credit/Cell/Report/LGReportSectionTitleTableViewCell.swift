//
//  LGReportSctionTitleTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 18/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGReportSectionTitleTableViewCell: UITableViewCell {
    static let identifier = "LGReportSectionTitleTableViewCell"
    
    enum Status {
        case red
        case blue
        case green
    }
    
    private var titleLabel: UILabel!
    private var statusLabel: UILabel!
    
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
        
        // 蓝色方块
        let blueView = UIView()
        blueView.backgroundColor = kColorMainTone
        addSubview(blueView)
        blueView.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(8)
            make.top.equalTo(self!).offset(8)
            make.bottom.equalTo(self!).offset(-8)
            make.width.equalTo(3)
            make.height.equalTo(16)
        }
        
        // 标题
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = kColorAssistText
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(blueView.snp.right).offset(8)
            make.centerY.equalTo(blueView)
        }
        
        // 状态
        statusLabel = UILabel()
        addSubview(statusLabel)
        statusLabel.snp.makeConstraints { [weak self] make in
            make.right.equalTo(self!).offset(-12)
            make.centerY.equalTo(blueView)
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
    
    func configCell(title: String?, statusString: String, status: Status) {
        titleLabel.text = title
        switch status {
        case .red:
            let attributedString = checkString(string: statusString,
                                               color: UIColor.red,
                                               icon: UIImage(named: "report_alert")!)
            statusLabel.attributedText = attributedString
        case .green:
            let attributedString = checkString(string: statusString,
                                               color: UIColor(red:0.31, green:0.67, blue:0.32, alpha:1.00),
                                               icon: UIImage(named: "report_verified")!)
            statusLabel.attributedText = attributedString
        case .blue:
            let attributedString = checkString(string: statusString,
                                               color: kColorMainTone,
                                               icon: UIImage(named: "report_blue")!)
            statusLabel.attributedText = attributedString
        }
    }
    
    private func checkString(string: String, color: UIColor, icon: UIImage) -> NSMutableAttributedString {
        let newString = " ".appending(string)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = icon
        imageAttachment.bounds = CGRect(x: 0,
                                        y: -1,
                                        width: icon.size.width,
                                        height: icon.size.height)
        
        let textAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13, weight: .regular),
                              NSAttributedStringKey.foregroundColor: color]
        let attributedString = NSMutableAttributedString(string: newString,
                                                         attributes: textAttributes)
        attributedString.insert(NSAttributedString(attachment: imageAttachment), at: 0)
        
        return attributedString
    }
}
