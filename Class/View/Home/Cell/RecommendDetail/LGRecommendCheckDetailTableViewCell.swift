//
//  LGRecommendCheckDetailTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGRecommendCheckDetailTableViewCell: UITableViewCell {
    static let identifier = "LGRecommendCheckDetailTableViewCell"

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
        
        // 查看详情
        let checkString = "查看详情"
        let attributedCheckString = NSMutableAttributedString(string: checkString)
        let checkImage = UIImage(named: "detail_arrow_r")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = checkImage        
        attributedCheckString.addAttribute(NSAttributedStringKey.font,
                                          value: UIFont.systemFont(ofSize: 14, weight: .regular),
                                          range: NSRange.init(location: 0, length: checkString.count))
        attributedCheckString.addAttribute(NSAttributedStringKey.foregroundColor,
                                          value: kColorAssistText,
                                          range: NSRange.init(location: 0, length: checkString.count))
        attributedCheckString.insert(NSAttributedString(attachment: imageAttachment), at: 4)
        let checkLabel = UILabel()
        checkLabel.attributedText = attributedCheckString
        addSubview(checkLabel)
        checkLabel.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.top.equalTo(self!).offset(8)
            make.bottom.equalTo(self!).offset(-8)
        }
    }
}
