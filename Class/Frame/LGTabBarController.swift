//
//  LGTabBarController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        setupChildViews()
    }
    
    private func setupTabBar() {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = kColorBackground
        tabBar.isTranslucent = false
        
        // 分割线
        let lineView = UIView()
        lineView.backgroundColor = kColorBorder
        tabBar.addSubview(lineView)
        lineView.snp.makeConstraints { [weak self] make in
            make.left.right.top.equalTo(self!.tabBar)
            make.height.equalTo(1)
        }
    }
    
    private func setupChildViews() {
        // 首页
        let homeVC = LGHomeViewController()
        setupOneChildView(vc: homeVC,
                          name: "首页",
                          image: UIImage(named: "tab_home"),
                          selectedImage: UIImage(named: "tab_home_pre"))
        
        // 贷款
        let loanVC = LGLoanViewController()
        setupOneChildView(vc: loanVC,
                          name: "贷款",
                          image: UIImage(named: "tab_loan"),
                          selectedImage: UIImage(named: "tab_loan_pre"))
        
        // 信用卡
        let creditCardVC = LGCreditCardViewController()
        setupOneChildView(vc: creditCardVC,
                          name: "信用卡",
                          image: UIImage(named: "tab_credit"),
                          selectedImage: UIImage(named: "tab_credit_pre"))
        
        // 我的
        let mineVC = LGMineViewController()
        setupOneChildView(vc: mineVC,
                          name: "我的",
                          image: UIImage(named: "tab_my"),
                          selectedImage: UIImage(named: "tab_my_pre"))
    }
    
    private func setupOneChildView(vc: UIViewController, name: String, image: UIImage?, selectedImage: UIImage?) {
        let nc = LGNavigationController(rootViewController: vc)
        nc.tabBarItem.title = name
        nc.tabBarItem.image = image!.withRenderingMode(.alwaysOriginal)
        nc.tabBarItem.selectedImage = selectedImage!.withRenderingMode(.alwaysOriginal)
        addChildViewController(nc)
    }
}
