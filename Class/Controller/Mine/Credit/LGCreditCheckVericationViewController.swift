//
//  LGCreditCheckCertificationViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 10/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGCreditCheckVericationViewController: LGViewController {
    private var vericationTableView: UITableView!
    
    private var isAgree = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        title = "实名认证"
        
        // 表单
        vericationTableView = UITableView(frame: CGRect.zero, style: .grouped)
        vericationTableView.isScrollEnabled = false
        vericationTableView.separatorStyle = .none
        vericationTableView.register(LGVericationTableViewCell.self,
                                     forCellReuseIdentifier: LGVericationTableViewCell.identifier)
        vericationTableView.register(LGCreditCheckAgreementTableViewCell.self,
                                     forCellReuseIdentifier: LGCreditCheckAgreementTableViewCell.identifier)
        vericationTableView.register(LGNormalDetailApplyTableViewCell.self,
                                     forCellReuseIdentifier: LGNormalDetailApplyTableViewCell.identifier)
        vericationTableView.delegate = self
        vericationTableView.dataSource = self
        view.addSubview(vericationTableView)
        vericationTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.top.equalTo(self!.view)
        }
    }
    
    private func submit() {
        if !isAgree {
            LGHud.show(in: view, animated: true, text: "请同意用户协议")
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGCreditCheckVericationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGVericationTableViewCell.identifier) as! LGVericationTableViewCell
            
            if indexPath.row == 0 {
                cell.configCell(title: "姓名", content: nil, placeHolder: "姓名")
            } else if indexPath.row == 1 {
                cell.configCell(title: "身份证", content: nil, placeHolder: "身份证")
            } else {
                cell.configCell(title: "手机号", content: nil, placeHolder: "手机号")
            }
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCheckAgreementTableViewCell.identifier) as! LGCreditCheckAgreementTableViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailApplyTableViewCell.identifier) as! LGNormalDetailApplyTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.configCell(title: "申请查询")
            cell.delegate = self
            return cell
        }
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

extension LGCreditCheckVericationViewController: LGCreditCheckAgreementTableViewCellDelegate {
    func agreementCellDidClickAgreement(_ agreementCell: LGCreditCheckAgreementTableViewCell) {
        let todo = 1
    }
    
    func agreementCell(_ agreementCell: LGCreditCheckAgreementTableViewCell, didChangeCheckBoxValue selected: Bool) {
        isAgree = selected
    }
}

extension LGCreditCheckVericationViewController: LGNormalDetailApplyTableViewCellDelegate {
    func applyCellDidSubmit(_ applyCell: LGNormalDetailApplyTableViewCell) {
        submit()
    }
}
