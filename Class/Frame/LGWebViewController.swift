//
//  LGWebViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 14/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import Foundation
//import RxWebViewController

class LGWebViewController: RxWebViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        custom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func custom() {
//        let backButton = UIButton(type: .custom)
//        backButton.setImage(UIImage(named: "nav_back"), for: .normal)
//        backButton.setTitleColor(kColorTitleText, for: .normal)
//        backButton.setTitle("返回", for: .normal)
//        backButton.sizeToFit()
//        backButton.addTarget(self, action: #selector(backButtonOnClick), for: .touchUpInside)
//        let backItem = UIBarButtonItem(customView: backButton)
        
        let backItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backButtonOnClick))
        navigationItem.backBarButtonItem = backItem
    }
    
    @objc private func backButtonOnClick() {
        webView.goBack()
    }
    
    override func closeItemClicked() {
        let alert = UIAlertController(title: "确定退出吗",
                                      message: "您将完全退出当前页面，并且回到莫等钱包",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let doneAction = UIAlertAction(title: "确定", style: .default) { [weak self] _ in
            self!.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        
        present(alert, animated: true, completion: nil)
    }
}
