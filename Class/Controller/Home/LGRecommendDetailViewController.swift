//
//  LGSpecialDetailViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGRecommendDetailViewController: LGViewController {
    /// 传入
    var model: LGLoanProductModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupNavigationBar()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
//    private func setupNavigationBar() {
//        let bar = navigationController!.navigationBar
//        bar.backgroundColor = UIColor.clear
//    }
    
    private func setup() {
        title = "马上金融"
        
        // 表单
        let detailTableView = UITableView(frame: CGRect.zero, style: .grouped)
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
        let applyButton = UIButton(type: .custom)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        applyButton.backgroundColor = kColorMainTone
        applyButton.setTitleColor(UIColor.white, for: .normal)
        applyButton.setTitle("立即申请", for: .normal)
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.height.equalTo(47)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

//MARK:- UITableView delegate, datasource
extension LGRecommendDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
