//
//  LGFeedBackTableViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import FSTextView
import MBProgressHUD
import TPKeyboardAvoiding

class LGFeedBackTableViewController: LGViewController {
    private var textView: FSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        title = "意见反馈"
        view = TPKeyboardAvoidingScrollView(frame: view.frame)
        view.backgroundColor = kColorSeperatorBackground
        
        let rightButton = UIButton(type: .custom)
        rightButton.setTitle("提交", for: .normal)
        rightButton.setTitleColor(kColorTitleText, for: .normal)
        rightButton.addTarget(self, action: #selector(sumbitButtonOnClick), for: .touchUpInside)
        let item = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = item
        
        textView = FSTextView()
        textView.backgroundColor = UIColor.clear
        textView.borderWidth = 1
        textView.borderColor = kColorBorder
        textView.cornerRadius = 3
        textView.textColor = kColorTitleText
        textView.placeholder = "您的反馈，是我们持续改进的方向哦！"
        view.addSubview(textView)
        textView.snp.makeConstraints { [weak self] make in
            make.top.left.equalTo(self!.view).offset(12)
            make.height.equalTo(200)
            make.centerX.equalTo(self!.view)
            make.right.equalTo(self!.view).offset(-12)
        }
        
        let submitButton = UIButton(type: .custom)
        submitButton.backgroundColor = kColorMainTone
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        submitButton.setTitle("提交", for: .normal)
        submitButton.addTarget(self, action: #selector(sumbitButtonOnClick), for: .touchUpInside)
        view.addSubview(submitButton)
        submitButton.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!.view).offset(20)
            make.right.equalTo(self!.view).offset(-20)
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func sumbitButtonOnClick() {
        view.endEditing(true)
        MBProgressHUD.showAdded(to: view, animated: true)
        LGMineService.sharedService.sendFeedBack(content: textView.text!) { [weak self] error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
}
