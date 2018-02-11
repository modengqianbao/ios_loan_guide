//
//  LGVericationTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

protocol LGVericationTableViewCellDelegate: class {
    func vericationCell(_ cell: LGVericationTableViewCell, texting text: String)
    func vericationCell(_ cell: LGVericationTableViewCell, didEndEditWithText text: String)
}

class LGVericationTableViewCell: UITableViewCell {
    static let identifier = "LGVericationTableViewCell"
    
    weak var delegate: LGVericationTableViewCellDelegate?
    
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
            make.top.equalTo(self!).offset(16)
            make.bottom.equalTo(self!).offset(-16)
            make.centerY.equalTo(self!)
        }
        
        // 内容
        contentTextField = UITextField()
        contentTextField.textAlignment = .right
        contentTextField.font = font
        contentTextField.returnKeyType = .done
        contentTextField.textColor = kColorTitleText
        contentTextField.delegate = self
        contentTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        contentTextField.setContentHuggingPriority(.init(100), for: .horizontal)
        addSubview(contentTextField)
        contentTextField.snp.makeConstraints { [weak self] make in
            make.right.equalTo(self!).offset(-12)
            make.left.equalTo(titleLabel.snp.right).offset(20)
            make.height.equalTo(40)
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
    
    func configCell(title: String, content: String?, placeHolder: String, editable: Bool) {
        titleLabel.text = title
        contentTextField.placeholder = placeHolder
        contentTextField.text = content
        contentTextField.isEnabled = editable
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        delegate?.vericationCell(self, texting: textField.text!)
    }
}

extension LGVericationTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.vericationCell(self, didEndEditWithText: contentTextField.text!)
        return true
    }
}
