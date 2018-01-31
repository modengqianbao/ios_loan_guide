//
//  LGVericationViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGVericationViewController: LGViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        title = "实名认证"
        
        // 表单
        let vericationTableView = UITableView(frame: CGRect.zero, style: .grouped)
        vericationTableView.isScrollEnabled = false
        vericationTableView.register(LGVericationTableViewCell.self, forCellReuseIdentifier: LGVericationTableViewCell.identifier)
        vericationTableView.delegate = self
        vericationTableView.dataSource = self
    }
}

//MARK:- UITableView delegate, datasource
extension LGVericationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LGVericationTableViewCell.identifier) as! LGVericationTableViewCell
        
        if indexPath.row == 0 {
            cell.configCell(title: "姓名", content: nil, placeHolder: "姓名")
        } else if indexPath.row == 1 {
            cell.configCell(title: "身份证", content: nil, placeHolder: "身份证")
        } else {
            cell.configCell(title: "手机号", content: nil, placeHolder: "手机号")
        }
        
        return cell
    }
}
