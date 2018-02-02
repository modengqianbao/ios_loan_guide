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
    
    private let model = LGHomeModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupSubviews()
        loadData()
    }
    
    private func loadData() {
        model.reloadLoanProduct { [weak self] in
            self!.homeTableView.reloadData()
        }
    }
    
    private func setup() {
        navigationItem.title = "莫等钱包"
        
        view.backgroundColor = kColorBackground
    }
    
    private func setupSubviews() {
        homeTableView = UITableView(frame: CGRect.zero,
                                    style: .grouped)
        homeTableView.separatorStyle = .none
        homeTableView.backgroundColor = kColorSeperatorBackground
        homeTableView.register(LGRecommendTableViewCell.self, forCellReuseIdentifier: LGRecommendTableViewCell.identifier)
        homeTableView.register(LGCreditCheckTableViewCell.self, forCellReuseIdentifier: LGCreditCheckTableViewCell.identifier)
        homeTableView.register(LGHotProductTableViewCell.self, forCellReuseIdentifier: LGHotProductTableViewCell.identifier)
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
            return model.loanProductArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return LGHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), title: "极速好贷")
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
                let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCheckTableViewCell.identifier)!
                return cell
            }
        } else {
            // 热门产品
            let cell = tableView.dequeueReusableCell(withIdentifier: LGHotProductTableViewCell.identifier) as! LGHotProductTableViewCell
            let item = model.loanProductArray[indexPath.row]
            cell.configCell(iconURLString: item.logoString,
                            title: item.name,
                            adString: item.labelString,
                            moneyString: "\(item.loanMax)",
                            describeString: item.introduction)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
