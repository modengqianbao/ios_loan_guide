//
//  LGNormalDetailViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGNormalDetailViewController: LGViewController {
    
    private var isFirstLaunch = true

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFirstLaunch {
            isFirstLaunch = false
            navigationController?.navigationBar.isHidden = true
        }
//        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    
//        navigationController?.navigationBar.isHidden = false
//    }
    
    private func setup() {
        title = "马上金融"
        
        // 导航栏按键
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "nav_back"), for: .normal)
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
        let detailTableView = UITableView(frame: CGRect.zero, style: .grouped)
        detailTableView.separatorStyle = .none
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
        detailTableView.delegate = self
        detailTableView.dataSource = self
        view.addSubview(detailTableView)
        detailTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(-20)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func backButtonOnClick() {
        
    }
    
    @objc private func shareButtonOnClick() {
        
    }
}

//MARK:- UITableView delegate, datasource
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
            
            return cell
        } else if indexPath.section == 1 {
            // 申请流程
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "申请流程")
                return cell
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 2 {
            // 申请条件
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "申请条件")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailContentTableViewCell.identifier) as! LGNormalDetailContentTableViewCell
                cell.configCell(content: "18-35周岁")
                return cell
            }
        } else if indexPath.section == 3 {
            // 审核说明
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "审核说明")
                return cell
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 4 {
            // 产品介绍
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "产品介绍")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailContentTableViewCell.identifier) as! LGNormalDetailContentTableViewCell
                cell.configCell(content: "发大Shi范围长发一昂我吃放松地符合我文hi我陈红当发一昂我ifhi我 方尺文化i和ID森我真会玩吃货第五晨hiif网发我wehi红地方种地方we胡if无if很i无")
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailApplyTableViewCell.identifier) as! LGNormalDetailApplyTableViewCell            
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
