//
//  LGCreditCardViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGCreditCardViewController: LGViewController {
    
    private let bankTypeArray = ["全部银行", "浦发银行", "民生银行"]
    private var selectedBankType = 0
    
    private let levelTypeArray = ["全部等级", "普通卡", "金卡", "白金卡"]
    private let levelContentArray = ["", "额度普遍在1000-30000元之间", "额度普遍在5000-50000元之间", "白金级消费待遇"]
    private var selectedLevelType = 0
    
    private let usageTypeArray = ["全部用途", "标准卡", "特色主题卡", "网络联名卡", "酒店/商旅/航空卡", "现取卡"]
    private let usageContentArray = ["", "银行标准服务", "特色主题专享", "qq，淘宝等联名专属优惠", "酒店出行、航空等超值优惠", "超高取现比例"]
    private var selectedUsageType = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        navigationItem.title = "信用卡"
        
        // 下拉菜单
        // 顶部排序按钮
        let dropDownMenu = LGDropDownMenu(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: view.frame.size.width,
                                                        height: 40),
                                          fatherView: view)
        view.addSubview(dropDownMenu)
        dropDownMenu.snp.makeConstraints { [weak self] make in
            make.left.right.top.equalTo(self!.view)
            make.height.equalTo(40)
        }
        dropDownMenu.setup()
        dropDownMenu.delegate = self
        dropDownMenu.dataSource = self
        
        // 列表
        let creditTableView = UITableView(frame: CGRect.zero, style: .grouped)
        creditTableView.register(LGCreditCardTableViewCell.self,
                                 forCellReuseIdentifier: LGCreditCardTableViewCell.identifier)
        creditTableView.separatorStyle = .none
        creditTableView.delegate = self
        creditTableView.dataSource = self
        view.addSubview(creditTableView)
        creditTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(dropDownMenu.snp.bottom)
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGCreditCardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCardTableViewCell.identifier) as! LGCreditCardTableViewCell
        cell.configCell(icon: UIImage(), title: "民生标准白金信用卡", content: "免费高尔夫、免费体检", extra: "10万高额")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

//MARK:- LGDropDownMenu delegate, datasource
extension LGCreditCardViewController: LGDropDownMenuDelegate, LGDropDownMenuDataSource {
    func menuHeightFor(dropMenu: LGDropDownMenu) -> CGFloat {
        return kScreenHeight - 64 - 49 - 40
    }
    
    func numberOfSectionFor(dropMenu: LGDropDownMenu) -> Int {
        return 3
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bankTypeArray.count
        } else if section == 1 {
            return levelTypeArray.count
        } else {
            return usageTypeArray.count
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, selectedRowForSection section: Int) -> Int {
        if section == 0 {
            return selectedBankType
        } else if section == 1 {
            return selectedLevelType
        } else {
            return selectedUsageType
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, setHighLightedForSection section: Int) -> Bool {
        if (section == 0 && selectedBankType == 0)
            || (section == 1 && selectedLevelType == 0)
            || (section == 2 && selectedUsageType == 0) {
            return false
        } else {
            return true
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, titleForRow row: Int, inSection section: Int) -> String {
        if section == 0 {
            return bankTypeArray[row]
        } else if section == 1 {
            return levelTypeArray[row]
        } else {
            return usageTypeArray[row]
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, contentForRow row: Int, inSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else if section == 1 {
            return levelContentArray[row]
        } else {
            return usageContentArray[row]
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, didSelectAtSecion section: Int, atRow row: Int) {
        if section == 0 {
            selectedBankType = row
        } else if section == 1 {
            selectedLevelType = row
        } else {
            selectedUsageType = row
        }
        dropMenu.reloadData()
    }
}
