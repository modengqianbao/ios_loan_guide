//
//  LGReportApplyTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 18/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

protocol LGReportApplyTableViewCellDelegate: class {
    func applyCellDidClickApply(_ cell: LGReportApplyTableViewCell)
}

class LGReportApplyTableViewCell: UITableViewCell {
    static let identifier = "LGReportApplyTableViewCell"
    
    weak var delegate: LGReportApplyTableViewCellDelegate?
    
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
        
        let applyButton = UIButton(type: .custom)
        applyButton.backgroundColor = UIColor.clear
        applyButton.setTitleColor(kColorMainTone, for: .normal)
        applyButton.setTitle("再次查询", for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        applyButton.layer.borderColor = kColorMainTone.cgColor
        applyButton.layer.cornerRadius = 3
        applyButton.layer.borderWidth = 1
        applyButton.layer.masksToBounds = true
        applyButton.addTarget(self, action: #selector(applyButtonOnClikc), for: .touchUpInside)
        addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
            make.height.equalTo(44)
        }
    }
    
    @objc private func applyButtonOnClikc() {
        delegate?.applyCellDidClickApply(self)
    }
}
