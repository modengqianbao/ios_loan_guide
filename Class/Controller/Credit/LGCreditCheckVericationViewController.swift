//
//  LGCreditCheckCertificationViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 10/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD
import RxWebViewController

class LGCreditCheckVericationViewController: LGViewController {
    private var vericationTableView: UITableView!
    private var applyButton: UIButton!
    
    private var name: String?
    private var idNumber: String?
    private var isAgree = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        if LGUserModel.currentUser.isVerified {
            title = "已身份认证"
        } else {
            title = "身份认证"
        }
        
        // 表单
        vericationTableView = UITableView(frame: CGRect.zero, style: .grouped)
        vericationTableView.isScrollEnabled = false
        vericationTableView.separatorStyle = .none
        vericationTableView.register(LGVericationTableViewCell.self,
                                     forCellReuseIdentifier: LGVericationTableViewCell.identifier)
        vericationTableView.register(LGCreditCheckAgreementTableViewCell.self,
                                     forCellReuseIdentifier: LGCreditCheckAgreementTableViewCell.identifier)
        vericationTableView.delegate = self
        vericationTableView.dataSource = self
        view.addSubview(vericationTableView)
        vericationTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.top.equalTo(self!.view)
        }
        
        // 提交按钮
        applyButton = UIButton(type: .custom)
        applyButton.backgroundColor = kColorMainTone
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        applyButton.setTitleColor(UIColor.white, for: .normal)
        applyButton.layer.cornerRadius = 2
        applyButton.layer.masksToBounds = true
        applyButton.addTarget(self, action: #selector(applyButtonOnClick), for: .touchUpInside)
        if LGUserModel.currentUser.isVerified {
            applyButton.setTitle("提交查询", for: .normal)
        } else {
            applyButton.setTitle("认证并查询", for: .normal)
        }
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!.view).offset(24)
            make.right.equalTo(self!.view).offset(-24)
            make.top.equalTo(self!.view).offset(200)
            make.height.equalTo(45)
        }
        
        checkButtonEnable()
    }
    
    private func checkButtonEnable() {
        if name != nil && !name!.isEmpty && idNumber != nil && idNumber!.count >= 16 || LGUserModel.currentUser.isVerified {
            applyButton.isEnabled = true
            applyButton.backgroundColor = kColorMainTone
        } else {
            applyButton.isEnabled = false
            applyButton.backgroundColor = kColorGrey
        }
    }
    
    
    @objc private func applyButtonOnClick() {
        if !isAgree {
            LGHud.show(in: view, animated: true, text: "请先同意用户授权协议")
            return
        }
        
        view.endEditing(true)
        if LGUserModel.currentUser.isVerified {
            // 提交查询
            showZhimaCredit()
        } else {
            // 认证并查询
            verify()
        }
    }
    
    private func verify() {
        let username = name!
        let id = idNumber!
        MBProgressHUD.showAdded(to: view, animated: true)
        LGUserService.sharedService.verification(idNumber: id, name: username, phone: LGUserModel.currentUser.phone!) { [weak self] error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    // 认证成功
                    LGUserModel.currentUser.verificated(idNumber: id, mark: "", name: username)
                    // 发送通知
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(kNotificationVerification)
                    }
                    // 刷新页面，不可更改
                    self!.vericationTableView.reloadData()
                    self!.applyButton.setTitle("申请查询", for: .normal)
                    // 跳转芝麻信用页
                    self!.showZhimaCredit()
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
    
    private func showZhimaCredit() {
        MBProgressHUD.showAdded(to: view, animated: true)
        let name = LGUserModel.currentUser.name!
        let phone = LGUserModel.currentUser.phone!
        let idNumber = LGUserModel.currentUser.idNumber!
        LGCreditService.sharedService.getAuthorizationURL(idNumber: idNumber, name: name, phone: phone) { [weak self] urlString, error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    let url = URL(string: urlString!)!
                    let webVC = LGCreditZhimaViewController(url: url)
//                    let webVC = RxWebViewController(url: url)
                    self!.show(webVC!, sender: nil)
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGCreditCheckVericationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGVericationTableViewCell.identifier) as! LGVericationTableViewCell
            let editable = !LGUserModel.currentUser.isVerified
            
            if indexPath.row == 0 {
                cell.configCell(title: "姓名",
                                content: LGUserModel.currentUser.name,
                                placeHolder: "请输入姓名",
                                editable: editable)
                cell.delegate = self
            } else if indexPath.row == 1 {
                var idNumber: String?
                if LGUserModel.currentUser.isVerified {
                    idNumber = LGUserModel.currentUser.idNumber!
                    idNumber = idNumber!.hide(fromIndex: 6, toIndex: idNumber!.count - 2)
                } else {
                    idNumber = nil
                }
                cell.configCell(title: "身份证",
                                content: idNumber,
                                placeHolder: "请输入身份证号",
                                editable: editable)
                cell.delegate = self
            } else {
                cell.configCell(title: "手机号",
                                content: LGUserModel.currentUser.phone,
                                placeHolder: "请输入手机号",
                                editable: false)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCheckAgreementTableViewCell.identifier) as! LGCreditCheckAgreementTableViewCell
            cell.delegate = self
            return cell
        }
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailApplyTableViewCell.identifier) as! LGNormalDetailApplyTableViewCell
//            cell.backgroundColor = UIColor.clear
//            cell.configCell(title: "申请查询")
//            cell.delegate = self
//            return cell
//        }
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
        let agreeVC = LGUserAgreementViewController(nibName: nil, bundle: nil)
        show(agreeVC, sender: nil)
    }
    
    func agreementCell(_ agreementCell: LGCreditCheckAgreementTableViewCell, didChangeCheckBoxValue selected: Bool) {
        isAgree = selected
    }
}

extension LGCreditCheckVericationViewController: LGVericationTableViewCellDelegate {
    func vericationCell(_ cell: LGVericationTableViewCell, texting text: String) {
        let indexPath = vericationTableView.indexPath(for: cell)!
        if indexPath.row == 0 {
            // 姓名
            name = text
        } else {
            // 身份证
            idNumber = text
        }
        checkButtonEnable()
    }
    
    func vericationCell(_ cell: LGVericationTableViewCell, didEndEditWithText text: String) {
        let indexPath = vericationTableView.indexPath(for: cell)!
        if indexPath.row == 0 {
            // 姓名
            name = text
        } else {
            // 身份证
            idNumber = text
        }
        checkButtonEnable()
    }
}
