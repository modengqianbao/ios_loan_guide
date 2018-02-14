//
//  LGSignupViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 28/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD
import CocoaSecurity
import TPKeyboardAvoiding

class LGSignupViewController: LGViewController {
    private var phoneTextField: UITextField!
    private var passwordTextField: UITextField!
    private var vericationTextField: UITextField!
    private var vericationButton: UIButton!
    private var signupButton: UIButton!
    
    private var countDownSecond = 0
    private var timer: Timer!
    private var smsToken: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        title = "注册"
        view = TPKeyboardAvoidingScrollView(frame: view.frame)
        view.backgroundColor = kColorBackground
        
        let font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        // 背景图片
        let backgroundImage1 = UIImageView(image: UIImage(named: "login_pic2"))
        let backgroundImage2 = UIImageView(image: UIImage(named: "login_pic1"))
        view.addSubview(backgroundImage1)
        view.addSubview(backgroundImage2)
        backgroundImage1.snp.makeConstraints { [weak self] make in
            make.left.top.equalTo(self!.view)
        }
        backgroundImage2.snp.makeConstraints { [weak self] make in
            make.right.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(400)
        }
        
        // logo
        let loginImageView = UIImageView(image: UIImage(named: "login_logo"))
        view.addSubview(loginImageView)
        loginImageView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(40)
        }
        
        let margin = CGFloat(22)
        // 手机号
        let phoneLine = UIView()
        phoneLine.backgroundColor = kColorBorder
        view.addSubview(phoneLine)
        phoneLine.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!.view).offset(margin)
            make.right.equalTo(self!.view).offset(-margin)
            make.centerX.equalTo(self!.view)
            make.height.equalTo(1)
            make.top.equalTo(loginImageView.snp.bottom).offset(102)
        }
        
        let phoneHeadLabel = UILabel()
        phoneHeadLabel.font = font
        phoneHeadLabel.text = "+86"
        phoneHeadLabel.textColor = kColorTitleText
        view.addSubview(phoneHeadLabel)
        phoneHeadLabel.snp.makeConstraints { make in
            make.left.equalTo(phoneLine)
            make.bottom.equalTo(phoneLine.snp.top).offset(-8)
        }
        
        phoneTextField = UITextField()
        phoneTextField.font = font
        phoneTextField.placeholder = "请输入11位手机号"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.returnKeyType = .continue
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 200), for: .horizontal)
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.left.equalTo(phoneHeadLabel.snp.right).offset(12)
            make.right.equalTo(phoneLine)
            make.centerY.equalTo(phoneHeadLabel)
            make.height.equalTo(30)
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
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.placeholder = "请输入至少6位密码"
        passwordTextField.returnKeyType = .continue
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalTo(passwordLine)
            make.bottom.equalTo(passwordLine.snp.top).offset(-12)
            make.height.equalTo(24)
        }
        
        // 验证码
        let vericationLine = UIView()
        vericationLine.backgroundColor = kColorBorder
        view.addSubview(vericationLine)
        vericationLine.snp.makeConstraints { make in
            make.left.right.equalTo(phoneLine)
            make.top.equalTo(passwordLine.snp.bottom).offset(50)
            make.height.equalTo(1)
        }
        
        vericationButton = UIButton(type: .custom)
        vericationButton.isEnabled = false
        vericationButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        vericationButton.backgroundColor = kColorGrey
        vericationButton.layer.cornerRadius = 14
        vericationButton.layer.masksToBounds = true
        vericationButton.setTitle("获取验证码", for: .normal)
        vericationButton.addTarget(self, action: #selector(vericationButtonOnClick(button:)), for: .touchUpInside)
        view.addSubview(vericationButton)
        vericationButton.snp.makeConstraints { make in
            make.right.equalTo(vericationLine)
            make.size.equalTo(CGSize(width: 100, height: 28))
            make.bottom.equalTo(vericationLine.snp.top).offset(-12)
        }
        
        vericationTextField = UITextField()
        vericationTextField.font = font
        vericationTextField.placeholder = "请输入验证码"
        vericationTextField.returnKeyType = .done
        vericationTextField.keyboardType = .numberPad
        vericationTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        view.addSubview(vericationTextField)
        vericationTextField.snp.makeConstraints { make in
            make.left.equalTo(vericationLine)
            make.right.equalTo(vericationButton.snp.left).offset(-12)
            make.centerY.equalTo(vericationButton)
            make.height.equalTo(24)
        }
        
        // 注册按钮
        signupButton = UIButton(type: .custom)
        signupButton.isEnabled = false
        signupButton.setTitle("注册", for: .normal)
        signupButton.backgroundColor = kColorGrey
        signupButton.layer.cornerRadius = 3
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonOnClick), for: .touchUpInside)
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.left.right.equalTo(vericationLine)
            make.height.equalTo(40)
            make.top.equalTo(vericationLine.snp.bottom).offset(52)
        }
        
        // 用户协议
        let topOffset = kScreenHeight -  64 - 32
        let labelHeight = 20
        let agreeLabel = UILabel()
        agreeLabel.text = "注册即同意"
        agreeLabel.textColor = kColorAssistText
        agreeLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(agreeLabel)
        agreeLabel.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!.view).offset(-40)
//            make.bottom.equalTo(self!.view).offset(-20)
            make.top.equalTo(self!.view).offset(topOffset)
            make.height.equalTo(labelHeight)
        }
        
        let agreementButton = UIButton()
        agreementButton.setTitleColor(kColorMainTone, for: .normal)
        let buttonTitle = "用户注册协议"
        let buttonTitleAttribute:[NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor: kColorMainTone,
                                    NSAttributedStringKey.underlineStyle: 1,
                                    NSAttributedStringKey.underlineColor: kColorMainTone,
                                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        let attributeButtonTitle = NSAttributedString(string: buttonTitle, attributes: buttonTitleAttribute)
        agreementButton.setAttributedTitle(attributeButtonTitle, for: .normal)
        agreementButton.addTarget(self, action: #selector(agreementButtonOnClick), for: .touchUpInside)
        view.addSubview(agreementButton)
        agreementButton.snp.makeConstraints { [weak self] make in
            make.top.equalTo(self!.view).offset(topOffset)
            make.left.equalTo(agreeLabel.snp.right)
            make.height.equalTo(labelHeight)
        }
    }
    
    @objc private func vericationButtonOnClick(button: UIButton) {
        // 发送请求
        view.endEditing(true)
        MBProgressHUD.showAdded(to: view, animated: true)
        LGUserService.sharedService.sendSMSCode(phoneNumber: phoneTextField.text!, type: 1) { [weak self] smsToken, error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    // 发送成功，开始倒计时
                    button.isEnabled = false
                    button.backgroundColor = kColorGrey
                    self!.countDownSecond = 60
                    self!.smsToken = smsToken
                    self!.timer = Timer.scheduledTimer(timeInterval: 1, target: self!, selector: #selector(self!.minusOneSecond), userInfo: nil, repeats: true)
                } else {
                    // 发送失败，提示
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
    
    @objc private func minusOneSecond() {
        countDownSecond -= 1
        if countDownSecond < 1 {
            timer.invalidate()
            vericationButton.setTitle("获取验证码", for: .normal)
            textFieldDidChange()
        } else {
            vericationButton.setTitle("重新获取(\(countDownSecond)s)", for: .normal)
        }
    }
    
    @objc private func signupButtonOnClick() {
        MBProgressHUD.showAdded(to: view, animated: true)
        view.endEditing(true)
        if smsToken != nil {
            let password = CocoaSecurity.md5(passwordTextField.text!)
            LGUserService.sharedService.signup(withPhone: phoneTextField.text!, password: password!.hex, smsCode: vericationTextField.text!, smsToken: smsToken!) { [weak self] error in
                if self != nil {
                    if error == nil {
                        // 注册成功
                        self!.navigationController?.popViewController(animated: true)
                    } else {
                        LGHud.show(in: self!.view, animated: true, text: error)
                    }
                }
            }
        } else {
            LGHud.show(in: view, animated: true, text: "请先获取验证码")
        }
    }
    
    @objc private func agreementButtonOnClick() {
        let todo = 1
        let agreeVC = LGUserAgreementViewController(nibName: nil, bundle: nil)
        show(agreeVC, sender: nil)
    }
    
    @objc private func textFieldDidChange() {
        // 获取验证码按钮
        if phoneTextField.text!.count == 11 && countDownSecond < 1 {
            vericationButton.isEnabled = true
            vericationButton.backgroundColor = kColorMainTone
        } else {
            vericationButton.isEnabled = false
            vericationButton.backgroundColor = kColorGrey
        }
        
        // 注册按钮
        if phoneTextField.text!.count == 11
            && passwordTextField.text!.count >= 6
            && vericationTextField.text!.count == 6 {
            signupButton.isEnabled = true
            signupButton.backgroundColor = kColorMainTone
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = kColorGrey
        }
    }
}

//MARK:- UITextField delegate
extension LGSignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            vericationTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        return true
    }
}
