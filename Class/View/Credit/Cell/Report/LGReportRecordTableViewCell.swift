//
//  LGReportRecordTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 18/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGReportRecordTableViewCell: UITableViewCell {
    static let identifier = "LGReportRecordTableViewCell"
    
    private var titleLabel: UILabel!
    private var nobankLabel: UILabel!
    private var bankLabel: UILabel!
    
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
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = kColorTitleText
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.top.equalTo(self!).offset(8)
            make.left.equalTo(self!).offset(12)
        }
        
        nobankLabel = UILabel()
        nobankLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nobankLabel.textColor = kColorAssistText
        addSubview(nobankLabel)
        nobankLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        bankLabel = UILabel()
        bankLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        bankLabel.textColor = kColorAssistText
        addSubview(bankLabel)
        bankLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(nobankLabel)
            make.top.equalTo(nobankLabel.snp.bottom).offset(12)
            make.bottom.equalTo(self!).offset(-12)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kColorSeperatorBackground
        addSubview(lineView)
        lineView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(1)
        }
    }
    
    func configCell(title: String?, nobankCount: Int, bankCount: Int) {
        titleLabel.text = title
        nobankLabel.text = "非银行类：\(nobankCount)"
        bankLabel.text = "银行类：\(bankCount)"
    }
}
