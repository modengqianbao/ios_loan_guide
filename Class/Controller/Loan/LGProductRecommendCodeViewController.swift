//
//  LGProductRecommendCodeViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 13/03/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

protocol LGProductRecommendCodeViewControllerDelegate: class {
    func recommendCodeViewController(_ codeViewController: LGProductRecommendCodeViewController, didCompleteWithCode code: String)
}

class LGProductRecommendCodeViewController: LGViewController {
    weak var delegate: LGProductRecommendCodeViewControllerDelegate?
    
    private var codeView: LGRecommendCodeView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        definesPresentationContext = true
        modalPresentationStyle = .overFullScreen
        providesPresentationContextTransitionStyle = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        codeView.beginInput()
    }

    private func setup() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        let hiddenView = UIView()
        hiddenView.backgroundColor = UIColor.clear
        let hiddenTapGR = UITapGestureRecognizer(target: self, action: #selector(backGroundOnClick))
        hiddenView.isUserInteractionEnabled = true
        hiddenView.addGestureRecognizer(hiddenTapGR)
        view.addSubview(hiddenView)
        hiddenView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
        whiteView.layer.cornerRadius = 5
        whiteView.layer.shadowColor = UIColor.black.cgColor
        whiteView.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteView.layer.shadowOpacity = 0.3
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!.view).offset(20)
            make.right.equalTo(self!.view).offset(-20)
            make.centerY.equalTo(self!.view).multipliedBy(0.6)
        }
        
        let hintLabel = UILabel()
        hintLabel.textColor = kColorAssistText
        hintLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        hintLabel.text = "请输入4位推荐码"
        whiteView.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteView)
            make.top.equalTo(whiteView).offset(16)
        }
        
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "pop_close"), for: .normal)
        closeButton.sizeToFit()
        closeButton.addTarget(self, action: #selector(closeButtonOnClick), for: .touchUpInside)
        whiteView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.right.equalTo(whiteView).offset(-12)
            make.centerY.equalTo(hintLabel)
        }
        
        codeView = LGRecommendCodeView(frame: CGRect.zero)
        codeView.delegate = self
        whiteView.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.left.right.equalTo(whiteView)
            make.top.equalTo(hintLabel.snp.bottom).offset(40)
            make.bottom.equalTo(whiteView).offset(-40)
        }
    }
    
    @objc private func closeButtonOnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func backGroundOnClick() {
        dismiss(animated: true, completion: nil)
    }
}

extension LGProductRecommendCodeViewController: LGRecommendViewDelegate {
    func recommendCodeView(_ recommendCodeView: LGRecommendCodeView, didInputCode code: String) {
        MBProgressHUD.showAdded(to: view, animated: true)
        LGUserService.sharedService.verifyInviteCode(code) { [weak self] error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    self!.delegate?.recommendCodeViewController(self!, didCompleteWithCode: code)
                    self!.dismiss(animated: true, completion: nil)
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                    self!.codeView.clearInput()
                }
            }
        }
    }
}
