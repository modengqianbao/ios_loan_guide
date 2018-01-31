//
//  LGNormalDetailViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

class LGNormalDetailViewController: LGViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setup() {
        title = "马上金融"
        
        // 表单
        let detailTableView = UITableView(frame: CGRect.zero, style: .grouped)
        
    }
}
