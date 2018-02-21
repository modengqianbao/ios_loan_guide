//
//  LGCreditCheckReportViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 17/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class LGReportViewController: LGViewController {
    /// 传入查询id
    var queryID: String!
    
    private var reportTableView: UITableView!
    private weak var headCell: LGReportHeadTableViewCell!
    
    private var model: LGCreditReportModel?
    private var shouldAnimateCell = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldAnimateCell {
            headCell.animate()
            shouldAnimateCell = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setup() {
        title = "信用报告"
        view.backgroundColor = kColorBackground
        
        reportTableView = UITableView(frame: CGRect.zero, style: .grouped)
        reportTableView.backgroundColor = kColorSeperatorBackground
        reportTableView.separatorStyle = .none
        reportTableView.showsVerticalScrollIndicator = false
        reportTableView.bounces = false
        reportTableView.register(LGReportHeadTableViewCell.self,
                                 forCellReuseIdentifier: LGReportHeadTableViewCell.identifier)
        reportTableView.register(LGReportProfileTableViewCell.self,
                                 forCellReuseIdentifier: LGReportProfileTableViewCell.identifier)
        reportTableView.register(LGReportSectionTitleTableViewCell.self,
                                 forCellReuseIdentifier: LGReportSectionTitleTableViewCell.identifier)
        reportTableView.register(LGReportContentTableViewCell.self,
                                 forCellReuseIdentifier: LGReportContentTableViewCell.identifier)
        reportTableView.register(LGReportRecordTableViewCell.self,
                                 forCellReuseIdentifier: LGReportRecordTableViewCell.identifier)
        reportTableView.register(LGReportApplyTableViewCell.self,
                                 forCellReuseIdentifier: LGReportApplyTableViewCell.identifier)
        reportTableView.register(LGReportRecommendTableViewCell.self,
                                 forCellReuseIdentifier: LGReportRecommendTableViewCell.identifier)
        reportTableView.register(LGHotProductTableViewCell.self,
                                 forCellReuseIdentifier: LGHotProductTableViewCell.identifier)
        reportTableView.delegate = self
        reportTableView.dataSource = self
        view.addSubview(reportTableView)
        reportTableView.snp.makeConstraints { [weak self] make in
            make.top.equalTo(self!.view).offset(-20)
            make.left.right.bottom.equalTo(self!.view)
        }
    }
    
    private func getData() {
        MBProgressHUD.showAdded(to: view, animated: true)
        LGCreditService.sharedService.getCreditReport(queryID: queryID) { [weak self] model, error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    self!.model = model
                    self!.reportTableView.reloadData()
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
}

extension LGReportViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 3
        } else if section == 2 || section == 3 {
            return 2
        } else if section == 4 {
            return 4
        } else if section == 5 || section == 6 {
            return 1
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // 头部
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportHeadTableViewCell.identifier) as! LGReportHeadTableViewCell
                cell.delegate = self
                headCell = cell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportProfileTableViewCell.identifier) as! LGReportProfileTableViewCell
                return cell
            }
        } else if indexPath.section == 1 {
            // 违约逾期记录
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportSectionTitleTableViewCell.identifier) as! LGReportSectionTitleTableViewCell
                cell.configCell(title: "违约逾期记录", statusString: "已验证", status: .green)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportContentTableViewCell.identifier) as! LGReportContentTableViewCell
                if indexPath.row == 1 {
                    cell.configCell(content: "历史逾期笔数：0笔")
                } else {
                    cell.configCell(content: "单笔最长逾期期数：0笔")
                }
                return cell
            }
        } else if indexPath.section == 2 {
            // 个人风险监测
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportSectionTitleTableViewCell.identifier) as! LGReportSectionTitleTableViewCell
                cell.configCell(title: "个人风险监测", statusString: "存在个人风险", status: .red)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportContentTableViewCell.identifier) as! LGReportContentTableViewCell
                cell.configCell(content: "手机号存在欺诈风险")
                return cell
            }
        } else if indexPath.section == 3 {
            // 失信记录
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportSectionTitleTableViewCell.identifier) as! LGReportSectionTitleTableViewCell
                cell.configCell(title: "失信记录", statusString: "未查得失信记录", status: .green)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportContentTableViewCell.identifier) as! LGReportContentTableViewCell
                cell.configCell(content: "未查得该身份信息的失信记录")
                return cell
            }
        } else if indexPath.section == 4 {
            // 多平台借贷记录
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportSectionTitleTableViewCell.identifier) as! LGReportSectionTitleTableViewCell
                cell.configCell(title: "多平台借贷记录", statusString: "近期较少借贷记录", status: .blue)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGReportRecordTableViewCell.identifier) as! LGReportRecordTableViewCell
                if indexPath.row == 1 {
                    cell.configCell(title: "近1周申请借贷平台数：0",
                                    nobankCount: 0,
                                    bankCount: 0)
                } else if indexPath.row == 2 {
                    cell.configCell(title: "近1个月申请借贷平台数：0",
                                    nobankCount: 0,
                                    bankCount: 0)
                } else {
                    cell.configCell(title: "近3个月申请借贷平台数：0",
                                    nobankCount: 0,
                                    bankCount: 0)
                }
                return cell
            }
        } else if indexPath.section == 5 {
            // 再次查询
            let cell = tableView.dequeueReusableCell(withIdentifier: LGReportApplyTableViewCell.identifier) as! LGReportApplyTableViewCell
            let todoDelegate = 1
            return cell
        } else if indexPath.section == 6 {
            // 为您推荐
            let cell = tableView.dequeueReusableCell(withIdentifier: LGReportRecommendTableViewCell.identifier)!
            return cell
        } else {
            // 贷款产品
            let cell = tableView.dequeueReusableCell(withIdentifier: LGHotProductTableViewCell.identifier) as! LGHotProductTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section > 0 && section < 4 {
            return 12
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

extension LGReportViewController: LGReportHeadTableViewCellDelegate {
    func headCellDidClickBack(_ headCell: LGReportHeadTableViewCell) {
        navigationController?.popViewController(animated: true)
    }
}
