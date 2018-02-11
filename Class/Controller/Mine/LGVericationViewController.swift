//
//  LGVericationViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class LGVericationViewController: LGViewController {
    private var hintView: UIView!
    private var vericationTableView: UITableView!
    private var applyButton: UIButton!
    
    private var name: String?
    private var idNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        if LGUserModel.currentUser.isVerified {
            title = "已身份认证"
            
            // 顶部提示条
            hintView = UIView()
            view.addSubview(hintView)
            hintView.snp.makeConstraints { [weak self] make in
                make.left.right.top.equalTo(self!.view)
                make.height.equalTo(0)
            }
        } else {
            title = "身份认证"
            
            // 顶部提示条
            hintView = UIView()
            hintView.backgroundColor = UIColor(red:0.99, green:0.62, blue:0.20, alpha:1.00)
            view.addSubview(hintView)
            hintView.snp.makeConstraints { [weak self] make in
                make.left.right.top.equalTo(self!.view)
                make.height.equalTo(30)
            }
            
            let hintIconImageView = UIImageView(image: UIImage(named: "hint_warn"))
            hintView.addSubview(hintIconImageView)
            hintIconImageView.snp.makeConstraints { make in
                make.centerY.equalTo(hintView)
                make.left.equalTo(hintView).offset(8)
            }
            
            let hintLabel = UILabel()
            hintLabel.textColor = UIColor.white
            hintLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            hintLabel.text = "以下信息将作为您申请贷款时的实名认证信息，请如实填写"
            hintLabel.adjustsFontSizeToFitWidth = true
            hintView.addSubview(hintLabel)
            hintLabel.snp.makeConstraints{ make in
                make.left.equalTo(hintIconImageView.snp.right).offset(4)
                make.right.equalTo(hintView).offset(-8)
                make.centerY.equalTo(hintIconImageView)
            }
        }
        
        // 表单
        vericationTableView = UITableView(frame: CGRect.zero, style: .grouped)
        vericationTableView.isScrollEnabled = false
        vericationTableView.separatorStyle = .none
        vericationTableView.register(LGVericationTableViewCell.self,
                                     forCellReuseIdentifier: LGVericationTableViewCell.identifier)
        vericationTableView.delegate = self
        vericationTableView.dataSource = self
        view.addSubview(vericationTableView)
        vericationTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(hintView.snp.bottom)
        }
        
        if !LGUserModel.currentUser.isVerified {
            // 提交按钮
            applyButton = UIButton(type: .custom)
            applyButton.backgroundColor = kColorMainTone
            applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            applyButton.setTitleColor(UIColor.white, for: .normal)
            applyButton.setTitle("提交审核", for: .normal)
            applyButton.layer.cornerRadius = 2
            applyButton.layer.masksToBounds = true
            applyButton.addTarget(self, action: #selector(applyButtonOnClick), for: .touchUpInside)
            view.addSubview(applyButton)
            applyButton.snp.makeConstraints { [weak self] make in
                make.left.equalTo(self!.view).offset(24)
                make.right.equalTo(self!.view).offset(-24)
                make.top.equalTo(self!.view).offset(200)
//                make.edges.equalTo(UIEdgeInsets(top: 150, left: 24, bottom: 12, right: 24))
                make.height.equalTo(45)
            }
            
            checkButtonEnable()
        }
    }
    
    @objc private func applyButtonOnClick() {
        view.endEditing(true)
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
                    // 退出页面
                    self!.navigationController?.popViewController(animated: true)
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
    
    private func checkButtonEnable() {
        if name != nil && !name!.isEmpty && idNumber != nil && idNumber!.count >= 16 {
            applyButton.isEnabled = true
            applyButton.backgroundColor = kColorMainTone
        } else {
            applyButton.isEnabled = false
            applyButton.backgroundColor = kColorGrey
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGVericationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            cell.configCell(title: "手机号", content: LGUserModel.currentUser.phone, placeHolder: "请输入手机号", editable: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension LGVericationViewController: LGVericationTableViewCellDelegate {
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
