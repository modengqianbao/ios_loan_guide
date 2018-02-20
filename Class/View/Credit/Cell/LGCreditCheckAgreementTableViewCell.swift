//
//  LGCreditCheckAgreementTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 10/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import BEMCheckBox

protocol LGCreditCheckAgreementTableViewCellDelegate: class {
    func agreementCellDidClickAgreement(_ agreementCell: LGCreditCheckAgreementTableViewCell)
    func agreementCell(_ agreementCell: LGCreditCheckAgreementTableViewCell, didChangeCheckBoxValue selected: Bool)
}

class LGCreditCheckAgreementTableViewCell: UITableViewCell {
    static let identifier = "LGCreditCheckAgreementTableViewCell"
    
    weak var delegate: LGCreditCheckAgreementTableViewCellDelegate?
    
    private var box: BEMCheckBox!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        box = BEMCheckBox()
        box.boxType = .square
        box.animationDuration = 0.3
        box.onAnimationType = .fade
        box.offAnimationType = .fade
        box.onCheckColor = UIColor.white
        box.onTintColor = UIColor(red:0.23, green:0.61, blue:0.15, alpha:1.00)
        box.onFillColor = UIColor(red:0.23, green:0.61, blue:0.15, alpha:1.00)
        box.offFillColor = UIColor.white
        box.tintColor = kColorGrey
        box.on = true
        box.addTarget(self, action: #selector(checkBoxValueChange(checkBox:)), for: .valueChanged)
        addSubview(box)
        box.snp.makeConstraints { [weak self] make in
            make.left.top.equalTo(self!).offset(16)
            make.bottom.equalTo(self!).offset(-16)
            make.size.equalTo(CGSize(width: 13, height: 13))
        }
        
        let contentLabel = UILabel()
        contentLabel.textColor = kColorTitleText
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentLabel.text = "我已经阅读并同意"
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(box.snp.right).offset(8)
            make.centerY.equalTo(box)
        }
        
        let agreementButton = UIButton(type: .custom)
        agreementButton.setTitle("《用户授权协议》", for: .normal)
        agreementButton.setTitleColor(kColorMainTone, for: .normal)
        agreementButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        agreementButton.addTarget(self, action: #selector(agreementButtonOnClick), for: .touchUpInside)
        addSubview(agreementButton)
        agreementButton.snp.makeConstraints { make in
            make.left.equalTo(contentLabel.snp.right)
            make.centerY.equalTo(contentLabel)
        }
    }
    
    @objc private func agreementButtonOnClick() {
        delegate?.agreementCellDidClickAgreement(self)
    }
    
    @objc private func checkBoxValueChange(checkBox: BEMCheckBox) {
        let value = checkBox.on
        delegate?.agreementCell(self, didChangeCheckBoxValue: value)
    }
}
