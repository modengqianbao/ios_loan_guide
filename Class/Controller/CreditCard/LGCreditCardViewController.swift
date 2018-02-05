//
//  LGCreditCardViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import RxWebViewController

class LGCreditCardViewController: LGViewController {
    
    private var creditTableView: UITableView!
    
    private let model = LGCreditModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getCreditCard()
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
        creditTableView = UITableView(frame: CGRect.zero, style: .grouped)
        creditTableView.register(LGCreditCardTableViewCell.self,
                                 forCellReuseIdentifier: LGCreditCardTableViewCell.identifier)
        creditTableView.register(LGEmptyTableViewCell.self,
                                 forCellReuseIdentifier: LGEmptyTableViewCell.identifier)
        creditTableView.separatorStyle = .none
        creditTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self!.model.getCreditCardArray { error in
                self!.creditTableView.mj_header.endRefreshing()
                if error == nil {
                    self!.creditTableView.reloadData()
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        })
        creditTableView.delegate = self
        creditTableView.dataSource = self
        view.addSubview(creditTableView)
        creditTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(dropDownMenu.snp.bottom)
        }
    }
    
    private func getCreditCard() {
        creditTableView.mj_header.beginRefreshing()
    }
}

//MARK:- UITableView delegate, datasource
extension LGCreditCardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.creditCardArray.count == 0 {
            return 1
        } else {
            return model.creditCardArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if model.creditCardArray.count == 0 {
            // 空空如也
            let cell = tableView.dequeueReusableCell(withIdentifier: LGEmptyTableViewCell.identifier)!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCardTableViewCell.identifier) as! LGCreditCardTableViewCell
            let creditItem = model.creditCardArray[indexPath.row]
            cell.configCell(iconURLString: imageDomaion.appending(creditItem.logoURL),
                            title: creditItem.name,
                            content: creditItem.introduce,
                            extra: creditItem.label)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if model.creditCardArray.count != 0 {
            let item = model.creditCardArray[indexPath.row]
            let url = URL(string: item.urlString)
            let webVC = RxWebViewController(url: url)!
            webVC.navigationController?.navigationBar.tintColor = kColorTitleText
            webVC.hidesBottomBarWhenPushed = true

            navigationController?.pushViewController(webVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
            return model.bankTypeArray.count
        } else if section == 1 {
            return model.levelTypeArray.count
        } else {
            return model.usageTypeArray.count
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, selectedRowForSection section: Int) -> Int {
        if section == 0 {
            return model.selectedBankType
        } else if section == 1 {
            return model.selectedLevelType
        } else {
            return model.selectedUsageType
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, setHighLightedForSection section: Int) -> Bool {
        if (section == 0 && model.selectedBankType == 0)
            || (section == 1 && model.selectedLevelType == 0)
            || (section == 2 && model.selectedUsageType == 0) {
            return false
        } else {
            return true
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, titleForRow row: Int, inSection section: Int) -> String {
        if section == 0 {
            return model.bankTypeArray[row]
        } else if section == 1 {
            return model.levelTypeArray[row]
        } else {
            return model.usageTypeArray[row]
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, contentForRow row: Int, inSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else if section == 1 {
            return model.levelContentArray[row]
        } else {
            return model.usageContentArray[row]
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, didSelectAtSecion section: Int, atRow row: Int) {
        if section == 0 {
            model.selectedBankType = row
        } else if section == 1 {
            model.selectedLevelType = row
        } else {
            model.selectedUsageType = row
        }
        dropMenu.reloadData()
        creditTableView.mj_header.beginRefreshing()
    }
}
