//
//  LGRecommendCodeView.swift
//  LoanGuide
//
//  Created by 喂草。 on 13/03/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

protocol LGRecommendViewDelegate: class {
    func recommendCodeView(_ recommendCodeView: LGRecommendCodeView, didInputCode code: String)
}

class LGRecommendCodeView: UIView {
    weak var delegate: LGRecommendViewDelegate?
    
    private var textFieldArray: [UITextField]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        
        let width = CGFloat(0.15)
        textFieldArray = [UITextField]()
        
        let textField1 = makeTextField()
        textFieldArray.append(textField1)
        addSubview(textField1)
        textField1.snp.makeConstraints { [weak self] make in
            make.top.bottom.equalTo(self!)
            make.width.equalTo(self!).multipliedBy(width)
            make.centerX.equalTo(self!).multipliedBy(0.31)
        }
        
        let textField2 = makeTextField()
        textFieldArray.append(textField2)
        addSubview(textField2)
        textField2.snp.makeConstraints { [weak self] make in
            make.width.equalTo(self!).multipliedBy(width)
            make.top.bottom.equalTo(self!)
            make.centerX.equalTo(self!).multipliedBy(0.77)
        }
        
        let textField3 = makeTextField()
        textFieldArray.append(textField3)
        addSubview(textField3)
        textField3.snp.makeConstraints { [weak self] make in
            make.top.bottom.equalTo(self!)
            make.centerX.equalTo(self!).multipliedBy(1.23)
            make.width.equalTo(self!).multipliedBy(width)
        }
        
        let textField4 = makeTextField()
        textFieldArray.append(textField4)
        addSubview(textField4)
        textField4.snp.makeConstraints { [weak self] make in
            make.top.bottom.equalTo(self!)
            make.width.equalTo(self!).multipliedBy(width)
            make.centerX.equalTo(self!).multipliedBy(1.69)
        }
    }
    
    private func makeTextField() -> UITextField {
        let t = UITextField()
        t.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        t.tintColor = UIColor.clear // 隐藏光标
        t.textAlignment = .center
        t.textColor = kColorTitleText
        t.keyboardType = .asciiCapable
        t.backgroundColor = UIColor.clear
        t.layer.borderColor = kColorBorder.cgColor
        t.layer.borderWidth = 1
        t.layer.cornerRadius = 3
        t.layer.masksToBounds = true
        t.addTarget(self, action: #selector(textFieldValueChange(textField:)), for: .editingChanged)
        
        return t
    }
    
    @objc private func textFieldValueChange(textField: UITextField) {
        // 只有1个字符
        if let text = textField.text {
            if !text.isEmpty {
                let char = text.last!
                textField.text = "\(char)".capitalized
                
                // 移到下一个框
                let index = textFieldArray.index(of: textField)!
                if index < textFieldArray.count - 1 {
                    let nextTextField = textFieldArray[index + 1]
                    nextTextField.becomeFirstResponder()
                } else {
                    // 输入完成
                    textField.resignFirstResponder()
                    let code = getInputCode()
                    delegate?.recommendCodeView(self, didInputCode: code)
                }
            }
        }
    }
    
    private func getInputCode() -> String {
        var code = ""
        for textField in textFieldArray {
            code.append(textField.text!)
        }
        return code
    }
    
    func beginInput() {
        textFieldArray.first!.becomeFirstResponder()
    }
    
    func clearInput() {
        for textField in textFieldArray {
            textField.text = ""
        }
        beginInput()
    }
}
