//
//  LGSpecialDetailViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD
import BRPickerView
import AVFoundation

class LGRecommendDetailViewController: LGViewController {
    /// 传入
    var model: LGLoanProductModel!
    
    private var detailTableView: UITableView!
    private var pickView: BRStringPickerView!
    private var applyButton: UIButton!
    
    private var moneyArray: [String]!
    private var selectedMoneyIndex: Int = 0
    private var termArray: [String]!
    private var selectedTermIndex: Int = 0
    private var selectedUsageIndex: Int = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getDetail()
        record()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setup() {
        title = "马上金融"
        
        // 表单
        detailTableView = UITableView(frame: CGRect.zero, style: .grouped)
        detailTableView.rowHeight = UITableViewAutomaticDimension
        detailTableView.estimatedRowHeight = 80
        detailTableView.separatorStyle = .none
        detailTableView.bounces = false
        detailTableView.backgroundColor = kColorSeperatorBackground
        detailTableView.register(LGRecommendDetailHeadTableViewCell.self,
                                 forCellReuseIdentifier: LGRecommendDetailHeadTableViewCell.identifier)
        detailTableView.register(LGRecommendCheckDetailTableViewCell.self,
                                 forCellReuseIdentifier: LGRecommendCheckDetailTableViewCell.identifier)
        detailTableView.register(LGRecommendTitleTableViewCell.self,
                                 forCellReuseIdentifier: LGRecommendTitleTableViewCell.identifier)
        detailTableView.register(LGRecommendDetailInfoTableViewCell.self,
                                 forCellReuseIdentifier: LGRecommendDetailInfoTableViewCell.identifier)
        detailTableView.register(LGRecommendDetailCreditTableViewCell.self,
                                 forCellReuseIdentifier: LGRecommendDetailCreditTableViewCell.identifier)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        view.addSubview(detailTableView)
        detailTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(-20)            
        }
        
        // 立即申请
        applyButton = UIButton(type: .custom)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        applyButton.backgroundColor = kColorMainTone
        applyButton.setTitleColor(UIColor.white, for: .normal)
        applyButton.setTitle("立即申请", for: .normal)
        applyButton.addTarget(self, action: #selector(applyButtonOnClick), for: .touchUpInside)
        applyButton.isEnabled = false
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.height.equalTo(47)
        }
    }
    
    private func setupPickArray() {
        // 计算额度数
        let limitCount = (model.loanMax - model.loanMin) / 1000
        moneyArray = [String]()
        for i in 0...limitCount {
            moneyArray.append("\(model.loanMin + i * 1000)")
        }
        
        // 计算分期数
        /// 按天算或按月算
        let unit = model.loanSign == 1 ? 30 : 1
        let count = (model.termMax! - model.termMin!) / unit
        termArray = [String]()
        for i in 0...count {
            termArray.append("\(model.termMin! + i * unit)")
        }
    }
    
    private func getDetail() {
        if !model.isDetailed {
            MBProgressHUD.showAdded(to: view, animated: true)
            model.getDetail { [weak self] error in
                if self != nil {
                    MBProgressHUD.hide(for: self!.view, animated: true)
                    if error == nil {
                        self!.setupPickArray()
                        self!.applyButton.isEnabled = true
                        self!.detailTableView.reloadData()
                    } else {
                        LGHud.show(in: self!.view, animated: true, text: error)
                    }
                }
            }
        } else {
            setupPickArray()
            applyButton.isEnabled = true
        }
    }
    
    private func record() {
        LGUserService.sharedService.recordBrowse(productType: 1, productID: model.id, complete: nil)
    }
    
    @objc private func applyButtonOnClick() {
        checkCamera()
    }
    
    private func showDetailWebView() {
        MBProgressHUD.showAdded(to: view, animated: true)
        LGLoanService.sharedService.getApplyURL(money: moneyArray[selectedMoneyIndex],
                                                usage: kLoanUsageArray[selectedUsageIndex],
                                                perids: termArray[selectedTermIndex],
                                                productID: model.id)
        { [weak self] urlString, error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    let url = URL(string: urlString!)
                    let webVC = LGWebViewController(url: url!)
                    self!.show(webVC!, sender: nil)
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
    
    private func checkCamera() {
        // 相机授权
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraStatus == .authorized {
            // 拥有相机权限，检查麦克风权限
            checkMicrophone()
        } else if cameraStatus == .notDetermined {
            // 尚未请求
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] authed in
                if authed {
                    self!.checkMicrophone()
                } else {
                    self!.showNoCameraAuthAlert()
                }
            })
        } else {
            // 无相机权限
            showNoCameraAuthAlert()
        }
    }
    
    private func checkMicrophone() {
        let microphoneStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        if microphoneStatus == .authorized {
            // 拥有麦克风权限
            showDetailWebView()
        } else if microphoneStatus == .notDetermined {
            // 尚未请求
            AVCaptureDevice.requestAccess(for: .audio, completionHandler: { [weak self] authed in
                if authed {
                    self!.showDetailWebView()
                } else {
                    self!.showNoMicrophoneAuthAlert()
                }
            })
        } else {
            // 唔麦克风权限
            showNoMicrophoneAuthAlert()
        }
    }
    
    private func showNoCameraAuthAlert() {
        let alert = UIAlertController(title: "请同意相机权限用于人像验证。", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let goSettingAction = UIAlertAction(title: "前往设置", style: .default) { _ in
            let url = URL(string: UIApplicationOpenSettingsURLString)
            if url != nil && UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(goSettingAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showNoMicrophoneAuthAlert() {
        let alert = UIAlertController(title: "请同意麦克风权限用于身份验证。", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let goSettingAction = UIAlertAction(title: "前往设置", style: .default) { _ in
            let url = URL(string: UIApplicationOpenSettingsURLString)
            if url != nil && UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(goSettingAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showCreditCheckOrReportView() {
        MBProgressHUD.showAdded(to: view, animated: true)
        LGCreditService.sharedService.getHistoryReportID { [weak self] id, error in
            MBProgressHUD.hide(for: self!.view, animated: true)
            if error == nil {
                if id != nil {
                    // 有查询历史记录
                    let reportVC = LGReportViewController()
                    reportVC.queryID = id!
                    reportVC.hidesBottomBarWhenPushed = true
                    self!.show(reportVC, sender: nil)
                } else {
                    // 无查询历史记录
                    let creditVC = LGCreditCheckFlowViewController()
                    creditVC.hidesBottomBarWhenPushed = true
                    self!.show(creditVC, sender: nil)
                }
            } else {
                LGHud.show(in: self!.view, animated: true, text: error)
            }
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGRecommendDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
        // 去掉信用相关
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // 头部
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendDetailHeadTableViewCell.identifier) as! LGRecommendDetailHeadTableViewCell
                cell.delegate = self
                if model.isDetailed {
                    let limitString = "额度\(model.loanMin)~\(model.loanMax)"
                    let stageString = "分期\(model.termMin!)~\(model.termMax!)期"
                    var rate: String
                    if model.rateMin == model.rateMax {
                        rate = "\(model.rateMin)%"
                    } else {
                        rate = "\(model.rateMin)%~\(model.rateMax)"
                    }
                    let rateString = "\(model.loanSign == 1 ? "日" : "月")利率\(rate)"
                    cell.configCell(title: model.name,
                                    currentMoney: moneyArray[selectedMoneyIndex],
                                    limitString: limitString,
                                    currentStage: "\(termArray[selectedTermIndex])\(model.loanSign == 1 ? "日" : "月")",
                                    stageRange: stageString,
                                    usage: kLoanUsageArray[selectedUsageIndex],
                                    timeString: model.loanTimeinfo!,
                                    rateString: rateString)
                }
                return cell
            } else {
                // 查看详情
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendCheckDetailTableViewCell.identifier)!
                
                return cell
            }
        } else if indexPath.section == 1 {
            // 申请材料
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "申请材料")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendDetailInfoTableViewCell.identifier) as! LGRecommendDetailInfoTableViewCell
                cell.configCell(isVerified: LGUserModel.currentUser.isVerified)
                
                return cell
            }
        } else {
            // 综合信用分
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "综合信用分")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendDetailCreditTableViewCell.identifier) as! LGRecommendDetailCreditTableViewCell
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            // 查看详情
            if model.isDetailed {
                let detailVC = LGProductDetailViewController()
                detailVC.model = model
                show(detailVC, sender: nil)
            }
        } else if indexPath.section == 1 && indexPath.row == 1 {
            // 认证页面
            let veriVC = LGVericationViewController()
            show(veriVC, sender: nil)
        } else if indexPath.section == 2 && indexPath.row == 1 {
            // 信用查询
//            showCreditCheckOrReportView()
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension LGRecommendDetailViewController: LGRecommendDetailHeadTableViewCellDelegate {
    func headCellDidClickShare(_ headCell: LGRecommendDetailHeadTableViewCell) {
        return
    }
    
    func headCellDidClickLoanMoney(_ headCell: LGRecommendDetailHeadTableViewCell) {
        BRStringPickerView.showStringPicker(withTitle: "额度", dataSource: moneyArray, defaultSelValue: moneyArray[selectedMoneyIndex], isAutoSelect: false, themeColor: kColorMainTone) { [weak self] value in
            let index = self!.moneyArray.index(of: value as! String)
            self!.selectedMoneyIndex = index!
            self!.detailTableView.reloadData()
            LGUserService.sharedService.recordBehavior(behavior: .selectLoanLimit, complete: nil)
        }
    }
    
    func headCellDidClickLoanTime(_ headCell: LGRecommendDetailHeadTableViewCell) {
        BRStringPickerView.showStringPicker(withTitle: "分期", dataSource: termArray, defaultSelValue: termArray[selectedTermIndex], isAutoSelect: false, themeColor: kColorMainTone) { [weak self] value in
            let index = self!.termArray.index(of: value as! String)
            self!.selectedTermIndex = index!
            self!.detailTableView.reloadData()
            LGUserService.sharedService.recordBehavior(behavior: .selectLoanTerm, complete: nil)
        }
    }
    
    func headCellDidClickLoanUsage(_ headCell: LGRecommendDetailHeadTableViewCell) {
        BRStringPickerView.showStringPicker(withTitle: "贷款用途", dataSource: kLoanUsageArray, defaultSelValue: kLoanUsageArray[selectedUsageIndex], isAutoSelect: false, themeColor: kColorMainTone) { [weak self] value in
            let index = kLoanUsageArray.index(of: value as! String)
            self!.selectedUsageIndex = index!
            self!.detailTableView.reloadData()
        }
    }
    
    func headCellDidClickBack(_ headCell: LGRecommendDetailHeadTableViewCell) {
        navigationController?.popViewController(animated: true)
    }
}
