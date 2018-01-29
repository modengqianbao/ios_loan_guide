//
//  LGLoginViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 27/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding

class LGLoginViewController: LGViewController {
    private var phoneTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        title = "登录"
        view = TPKeyboardAvoidingScrollView(frame: view.frame)
        view.backgroundColor = kColorBackground
        
        let font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        // 返回键
        let backButton = UIButton(type: .custom)
        backButton.setTitleColor(kColorTitleText, for: .normal)
        backButton.setTitle("     ", for: .normal)
        backButton.setImage(UIImage(named: "nav_back"), for: .normal)
        backButton.tintColor = kColorTitleText
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButton.sizeToFit()
        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem
        
        // 注册键
        let signupButton = UIButton(type: .custom)
        signupButton.setTitleColor(kColorMainTone, for: .normal)
        signupButton.setTitle("注册", for: .normal)
        signupButton.addTarget(self, action: #selector(showSignupView), for: .touchUpInside)
        signupButton.sizeToFit()
        let signupItem = UIBarButtonItem(customView: signupButton)
        navigationItem.rightBarButtonItem = signupItem
        
        // logo
        let loginImageView = UIImageView(image: UIImage(named: "login_logo"))
        view.addSubview(loginImageView)
        loginImageView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(40)
        }
        
        // 手机号
        let phoneLine = UIView()
        phoneLine.backgroundColor = kColorBorder
        view.addSubview(phoneLine)
        phoneLine.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!.view).offset(20)
            make.right.equalTo(self!.view).offset(-20)
            make.centerX.equalTo(self!.view)
            make.top.equalTo(loginImageView.snp.bottom).offset(102)
            make.height.equalTo(1)
        }
        
        let phoneLabel = UILabel()
        phoneLabel.font = font
        phoneLabel.text = "手机号"
        view.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.left.equalTo(phoneLine)
            make.bottom.equalTo(phoneLine.snp.top).offset(-17)
        }
        
        let phoneSeparator = UIView()
        phoneSeparator.backgroundColor = kColorBorder
        view.addSubview(phoneSeparator)
        phoneSeparator.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 1, height: 24))
            make.left.equalTo(phoneLabel.snp.right).offset(8)
            make.centerY.equalTo(phoneLabel)
        }
        
        phoneTextField = UITextField()
        phoneTextField.font = font
        phoneTextField.placeholder = "请输入手机号"
        phoneTextField.setContentHuggingPriority(.init(200), for: .horizontal)
//        phoneTextField.setContentCompressionResistancePriority(.d, for: .horizontal)
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.centerY.equalTo(phoneSeparator)
            make.left.equalTo(phoneSeparator.snp.right).offset(8)
            make.right.equalTo(phoneLine)
        }
        
        // 密码
        let passwordLine = UIView()
        passwordLine.backgroundColor = kColorBorder
        view.addSubview(passwordLine)
        passwordLine.snp.makeConstraints { make in
            make.left.right.equalTo(phoneLine)
            make.height.equalTo(1)
            make.top.equalTo(phoneLine.snp.bottom).offset(50)
        }
        
        passwordTextField = UITextField()
        passwordTextField.font = font
        passwordTextField.placeholder = "请输入登录密码"
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalTo(passwordLine)
            make.height.equalTo(24)
            make.bottom.equalTo(passwordLine.snp.top).offset(-12)
        }
        
        // 登录
        loginButton = UIButton(type: .custom)
        loginButton.backgroundColor = kColorGrey
        loginButton.setTitle("登录", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonOnClick), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.left.right.equalTo(phoneLine)
            make.height.equalTo(40)
            make.top.equalTo(passwordLine.snp.bottom).offset(50)
        }
        
        // 忘记密码
        let forgetButton = UIButton(type: .custom)
        forgetButton.setTitleColor(kColorMainTone, for: .normal)
        forgetButton.setTitle("忘记密码？", for: .normal)
        forgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        forgetButton.addTarget(self, action: #selector(forgetButtonOnClick), for: .touchUpInside)
        forgetButton.sizeToFit()
        view.addSubview(forgetButton)
        forgetButton.snp.makeConstraints { make in
            make.right.equalTo(loginButton)
            make.top.equalTo(loginButton.snp.bottom).offset(12)
        }
    }
    
    @objc private func back() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func showSignupView() {
        let signupVC = LGSignupViewController()
        show(signupVC, sender: nil)
    }
    
    @objc private func loginButtonOnClick() {
        
    }
    
    @objc private func forgetButtonOnClick() {
        
    }
}
