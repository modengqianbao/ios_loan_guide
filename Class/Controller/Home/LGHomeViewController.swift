//
//  LGHomeViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGHomeViewController: LGViewController {
    
    private var homeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupSubviews()
    }
    
    private func setup() {
        navigationItem.title = "莫等钱包"
        
        view.backgroundColor = kColorBackground
    }
    
    private func setupSubviews() {
        homeTableView = UITableView(frame: CGRect.zero,
                                    style: .grouped)
        homeTableView.separatorStyle = .none
        homeTableView.register(LGRecommendTableViewCell.self, forCellReuseIdentifier: LGRecommendTableViewCell.identifier)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints { [weak self] make in
            make.top.left.right.bottom.equalTo(self!.view)
        }
    }
}

//MAKR:- UITableView delegate, datasource
extension LGHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 急速好贷
            return 2
        } else {
            // 热门产品
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return LGHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), title: "急速好贷")
        } else {
            return LGHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), title: "热门产品")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // 急速好贷
            if indexPath.row == 0 {
                // 马上金融+拍拍贷
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTableViewCell.identifier) as! LGRecommendTableViewCell
                return cell
            } else {
                // 信用知多少
                return UITableViewCell()
            }
        } else {
            // 热门产品
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }    
}
