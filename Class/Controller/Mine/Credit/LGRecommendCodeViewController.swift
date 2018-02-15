//
//  LGRecommendCodeViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 15/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGRecommendCodeViewController: LGViewController {
    
    private var textFieldArray: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        title = "信用知多少"
        view.backgroundColor = kColorBackground
        
        let skipButton = UIButton(type: .custom)
        skipButton.setTitleColor(kColorTitleText, for: .normal)
        skipButton.setTitle("跳过", for: .normal)
        skipButton.addTarget(self, action: #selector(skipButtonOnClick), for: .touchUpInside)
        let skipItem = UIBarButtonItem(customView: skipButton)
        navigationItem.rightBarButtonItem = skipItem
        
        let height = CGFloat(70)
        let width = kScreenWidth * 0.15
        let margin = kScreenWidth * 0.08
        textFieldArray = [UITextField]()
        
        let textField1 = makeTextField()
        textFieldArray.append(textField1)
        view.addSubview(textField1)
        textField1.snp.makeConstraints { [weak self] make in
            make.size.equalTo(CGSize(width: width, height: height))
            make.left.equalTo(self!.view).offset(margin)
            make.top.equalTo(self!.view).offset(24)
        }
        
        let textField2 = makeTextField()
        textFieldArray.append(textField2)
        view.addSubview(textField2)
        textField2.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: width, height: height))
            make.left.equalTo(textField1.snp.right).offset(margin)
            make.top.equalTo(textField1)
        }
        
        let textField3 = makeTextField()
        textFieldArray.append(textField3)
        view.addSubview(textField3)
        textField3.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: width, height: height))
            make.left.equalTo(textField2.snp.right).offset(margin)
            make.top.equalTo(textField2)
        }
        
        let textField4 = makeTextField()
        textFieldArray.append(textField4)
        view.addSubview(textField4)
        textField4.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: width, height: height))
            make.left.equalTo(textField3.snp.right).offset(margin)
            make.top.equalTo(textField3)
        }
        
        let hintLabel = UILabel()
        hintLabel.textColor = kColorAssistText
        hintLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        hintLabel.numberOfLines = 0
        hintLabel.text = "请输入您的客户代表分享给您的推荐码。如果没有，直接跳过即可。"
        view.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!.view).offset(margin)
            make.right.equalTo(self!.view).offset(-margin)
            make.top.equalTo(textField1.snp.bottom).offset(18)
        }
        
        let applyButton = UIButton(type: .custom)
        applyButton.backgroundColor = kColorMainTone
        applyButton.setTitle("提交", for: .normal)
        applyButton.setTitleColor(UIColor.white, for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        applyButton.addTarget(self, action: #selector(applyButtonOnClikc), for: .touchUpInside)
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.left.right.equalTo(hintLabel)
            make.height.equalTo(40)
            make.top.equalTo(hintLabel.snp.bottom).offset(24)
        }
    }
    
    private func makeTextField() -> UITextField {
        let t = UITextField()
        t.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        t.tintColor = UIColor.clear // 隐藏光标
        t.textAlignment = .center
        t.textColor = kColorTitleText
        t.keyboardType = .numberPad
        t.backgroundColor = UIColor.clear
        t.layer.borderColor = kColorBorder.cgColor
        t.layer.borderWidth = 1
        t.layer.cornerRadius = 3
        t.layer.masksToBounds = true
        t.addTarget(self, action: #selector(textFieldValueChange(textField:)), for: .editingChanged)
        
        return t
    }
    
    @objc private func skipButtonOnClick() {
        
    }
    
    @objc private func applyButtonOnClikc() {
        
    }
    
    @objc private func textFieldValueChange(textField: UITextField) {
        // 只有1个字符
        if let text = textField.text {
            if !text.isEmpty {
                let char = text.last!
                textField.text = "\(char)"
                
                // 移到下一个框
                let index = textFieldArray.index(of: textField)!
                if index < textFieldArray.count - 1 {
                    let nextTextField = textFieldArray[index + 1]
                    nextTextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        }
    }
}
