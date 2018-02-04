//
//  LGLoanViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class LGLoanViewController: LGViewController {
    private var loanTableView: UITableView!
    
    private let model = LGLoanModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getLoanList()
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
        loanTableView = UITableView(frame: CGRect.zero, style: .grouped)
        loanTableView.separatorStyle = .none
        loanTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self!.model.reloadLoanList { error in
                self!.loanTableView.mj_header.endRefreshing()
                if error == nil {
                    self!.loanTableView.reloadData()
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        })
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
    
    private func getLoanList() {
        loanTableView.mj_header.beginRefreshing()
    }
}

//MARK:- UITableView delegate, datasource
extension LGLoanViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.loanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LGHotProductTableViewCell.identifier) as! LGHotProductTableViewCell
        let loanItem = model.loanArray[indexPath.row]
        let moneyString = "日利率: \(loanItem.rateMax)%, 额度: \(loanItem.loanMax)元"
        
        cell.configCell(iconURLString: imageDomaion.appending(loanItem.logoString),
                        title: loanItem.name,
                        adString: loanItem.labelString,
                        moneyString: moneyString,
                        describeString: loanItem.loanSpec)
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
            return model.currentReturnType
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
            return model.returnTypeArray[row]
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, contentForRow row: Int, inSection section: Int) -> String? {
        return nil
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, setHighLightedForSection section: Int) -> Bool {
        if section == 0 {
            return model.sortWithRate
        } else if section == 1 {
            return !model.sortWithRate
        } else {
            return model.currentReturnType != 0
        }
    }
    
    func dropMenu(_ dropMenu: LGDropDownMenu, didSelectAtSecion section: Int, atRow row: Int) {
        if section == 0 {
            model.sortWithRate = true
        } else if section == 1 {
            model.sortWithRate = false
        }  else {
            model.currentReturnType = row
        }
        dropMenu.reloadData()
        loanTableView.mj_header.beginRefreshing()
    }
}
