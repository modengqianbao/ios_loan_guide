//
//  LGAboutUsTableViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGAboutUsTableViewController: LGViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        view.backgroundColor = kColorBackground
        title = "关于我们"
        
        let logoImageView = UIImageView(image: UIImage(named: "login_logo"))
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(100)
        }
        
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        contentLabel.textColor = kColorAssistText
        contentLabel.text = "让贷款无需等待"
        view.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
        }
        
        let versionLabel = UILabel()
        versionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        versionLabel.textColor = kColorAssistText
        versionLabel.text = "V1.0.0.0"
        view.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(logoImageView)
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
        }
    }
}
