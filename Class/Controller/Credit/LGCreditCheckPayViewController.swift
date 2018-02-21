//
//  LGCreditCheckPayViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 15/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class LGCreditCheckPayViewController: LGViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        title = "支付页面"
        
        let todo = "这个图片切图要换"
        let moneyIconImageView = UIImageView(image: UIImage(named: "avatar"))
        view.addSubview(moneyIconImageView)
        moneyIconImageView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(40)
        }
        
        let moneyLabel = UILabel()
        let text = "查询费：3.99"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedStringKey.font,
                                    value: UIFont.systemFont(ofSize: 20, weight: .regular),
                                    range: NSRange(location: 0, length: 8))
        attributedText.addAttribute(NSAttributedStringKey.foregroundColor,
                                    value: UIColor.black,
                                    range: NSRange(location: 0, length: 4))
        attributedText.addAttribute(NSAttributedStringKey.foregroundColor,
                                    value: UIColor.red,
                                    range: NSRange(location: 4, length: 4))
        moneyLabel.attributedText = attributedText
        view.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(moneyIconImageView)
            make.top.equalTo(moneyIconImageView.snp.bottom).offset(24)
        }
        
        let hintLabel = UILabel()
        hintLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        hintLabel.textColor = kColorAssistText
        hintLabel.text = "您的信用报告已经生成，支付后即可查看"
        view.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalTo(moneyLabel)
            make.top.equalTo(moneyLabel.snp.bottom).offset(12)
        }
        
        let payButton = UIButton(type: .custom)
        payButton.titleLabel!.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        payButton.setTitle("支付并查看信用报告", for: .normal)
        payButton.setTitleColor(UIColor.white, for: .normal)
        payButton.backgroundColor = kColorMainTone
        payButton.layer.cornerRadius = 3
        payButton.layer.masksToBounds = true
        payButton.addTarget(self, action: #selector(payButtonOnClick), for: .touchUpInside)
        view.addSubview(payButton)
        payButton.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!.view).offset(24)
            make.right.equalTo(self!.view).offset(-24)
            make.top.equalTo(hintLabel.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
    }
    
    @objc private func payButtonOnClick() {
        let test = "假装支付成功，跳转报告页"
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        // 获取查询id
        LGCreditService.sharedService.queryPersonalData(idNumber: LGUserModel.currentUser.idNumber!, name: LGUserModel.currentUser.name!, phone: LGUserModel.currentUser.phone!, params: LGCreditCheckModel.sharedModel.params!, sign: LGCreditCheckModel.sharedModel.sign!) { [weak self] queryID, error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    // 跳转信用报告页
                    let reportVC = LGReportViewController()
                    reportVC.queryID = queryID!
                    self!.show(reportVC, sender: nil)
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
}



