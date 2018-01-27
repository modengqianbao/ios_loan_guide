//
//  LGNavigationController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

class LGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationBar.backgroundColor = kColorBackground
        navigationBar.isTranslucent = false 
//        navigationBar.titleTextAttributes 
    }
}
