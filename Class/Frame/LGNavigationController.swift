//
//  LGNavigationController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationBar.backgroundColor = kColorBackground
        navigationBar.isTranslucent = false
        navigationBar.tintColor = kColorTitleText
//        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: kColorTitleText]

        let edge = UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0)
        let backImage = UIImage(named: "nav_back")!.withAlignmentRectInsets(edge)
//        navigationItem.backBarButtonItem?.image = UIImage(named: "nav_back")!.withAlignmentRectInsets(edge)
        
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
    }
}
