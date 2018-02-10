//
//  LGCreditCheckInfoTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 10/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGCreditCheckInfoTableViewCell: UITableViewCell {
    static let identifier = "LGCreditCheckInfoTableViewCell"
    
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
        
        let label1 = makeLabel(title: "综合信用评分")
        let label2 = makeLabel(title: "身份信息验证")
        let label3 = makeLabel(title: "多平台借贷记录查询")
        let label4 = makeLabel(title: "网贷逾期记录查询")
        let label5 = makeLabel(title: "个人风险监测")
        let label6 = makeLabel(title: "失信记录查询")
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        addSubview(label4)
        addSubview(label5)
        addSubview(label6)
        label1.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(24)
            make.top.equalTo(self!).offset(12)
        }
        label2.snp.makeConstraints { make in
            make.left.equalTo(label1)
            make.top.equalTo(label1.snp.bottom).offset(8)
        }
        label3.snp.makeConstraints { [weak self] make in
            make.left.equalTo(label2)
            make.top.equalTo(label2.snp.bottom).offset(8)
            make.bottom.equalTo(self!).offset(-12)
        }
        label4.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!.snp.centerX).offset(24)
            make.top.equalTo(label1)
        }
        label5.snp.makeConstraints { make in
            make.left.equalTo(label4)
            make.top.equalTo(label2)
        }
        label6.snp.makeConstraints { make in
            make.left.equalTo(label5)
            make.top.equalTo(label3)
        }
        addDot(label: label1)
        addDot(label: label2)
        addDot(label: label3)
        addDot(label: label4)
        addDot(label: label5)
        addDot(label: label6)
    }
    
    private func makeLabel(title: String?) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = kColorAssistText
        label.clipsToBounds = false
        label.text = title
        
        return label
    }
    
    private func addDot(label: UILabel) {
        let radius = CGFloat(1.5)
        let dot = UIView()
        dot.backgroundColor = kColorAssistText
        dot.layer.cornerRadius = radius
        dot.layer.masksToBounds = true
        addSubview(dot)
        dot.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.size.equalTo(CGSize(width: radius * 2, height: radius * 2))
            make.left.equalTo(label).offset(-8)
        }
    }
}
