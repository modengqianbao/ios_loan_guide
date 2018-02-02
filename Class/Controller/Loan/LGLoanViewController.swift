//
//  LGLoanViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGLoanViewController: LGViewController {
    private let returnTypeArray = ["不限", "随借随还", "分期付款"]
    private var currentReturnType = 0
    private var sortWithRate = true // 默认按贷款利率排序

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        navigationItem.title = "贷款"
        
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
        let loanTableView = UITableView(frame: CGRect.zero, style: .grouped)
        loanTableView.separatorStyle = .none
        loanTableView.delegate = self
        loanTableView.dataSource = self
        loanTableView.register(LGHotProductTableViewCell.self,
                                forCellReuseIdentifier: LGHotProductTableViewCell.identifier)
        view.addSubview(loanTableView)
        loanTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(dropDownMenu.snp.bottom)
        }
        
        view.bringSubview(toFront: dropDownMenu)
    }
}

//MARK:- UITableView delegate, datasource
extension LGLoanViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LGHotProductTableViewCell.identifier) as! LGHotProductTableViewCell
        cell.configCell(iconURLString: nil, title: "马上金融", adString: "送苹果X", moneyString: "5000", describeString: "2")
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
extension LGLoanViewController: LGDropDownMenuDelegate, LGDropDownMenuDataSource {
    func menuHeightFor(dropMenu: LGDropDownMenu) -> CGFloat {
        return kScreenHeight - 49 - 64 - 40
    }
    
    func numberOfSectionFor(dropMenu: LGDropDownMenu) -> Int {
        return 3
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 3
        } else {
            return 0
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, selectedRowForSection section: Int) -> Int {
        if section == 2 {
            return currentReturnType
        } else {
            return 0
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, titleForRow row: Int, inSection section: Int) -> String {
        if section == 0 {
            return "按贷款利率"
        } else if section == 1 {
            return "按放款速度"
        } else {
            return returnTypeArray[row]
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, contentForRow row: Int, inSection section: Int) -> String? {
        return nil
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, setHighLightedForSection section: Int) -> Bool {
        if section == 0 {
            return sortWithRate
        } else if section == 1 {
            return !sortWithRate
        } else {
            return currentReturnType != 0
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, didSelectAtSecion section: Int, atRow row: Int) {
        if section == 0 {
            sortWithRate = true
        } else if section == 1 {
            sortWithRate = false
        }  else {
            currentReturnType = row
        }
        dropMenu.reloadData()
    }
}
