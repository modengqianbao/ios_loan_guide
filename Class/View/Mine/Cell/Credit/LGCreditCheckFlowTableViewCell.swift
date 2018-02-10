//
//  LGCreditCheckFlowTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 08/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGCreditCheckFlowTableViewCell: UITableViewCell {
    static let identifier = "LGCreditCheckFlowTableViewCell"
    
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
        
        let dotRadius = CGFloat(6)
        // 第1步
        let dot1 = makeDot(radius: dotRadius)
        addSubview(dot1)
        dot1.snp.makeConstraints { [weak self] make in
            make.top.equalTo(self!).offset(16)
            make.size.equalTo(CGSize(width: dotRadius * 2,
                                     height: dotRadius * 2))
            make.centerX.equalTo(self!).multipliedBy(0.25)
        }
        
        let step1 = makeStepLabel(step: "第1步")
        addSubview(step1)
        step1.snp.makeConstraints { make in
            make.centerX.equalTo(dot1)
            make.top.equalTo(dot1.snp.bottom).offset(8)
        }
        
        let content1 = makeContentLabel(content: "身份认证")
        addSubview(content1)
        content1.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(step1)
            make.top.equalTo(step1.snp.bottom).offset(4)
            make.bottom.equalTo(self!).offset(-16)
        }
        
        // 第2步
        let dot2 = makeDot(radius: dotRadius)
        addSubview(dot2)
        dot2.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(dot1)
            make.centerX.equalTo(self!).multipliedBy(0.75)
            make.size.equalTo(CGSize(width: dotRadius * 2,
                                     height: dotRadius * 2))
        }
        
        let step2 = makeStepLabel(step: "第2步")
        addSubview(step2)
        step2.snp.makeConstraints { make in
            make.centerX.equalTo(dot2)
            make.top.equalTo(dot2.snp.bottom).offset(8)
        }
        
        let content2 = makeContentLabel(content: "授权查询")
        addSubview(content2)
        content2.snp.makeConstraints { make in
            make.centerX.equalTo(step2)
            make.top.equalTo(step2.snp.bottom).offset(4)
        }

        // 第3步
        let dot3 = makeDot(radius: dotRadius)
        addSubview(dot3)
        dot3.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(dot1)
            make.centerX.equalTo(self!).multipliedBy(1.25)
            make.size.equalTo(CGSize(width: dotRadius * 2,
                                     height: dotRadius * 2))
        }
        
        let step3 = makeStepLabel(step: "第3步")
        addSubview(step3)
        step3.snp.makeConstraints { make in
            make.centerX.equalTo(dot3)
            make.top.equalTo(dot3.snp.bottom).offset(8)
        }
        
        let content3 = makeContentLabel(content: "支付费用")
        addSubview(content3)
        content3.snp.makeConstraints { make in
            make.centerX.equalTo(step3)
            make.top.equalTo(step3.snp.bottom).offset(4)
        }

        // 第4步
        let dot4 = makeDot(radius: dotRadius)
        addSubview(dot4)
        dot4.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(dot1)
            make.centerX.equalTo(self!).multipliedBy(1.75)
            make.size.equalTo(CGSize(width: dotRadius * 2,
                                     height: dotRadius * 2))
        }
        
        let step4 = makeStepLabel(step: "第4步")
        addSubview(step4)
        step4.snp.makeConstraints { make in
            make.centerX.equalTo(dot4)
            make.top.equalTo(dot4.snp.bottom).offset(8)
        }
        
        let content4 = makeContentLabel(content: "查看报告")
        addSubview(content4)
        content4.snp.makeConstraints { make in
            make.centerX.equalTo(step4)
            make.top.equalTo(step4.snp.bottom).offset(4)
        }
        
        // 连线
        let lineView = UIView()
        lineView.backgroundColor = kColorMainTone
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalTo(dot1.snp.centerX)
            make.right.equalTo(dot4.snp.centerX)
            make.centerY.equalTo(dot1)
        }
    }
    
    private func makeDot(radius: CGFloat) -> UIView {
        let dotBorderColor = UIColor(red:0.76, green:0.85, blue:0.98, alpha:1.00)
        
        let dot = UIView()
        dot.backgroundColor = kColorMainTone
        dot.layer.cornerRadius = radius
        dot.layer.masksToBounds = true
        dot.layer.borderColor = dotBorderColor.cgColor
        dot.layer.borderWidth = 3
        
        return dot
    }
    
    private func makeStepLabel(step: String?) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.text = step
        label.textColor = kColorAssistText
        
        return label
    }
    
    private func makeContentLabel(content: String?) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.text = content
        label.textColor = kColorTitleText
        
        return label
    }
}
