//
//  LGNormalDetailViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD
//import RxWebViewController

class LGNormalDetailViewController: LGViewController {
    /// 传入
    var model: LGLoanProductModel!
    
    private var detailTableView: UITableView!
    
    private var isFirstLaunch = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getLoanDetail()
        record()    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if isFirstLaunch {
//            isFirstLaunch = false
//            navigationController?.navigationBar.isHidden = true
//        }
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        navigationController?.navigationBar.isHidden = false
//    }
    
    private func setup() {
        title = model.name
        
        // 导航栏按键
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "nav_back"), for: .normal)
        backButton.setTitle("       ", for: .normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(backButtonOnClick), for: .touchUpInside)
        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem
        
        let shareButton = UIButton(type: .custom)
        shareButton.setImage(UIImage(named: "nav_share_black"), for: .normal)
        shareButton.sizeToFit()
        shareButton.addTarget(self, action: #selector(shareButtonOnClick), for: .touchUpInside)
        let shareItem = UIBarButtonItem(customView: shareButton)
        navigationItem.rightBarButtonItem = shareItem
        
        // 表单
        detailTableView = UITableView(frame: CGRect.zero, style: .grouped)
        detailTableView.rowHeight = UITableViewAutomaticDimension
        detailTableView.estimatedRowHeight = 80
        detailTableView.separatorStyle = .none
        detailTableView.showsVerticalScrollIndicator = false
        detailTableView.backgroundColor = kColorSeperatorBackground
        detailTableView.bounces = false
        detailTableView.register(LGNormalDetailHeadTableViewCell.self,
                                 forCellReuseIdentifier: LGNormalDetailHeadTableViewCell.identifier)
        detailTableView.register(LGRecommendTitleTableViewCell.self,
                                 forCellReuseIdentifier: LGRecommendTitleTableViewCell.identifier)
        detailTableView.register(LGNormalDetailContentTableViewCell.self,
                                 forCellReuseIdentifier: LGNormalDetailContentTableViewCell.identifier)
        detailTableView.register(LGNormalDetailApplyTableViewCell.self,
                                 forCellReuseIdentifier: LGNormalDetailApplyTableViewCell.identifier)
        detailTableView.register(LGNormalDetailFlowTableViewCell.self,
                                 forCellReuseIdentifier: LGNormalDetailFlowTableViewCell.identifier)
        detailTableView.register(LGNormalDetailInfoTableViewCell.self,
                                 forCellReuseIdentifier: LGNormalDetailInfoTableViewCell.identifier)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        view.addSubview(detailTableView)
        detailTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(-20)
        }
    }
    
    private func getLoanDetail() {
        if !model.isDetailed {
            MBProgressHUD.showAdded(to: view, animated: true)
            model.getDetail { [weak self] error in
                if self != nil {
                    MBProgressHUD.hide(for: self!.view, animated: true)
                    if error == nil {
                        self!.detailTableView.reloadData()
                    } else {
                        LGHud.show(in: self!.view, animated: true, text: error)
                    }
                }
            }
        }
    }
    
    private func record() {
        if LGUserModel.currentUser.isLogin {
            LGUserService.sharedService.recordBrowse(productType: 1, productID: model.id, complete: nil)
            LGUserService.sharedService.recordBehavior(behavior: .clickLoanProduct, complete: nil)
        }
    }
    
    @objc private func backButtonOnClick() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func shareButtonOnClick() {
        
    }
}

extension LGNormalDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 头部
            return 1
        } else if section == 1 {
            // 申请流程
            return 2
        } else if section == 2 {
            // 申请条件
            return 2
        } else if section == 3 {
            // 审核说明
            return 5
        } else if section == 4 {
            // 产品介绍
            return 2
        } else {
            // 立即申请
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // 头部
            let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailHeadTableViewCell.identifier) as! LGNormalDetailHeadTableViewCell
            let loanCountString = "\(model.loanMin)-\(model.loanMax)元"
            /// 单位
            var unitString: String
            var rateRangeString: String
            var repaymentString: String?
            var repayRangeString: String?
            if model.loanSign == 1 {
                unitString = "日"
            } else {
                unitString = "月"
            }
            if model.rateMin == model.rateMax {
                rateRangeString = "\(model.rateMin)%/\(unitString)"
            } else {
                rateRangeString = "\(model.rateMin)%-\(model.rateMax)%/\(unitString)"
            }
            if model.isDetailed {
                repayRangeString = "\(model.termMin!)-\(model.termMax!)\(unitString)"
                if model.repayment! == 1 {
                    repaymentString = "随借随还"
                } else {
                    repaymentString = "分期还款"
                }
            }
            cell.configCell(name: model.name,
                            logoURLString: kImageDomain.appending(model.logoString),
                            loanCount: loanCountString,
                            rateRange: rateRangeString,
                            returnType: repaymentString ?? "",
                            returnRange: repayRangeString ?? "")
            cell.delegate = self
            
            return cell
        } else if indexPath.section == 1 {
            // 申请流程
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "申请流程")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailFlowTableViewCell.identifier) as! LGNormalDetailFlowTableViewCell
                cell.configCell(flowArray: model.flowArray)
                
                return cell
            }
        } else if indexPath.section == 2 {
            // 申请条件
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "申请条件")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailContentTableViewCell.identifier) as! LGNormalDetailContentTableViewCell
                cell.configCell(content: model.condition)
                return cell
            }
        } else if indexPath.section == 3 {
            // 审核说明
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "审核说明")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailInfoTableViewCell.identifier) as! LGNormalDetailInfoTableViewCell
                if indexPath.row == 1 {
                    cell.configCell(title: "审核周期：", content: model.cycle)
                } else if indexPath.row == 2 {
                    cell.configCell(title: "审核方式：", content: model.mode)
                } else if indexPath.row == 3 {
                    cell.configCell(title: "放款时间：", content: model.loanTimeinfo)
                } else {                    
                    cell.configCell(title: "还款方式：", content: model.repayment == 1 ? "随借随还" : "分期还款")
                }
                return cell
            }
        } else if indexPath.section == 4 {
            // 产品介绍
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "产品介绍")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailContentTableViewCell.identifier) as! LGNormalDetailContentTableViewCell
                cell.configCell(content: model.introduction)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailApplyTableViewCell.identifier) as! LGNormalDetailApplyTableViewCell
            cell.configCell(title: "立即申请", enable: model.isDetailed)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section <= 3 {
            return 12
        } else {
            return CGFloat.leastNormalMagnitude
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 40 {
            navigationController?.navigationBar.isHidden = false
        } else {
            navigationController?.navigationBar.isHidden = true
        }
    }
}

extension LGNormalDetailViewController: LGNormalDetailHeaderTableViewCellDelegate {
    func headCellDidSelectBack(_ headerCell: LGNormalDetailHeadTableViewCell) {
        backButtonOnClick()
    }
}

extension LGNormalDetailViewController: LGNormalDetailApplyTableViewCellDelegate {
    func applyCellDidSubmit(_ applyCell: LGNormalDetailApplyTableViewCell) {
        let url = URL(string: model.url!)
        let webVC = LGWebViewController(url: url!)
        show(webVC!, sender: nil)
    }
}
