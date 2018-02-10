//
//  LGQRCodeViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 10/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGQRCodeViewController: LGViewController {
    enum LGQRCodeViewControllerType {
        case service  // 客服
        case official // 公众号
    }
    
    private var type: LGQRCodeViewControllerType
    
    init(type: LGQRCodeViewControllerType) {
        self.type = type
        
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

    private func setup() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(backgroundOnTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGR)
        
        let contentView = UIView()
        contentView.backgroundColor = kColorBackground
        contentView.isUserInteractionEnabled = true
        let anotherGR = UITapGestureRecognizer(target: nil, action: nil)
        contentView.addGestureRecognizer(anotherGR)
        view.addSubview(contentView)
        contentView.snp.makeConstraints { [weak self] make in
            make.width.equalTo(self!.view).multipliedBy(0.8)
//            make.height.equalTo(400)
            make.center.equalTo(self!.view)
        }
        
        let bannerImageView = UIImageView()
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.clipsToBounds = true
        contentView.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
        }
        
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "popup_close"), for: .normal)
        closeButton.sizeToFit()
        closeButton.addTarget(self, action: #selector(closeButtonOnClick), for: .touchUpInside)
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.right.top.equalTo(contentView)
        }
        
        let qrcodeImageView = UIImageView()
        qrcodeImageView.contentMode = .scaleAspectFit
        contentView.addSubview(qrcodeImageView)
        qrcodeImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(bannerImageView.snp.bottom).offset(12)
            make.height.equalTo(kScreenWidth * 0.5)
            make.width.equalTo(contentView)
        }
        
        let copyButton = UIButton(type: .custom)
        copyButton.setTitle("复制微信号去微信", for: .normal)
        copyButton.setTitleColor(UIColor.white, for: .normal)
        copyButton.layer.cornerRadius = 5
        copyButton.backgroundColor = UIColor(red:0.35, green:0.63, blue:0.98, alpha:1.00)
        copyButton.layer.shadowColor = UIColor(red:0.22, green:0.48, blue:0.81, alpha:1.00).cgColor
        copyButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        copyButton.layer.shadowOpacity = 1
        copyButton.layer.shadowRadius = 0
        contentView.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-24)
            make.top.equalTo(qrcodeImageView.snp.bottom).offset(12)
            make.height.equalTo(44)
            make.left.equalTo(contentView).offset(24)
            make.centerX.equalTo(contentView)
        }
        
        if type == .service {
            bannerImageView.image = UIImage(named: "popup_bg_private")
            bannerImageView.sizeToFit()
            qrcodeImageView.image = UIImage(named: "qrcode_private")
        } else {
            bannerImageView.image = UIImage(named: "popup_bg_official")
            bannerImageView.sizeToFit()
            qrcodeImageView.image = UIImage(named: "qrcode_official")
        }
    }
    
    @objc private func backgroundOnTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func closeButtonOnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func copyButtonOnClick() {
        let todo = 1 // 微信跳转
        
    }
}
