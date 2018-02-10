//
//  LGVericationTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGVericationTableViewCell: UITableViewCell {
    static let identifier = "LGVericationTableViewCell"
    
    private var titleLabel: UILabel!
    private var contentTextField: UITextField!
    
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
        
        let font = UIFont.systemFont(ofSize: 14)
        
        // 标题
        titleLabel = UILabel()
        titleLabel.textColor = kColorTitleText
        titleLabel.font = font
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(12)
            make.centerY.equalTo(self!)
        }
        
        // 内容
        contentTextField = UITextField()
        contentTextField.textAlignment = .right
        contentTextField.font = font
        contentTextField.textColor = kColorTitleText
        addSubview(contentTextField)
        contentTextField.snp.makeConstraints { [weak self] make in
            make.right.equalTo(self!).offset(-12)
            make.centerY.equalTo(self!)
        }
        
        let line = UIView()
        line.backgroundColor = kColorSeperatorBackground
        addSubview(line)
        line.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(1)
        }
    }
    
    func configCell(title: String, content: String?, placeHolder: String) {
        titleLabel.text = title
        contentTextField.placeholder = placeHolder
        contentTextField.text = content
    }
}
