//
//  LGSettingViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGSettingViewController: LGViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        title = "设置"
        view.backgroundColor = kColorBackground
        
        // 列表
        let settingTableView = UITableView(frame: CGRect.zero, style: .grouped)
        settingTableView.backgroundColor = kColorSeperatorBackground
        settingTableView.separatorStyle = .none
        settingTableView.register(LGSettingTableViewCell.self,
                                  forCellReuseIdentifier: LGSettingTableViewCell.identifier)
        settingTableView.register(LGLogoutTableViewCell.self,
                                  forCellReuseIdentifier: LGLogoutTableViewCell.identifier)
        settingTableView.delegate = self
        settingTableView.dataSource = self
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints { [weak self] make in
            make.top.right.left.bottom.equalTo(self!.view)
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGSettingTableViewCell.identifier) as! LGSettingTableViewCell
            if indexPath.row == 0 {
                cell.configCell(title: "意见反馈")
            } else {
                cell.configCell(title: "关于我们")
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGLogoutTableViewCell.identifier) as! LGLogoutTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let feedBackVC = LGFeedBackTableViewController()
                show(feedBackVC, sender: nil)
            } else {
                let aboutVC = LGAboutUsTableViewController()
                show(aboutVC, sender: nil)
            }
        } else {
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
